<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
	<h2>게시판 글쓰기</h2>
	<hr>
	<form action="boardwriteOk.jsp" method="get">
		글 제목: <input type="text" name="btitle" size="50"> <br><br>
		글 작성자: <input type="text" name="bwriter"> <br><br>
		글 내용: <textarea rows="10" cols="50" name="bcontent"></textarea> <br><br>
		<input type="submit" value="등록">
		<input type="button" value="취소" onclick="history.go(-1)">
	</form>
</body>
</html>