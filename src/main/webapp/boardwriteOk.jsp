<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 저장</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String btitle = request.getParameter("btitle");
		String bwriter = request.getParameter("bwriter");
		String bcontent = request.getParameter("bcontent");
		
		String sql = "INSERT INTO board(btitle, bcontent, bwriter, bhit) VALUES(?,?,?,0)";
		
		//DB 연결 준비
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/boardtest"; //마지막 자리는 테이블이 아닌 스키마 이름
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		//DB 예외처리문
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password); //DB 연결통로
			pstmt = conn.prepareStatement(sql); 
			
			//sql문 작성하기
			pstmt.setString(1, btitle);
			pstmt.setString(2, bcontent);
			pstmt.setString(3, bwriter);
			
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("게시판 작성 완료");
			} else {
				System.out.println("게시판 작성 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
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
</body>
</html>