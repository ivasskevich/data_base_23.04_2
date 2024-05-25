use Academy

SELECT d.Building
FROM Departments d
GROUP BY d.Building
HAVING SUM(d.Financing) > 100000;


SELECT g.Name
FROM Groups g
JOIN Departments d ON g.DepartmentId = d.Id
JOIN GroupsLectures gl ON g.Id = gl.GroupId
JOIN Lectures l ON gl.LectureId = l.Id
WHERE g.Year = 5
    AND d.Name = 'Software Development'
    AND DATEPART(week, l.Date) = 1
GROUP BY g.Name
HAVING COUNT(l.Id) > 10;


DECLARE @d221_rating FLOAT = (
    SELECT AVG(s.Rating)
    FROM Students s
    JOIN GroupsStudents gs ON s.Id = gs.StudentId
    JOIN Groups g ON gs.GroupId = g.Id
    WHERE g.Name = 'D221'
);


DECLARE @avg_prof_salary MONEY = (
    SELECT AVG(t.Salary)
    FROM Teachers t
    WHERE t.IsProfessor = 1
);


SELECT g.Name
FROM Groups g
JOIN GroupsCurators gc ON g.Id = gc.GroupId
GROUP BY g.Name
HAVING COUNT(gc.CuratorId) > 1;


DECLARE @min_rating_5th_year INT = (
    SELECT MIN(AVG(s.Rating))
    FROM Groups g
    JOIN GroupsStudents gs ON g.Id = gs.GroupId
    JOIN Students s ON gs.StudentId = s.Id
    WHERE g.Year = 5
    GROUP BY g.Name
);


DECLARE @cs_fund MONEY = (
    SELECT SUM(d.Financing)
    FROM Departments d
    JOIN Faculties f ON d.FacultyId = f.Id
    WHERE f.Name = 'Computer Science'
);


SELECT s.Name AS SubjectName, t.Name + ' ' + t.Surname AS TeacherFullName
FROM Lectures l
JOIN Subjects s ON l.SubjectId = s.Id
JOIN Teachers t ON l.TeacherId = t.Id
GROUP BY s.Name, t.Name, t.Surname
HAVING COUNT(l.Id) = (
    SELECT MAX(lecture_count)
    FROM (
        SELECT s2.Name, COUNT(l2.Id) AS lecture_count
        FROM Lectures l2
        JOIN Subjects s2 ON l2.SubjectId = s2.Id
        GROUP BY s2.Name
    ) AS subject_lecture_count
);


SELECT TOP 1 s.Name
FROM Subjects s
JOIN Lectures l ON s.Id = l.SubjectId
GROUP BY s.Name
ORDER BY COUNT(l.Id) ASC;


SELECT COUNT(DISTINCT gs.StudentId) AS StudentCount
FROM Groups g
JOIN Departments d ON g.DepartmentId = d.Id
JOIN GroupsStudents gs ON g.Id = gs.GroupId
WHERE d.Name = 'Software Development';


SELECT COUNT(DISTINCT l.SubjectId) AS SubjectCount
FROM Groups g
JOIN Departments d ON g.DepartmentId = d.Id
JOIN GroupsLectures gl ON g.Id = gl.GroupId
JOIN Lectures l ON gl.LectureId = l.Id
WHERE d.Name = 'Software Development';

