
package com.tech.blog.dao;

import com.tech.blog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
     private Connection con;
    public PostDao(Connection con) {
        this.con = con;
    }
   public boolean savePost(Post p)
   {
       boolean f=false;
       try
       {
           String query="insert into post(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
           PreparedStatement ps=this.con.prepareStatement(query);
           ps.setString(1, p.getpTitle());
           ps.setString(2, p.getpContent());
           ps.setString(3, p.getpCode());
           ps.setString(4, p.getpPic());
           ps.setInt(5, p.getCatId());
           ps.setInt(6, p.getUserId());
           ps.executeUpdate();
           f=true;
       }
       catch(Exception e)
       {
           e.printStackTrace();
       }
       return f;
   }
   public List<Post> getAllPost()
   {
       List<Post> list1=new ArrayList<>();
       try
       {
           PreparedStatement ps=this.con.prepareStatement("select * from post");
           ResultSet set=ps.executeQuery();
           while(set.next())
           {
               int pId=set.getInt("pId");
               String pTitle=set.getString("pTitle");
               String pContent=set.getString("pContent");
               String pCode=set.getString("pCode");
               String pPic=set.getString("pPic");
               Timestamp pDate=set.getTimestamp("pDate");
               int catId=set.getInt("catId");
               int userId=set.getInt("userId");
               Post p=new Post(pId,pTitle,pContent,pCode,pPic,pDate,catId,userId);
               list1.add(p);
           }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return list1;
   }
   public List<Post> getPostByCatId(int catId)
   {
       List<Post> list1=new ArrayList<>();
       try
       {
           PreparedStatement ps=this.con.prepareStatement("select * from post where catId=?");
           ps.setInt(1, catId);
           ResultSet set=ps.executeQuery();
           while(set.next())
           {
               int pId=set.getInt("pId");
               String pTitle=set.getString("pTitle");
               String pContent=set.getString("pContent");
               String pCode=set.getString("pCode");
               String pPic=set.getString("pPic");
               Timestamp pDate=set.getTimestamp("pDate");
               int userId=set.getInt("userId");
               Post p=new Post(pId,pTitle,pContent,pCode,pPic,pDate,catId,userId);
               list1.add(p);
           }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return list1;
   }
}
