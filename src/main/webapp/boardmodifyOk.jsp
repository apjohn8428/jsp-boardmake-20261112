<%@page import="board.BoardDto"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String modifynum =  request.getParameter("bnum");
		String modifytitle =  request.getParameter("btitle"); //유저가 수정한 제목
		String modifycontent =  request.getParameter("bcontent"); //유저가 수정한 내용
		
		String sql1 = "UPDATE board SET btitle = ?, bcontent = ? WHERE bnum = ?"; //클릭한 글의 조회수 sql
		String sql2 = "SELECT * FROM board WHERE bnum = ?"; //클릭한 글 보기 sql
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/boardtest"; //마지막 자리는 테이블이 아닌 스키마 이름
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		PreparedStatement pstmt1 = null; //sql1 실행
		PreparedStatement pstmt2 = null; //sql2 실행
		ResultSet rs = null;
		BoardDto bdto = null;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setString(1, modifytitle);
			pstmt1.setString(2, modifycontent);
			pstmt1.setString(3, modifynum);
			pstmt1.executeUpdate();
			
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, modifynum); //유저가 클릭한 번호를 입력하기
			rs = pstmt2.executeQuery();
			
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
				if(pstmt1 != null) {
					pstmt1.close();
				}
				if(pstmt2 != null) {
					pstmt2.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
		}
		
		}	
	%>
	
	<h2>게시판 글 보기</h2>
	<hr>
	<p>글번호: ${boardDto.bnum}</p>
	<p>조회수: ${boardDto.bhit}</p>
	<p>제목: ${boardDto.btitle}</p>
	<p>내용: ${boardDto.bcontent}</p>
	<p>작성자: ${boardDto.bwriter}</p>
	<p>작성일: ${boardDto.bdate}</p>
	<hr>
	<a href="boardlist.jsp">목록</a>
	<a href="boardmodify.jsp?bnum=${boardDto.bnum}">수정</a>
	<a href="#">삭제</a>
</body>
</html>