<%@page import="board.BoardDto"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 수정</title>
</head>
<body>
	<%
		String viewnum =  request.getParameter("bnum"); //유저가 클릭한 글번호
		
		String sql = "SELECT * FROM board WHERE bnum = ?"; //수정할 글 보기 sql
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/boardtest"; //마지막 자리는 테이블이 아닌 스키마 이름
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		PreparedStatement pstmt = null; //sql2 실행
		ResultSet rs = null;
		BoardDto bdto = null;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, viewnum); //유저가 클릭한 번호를 입력하기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int bnum = rs.getInt("bnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bwriter = rs.getString("bwriter");
				int bhit = rs.getInt("bhit");
				String bdate = rs.getString("bdate");
					
				bdto = new BoardDto(bnum, btitle, bcontent, bwriter, bhit, bdate);
				
			} else {
				System.out.println("존재하지 않는 글입니다");
			}
			
			request.setAttribute("boardDto", bdto);
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
		}
		
		}	
	%>
	
	<h2>내용 수정하기</h2>
	<hr>
	<form action="boardmodifyOk.jsp">
		<input type="hidden" name="bnum" value="${boardDto.bnum}">
		글번호: ${boardDto.bnum} <br><br>
		작성자: ${boardDto.bwriter} <br><br>
		제목: <input type="text" name="btitle" size="50" value="${boardDto.btitle}"> <br><br>
		내용: <textarea rows="10" cols="50" name="bcontent">${boardDto.bcontent}</textarea> <br><br>
		<input type="submit" value="수정하기">
	</form>
</body>
</html>