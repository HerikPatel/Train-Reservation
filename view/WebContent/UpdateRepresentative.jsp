<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
try{
	String ses2=(String)session.getAttribute("type");
	  System.out.println(ses2);
	 
	    if(ses2 != null)
	    {
	  	if(!ses2.equals("A"))
	 	{
	          response.sendRedirect("logout.jsp");
	    }
	    }
	    
	    else
	    {
	  	  System.out.println("Redirecting to login page");
	          response.sendRedirect("index.jsp");
	    }
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();

	String ssn = request.getParameter("ssn");
	String password = request.getParameter("password").equals("") ? "" : String.format("password = '%s',", request.getParameter("password"));
	String username = request.getParameter("username").equals("") ? "" : String.format("username = '%s',", request.getParameter("username"));
	String firstname = request.getParameter("firstname").equals("") ? "" : String.format("firstname = '%s',", request.getParameter("firstname"));
	String lastname = request.getParameter("lastname").equals("") ? "" : String.format("lastname = '%s',", request.getParameter("lastname"));
	
	String changeList = password + username + firstname + lastname;
	changeList = changeList.equals("") ? "" : changeList.substring(0, changeList.length()-1);
	
	if(ssn != null) {
		Statement st = con.createStatement();
		String updateQry =String.format("update employee set %s where ssn = '%s'", 
				changeList, ssn);
		System.out.println(updateQry);
		st.executeUpdate(updateQry);
		response.sendRedirect("ManageRepresentatives.jsp");
	}else { 
		out.println("Something went wrong, <a href='AdminConsole.jsp'> Go back to admin console. </a>");
	}
	 
}

catch(Exception ex){
	System.out.println("Login failed");
}



%>



</body>
</html>