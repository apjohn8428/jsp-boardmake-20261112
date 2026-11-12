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
		String viewNum = request.getParameter("bnum"); //유저가 수정하려는 글 번호
		
		String sql = "SELECT * FROM board WHERE bnum=?"; 
		//유저가 수정하려고 하는 글 번호 내용 가져오기
		
		String driverName = "com.mysql.jdbc.Driver"; 
		String url = "jdbc:mysql://localhost:3306/boardtest"; //db이름(스키마이름)
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		PreparedStatement pstmt = null;		
		ResultSet rs = null; //DB로부터 반환하는 레코드(게시글)를 받는 그릇
		BoardDto bDto = null;
				
		try {
			Class.forName(driverName); //jdbc 드라이버 로딩
			conn = DriverManager.getConnection(url, username, password);
			//DB와 jsp 서버간의 connenction(연결통로)가 생성
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, viewNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int bnum = rs.getInt("bnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bwriter = rs.getString("bwriter");
				int bhit = rs.getInt("bhit");
				String bdate = rs.getString("bdate");
				
				bDto = new BoardDto(bnum, btitle, bcontent, bwriter, bhit, bdate);
				
			} else {
				System.out.println("존재하지 않는 글입니다.");
			}
			
			//유저가 클릭한 글 1개만 저장
			request.setAttribute("boardDto", bDto);
				
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try{
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
				
			}
		}
	%>
	
	<h2>내용 수정하기</h2>
	<hr>
	<form action="boardmodifyOk.jsp">
		<input type="hidden" name="bnum" value="${boardDto.bnum}">
		번호 : ${boardDto.bnum}<br><br>
		작성자 : ${boardDto.bwriter}<br><br>
		제목 : <input type="text" name="btitle" value="${boardDto.btitle}" size="50"><br><br>
		내용 : <textarea rows="10" cols="50" name="bcontent">${boardDto.bcontent}</textarea><br><br>
		<input type="submit" value="수정완료">
		<!--  하이퍼링크 버튼 -->
		<!--  <input type="button" value="취소" onclick="location.href='boardList.jsp'"> -->
		<input type="button" value="취소" onclick="history.go(-1)">
		<!-- 뒤로 가기 버튼 -->
	</form>
</body>
</html>