
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out=resp.getWriter();
        String email=req.getParameter("email");
        String password=req.getParameter("password");
        UserDao dao=new UserDao(ConnectionProvider.getConnection());
        User u=dao.getUserEmailAndPassword(email, password);
        if(u==null)
        {
            //out.println("Something went wrong");
            Message m=new Message("Invalid detail ! try with another","error message","alert-danger");
            HttpSession s=req.getSession();
            s.setAttribute("msg", m);
            resp.sendRedirect("login_page.jsp");
        }
        else
        {
            HttpSession s=req.getSession();
            s.setAttribute("currentuser", u);
            resp.sendRedirect("profile.jsp");
        }
    }
    
}
