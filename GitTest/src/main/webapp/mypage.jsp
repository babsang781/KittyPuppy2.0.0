<%@page import="com.kittypuppy.model.MemberDAO"%>
<%@page import="com.kittypuppy.model.FollowDTO"%>
<%@page import="com.kittypuppy.model.FollowDAO"%>
<%@page import="com.kittypuppy.model.FeedDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kittypuppy.model.MemberDTO"%>
<%@page import="com.kittypuppy.model.FeedDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String nick = (String)session.getAttribute("nick");	

	MemberDAO dao = new MemberDAO();
	MemberDTO member = dao.memberInfo(nick);
    
	FeedDAO feed = new FeedDAO();
	ArrayList<FeedDTO> feedList = feed.feedSelect(nick);
	
	FollowDAO follow = new FollowDAO();
	// 나를 팔로우 하는 사람들
	ArrayList<String> followerList = follow.followerShow(nick);
	// 내가 팔로잉중인 사람들
	ArrayList<String> followingList = follow.followingShow(nick);
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <title>KittyPuppy</title>
    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&display=swap" rel="stylesheet">

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="js/bootstrap.min.js"></script>

    <!-- 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://bootsnipp.com/dist/bootsnipp.min.css" crossorigin="anonymouse">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />

    <!-- Custom styles for this template -->
    <link href="narrow-jumbotron.css" rel="stylesheet">

    <style>

        html, body{
            height:100%;
        }

        body{
        background-color: #ffffff;
        padding: 10px;
        }

        /* 로고 글꼴, 색상 설정 */
        h1{
            font-family: 'Dancing Script', cursive;
            font-size: 35px;
            color: #25aa90;
            display: inline;
        }

        .hidden {
            color : #f5e172;
            font-size : 4ch;
            margin-right:100px;
            visibility: hidden;
        }

        .report {
            color : #f5e172;
            font-size : 4ch;
            margin-left:100px;
        }

        /* 상단 로고 고정 */
        .header-logo{
            position: fixed;
            margin: 0 auto;
            left:0;
            right:0;
            top:0;
            height: 5rem;
            background-color: white;
            padding-top: 15px;
            width: 100%;
            text-align: center;
        }

        /* 상단 메뉴바 고정 */
        .header-menu{
            position: fixed;
            margin: 0 auto;
            left:0;
            right:0;
            top:5rem;
            height: 5rem;
            background-color: white;
            padding-top: 15px;
            width: 100%;
        }

        .icon {
            font-size: 4ch;
            margin-left: 15px;
            margin-right: 15px;
            color: #25aa8f7e;
        }
        
        /* 탭을 클릭했을 때 */
        .nav-link.active {
            background-color: #25aa90 !important;
            padding-left:13px;
            padding-right:13px;
            padding-top:7px;
            padding-bottom:7px;
        }

        /* 탭에 마우스를 올렸을 때 */
        .nav-link{
            color : white;
            background-color: #25aa8f7e !important;
            padding-left:13px;
            padding-right:13px;
            padding-top:7px;
            padding-bottom:7px;
        }

        .nav-link:hover {
            color : white !important;
        }

        .btn:hover{
            /* background-color: #25aa8f7e !important; */
            color : white !important;
        }

        .btn{
            background-color: #25aa90;
            color:white;
            /* width:190px;
            height: 38px;
            padding-left:13px;
            padding-right: 13px;
            padding-top: 7px;
            padding-bottom: 7px;
            border: 0px; */
        }

        .btn.update, .btn.write{
            width: 215px;
        }

        /* button{
            align-items: stretch !important;
        } */

        .row {
            align-items: center;
        }

        /* 바깥 컨테이너 설정 */
        .container.out{
            width: 100%;
            padding-left:15px;
            padding-right:15px;
            padding-bottom: 15px;;
            padding-top: 9rem;
            margin: auto;
            display:block;
            max-width: 470px;
        }

        /* 프로필 컨테이너 설정 - flexbox */
        .container.profile{
            /* Flex - 정렬을 위한 컨테이너 */
            display: flex;
            flex-wrap: wrap;
            padding:0px;

            /* 주축 방향 정렬 */
            justify-content: center;

            /* 교차축 방향 정렬 */
            align-items: center;
            text-align: center;
        }

        .container.profile-in{
            display: flex;
            
            justify-content: center;

            align-items: center;

            flex-wrap: wrap;
            padding:0px;
            flex-basis: 280px;
        }

        
        /* Flexbox 안의 아이템 모바일 */
        .item.img{
            /* margin-right: 50px; */
            flex-basis: 100px;
            height:72px;
            flex-grow: 0;
            flex-shrink: 0;
        }

        .item.post{
            flex-basis:25%;
        }

        .item.follower{
            flex-basis:25%;
        }

        .item.following{
            flex-basis:25%;
        }

        .item.nick{
            flex-basis:100%;
        }

        .item.intro{
            flex-basis:100%;
        }

        .item.update, .item.write{
            flex-basis:220px;
        }
            

        /* 스크린 사이즈에 따라 썸네일, 컨테이너 max크기 지정 */
        .img-thumbnail{
            max-width:77px;
            max-height:77px;
        }

        @media (min-width: 992px) {
            .img-thumbnail{
                max-width:150px;
                max-height:150px;
            }

            .img-thumbnail.animal{
                max-width: 90px;
                max-height: 90px;
            }

            .container.out{
                max-width:700px;
            }

            .container.profile{
                justify-content: flex-end;
                text-align: left;
            }

            .item.img{
                order:1;
                flex-basis: 35%;
                padding-top: 15px;
                height: 60px;
            }

            .item.post{
                order:5;
                flex-basis:140px;
                padding-top:15px;
                margin-bottom: 15px;
            }

            .item.follower{
                order:6;
                flex-basis:140px;
                padding-top:15px;
                margin-bottom: 15px;
            }

            .item.following{
                order:7;
                flex-basis:140px;
                padding-top:15px;
                margin-bottom: 15px;
            }

            .item.nick{
                order:2;
                flex-basis:20%;
            }

            .item.update{
                order:3;
                flex-basis:20%;
            }

            .item.write{
                order:4;
                flex-basis:20%;
            }

            .item.intro{
                order:8;
                padding-left:240px;
                margin-top:15px;
            }

            .icon {
                font-size: 40px;
                margin-left: 30px;
                margin-right: 30px;
            }

            .hidden {
                margin-right:150px;
            }

            .report {
                margin-left:150px;
            }

            .btn.update, .btn.write{
                width: 135px;
            }

        }


        ul{
            padding-right: 0px !important;
        }

        .row{
            margin:0px;
        }


        .bi {
            font-size: 40px;
        }

        .bi-person-fill{
            color:#25aa90;
        }

    </style>

   

</head>
<body>
    

        <!-- 키티퍼피 로고 -->
        <div class="header-logo">
            <i class="bi bi-exclamation-octagon-fill hidden"></i>
            <h1 class="text-center">KittyPuppy</h1>
            <a href =''><i class="bi bi-exclamation-octagon-fill report"></i></a>
        </div>
            
        <br>
        <!-- 상단 고정된 메뉴바 -->
        <div class='text-center banner header-menu'>
            <a href="feed.jsp"><i class = "bi bi-phone icon"></i></a>

            <a href="lostAniBorad.jsp"><i class="bi bi-megaphone icon"></i></a>

            <a href=""><i class="bi bi-geo-alt icon"></i></a>

            <a href="mypage.jsp"><i class="bi bi-person-fill icon"></i></a>

            <a href=""><i class = "bi bi-chat-dots icon"></i></a>
        </div>
        
         
    <!-- 상단 로고,메뉴바 밑의 내용들 담고 있는 컨테이너 -->
    <div class="container out">

         <!-- 프로필 사진, 게시물, 팔로워 팔로잉 -->
        <div class="container profile">
            
            <span class="item img ">
            <img src="https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png" class="rounded-circle img-thumbnail img-fluid float-start" alt="프로필 사진 추가">
            </span>
           
            <!-- <div class="container profile-in text-center"> -->
                <div class="item post">
                	<!-- 게시물의 갯수 -->
                	<%= feedList.size()%><br>
                    게시물
                </div>

                <div class="item follower">
                    <%= followerList.size() %><br>
                    팔로워
                </div>

                <div class="item following">
                    <%= followingList.size() %><br>
                    팔로잉
                </div>
            

                <!-- 닉네임, 프로필 소개글 -->
                
                <div class="item nick text-start mt-2 mx-2"><%=nick %></div>
                
                
                <div class="item intro text-start mb-2 mx-2"><%=member.getProfile() %></div>
                
            
            
            
                <!-- 회원정보수정, 게시물 작성 버튼 -->
                <div class="item update">
                    <button type="button" class="btn me-1 update" onclick="location.href='update.jsp' ">회원정보 수정</button>
                </div>
                <div class="item write">
                    <button type="button" class="btn ms-1 write" onclick="location.href='feedUpload.jsp' ">게시물 작성</button>
                </div>
            <!-- </div> -->
            
        </div>
        <br>

        <!-- 반려동물 사진, 추가등록 버튼 -->
        <div class="animal row">
            <div class="col-auto">
                <a><img src="https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png" class="rounded-circle img-thumbnail animal float-start" alt="프로필 사진 추가"></a>
            </div>   
            <div class="col-auto">
                <a></a><img src="https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png" class="rounded-circle img-thumbnail animal float-start" alt="프로필 사진 추가"></a>
            </div>

            <div class="col-auto">
                <a href="aniJoin.jsp"><i class="bi bi-plus-square-dotted"></i></a>
            </div>
        </div>
        
        <br>
       
        <!-- 탭 메뉴 -->
                <div class="tab row">
                    <ul class="nav nav-pills" id="myTab" role="tablist">
                        <li class="nav-item col me-1" role="presentation">
                            <button class="nav-link active w-100 btn" href="#userinfo" id="userinfo-tab" data-bs-toggle="tab"
                                " type="button" role="tab" aria-controls="userinfo"
                                aria-selected="true">스토리</button>
                        </li>
                        <li class="nav-item col ms-1" role="presentation">
                            <button class="nav-link w-100 btn" id="myreview-tab" data-bs-toggle="tab"
                                data-bs-target="#myreview" type="button" role="tab"
                                aria-controls="myreview" aria-selected="false">스크랩</button>
                        </li>
                    </ul>
                </div>
                
                <!-- 탭의 내용 -->
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="userinfo" role="tabpanel"
                        aria-labelledby="userinfo-tab">
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>
                        내 피드 게시물<br>

                    </div>
                    <div class="tab-pane fade" id="myreview" role="tabpanel"
                        aria-labelledby="myreview-tab">내가 스크랩한 게시물</div>
                    
                </div>

        <!-- 하단 고정된 메뉴바 -->
        <!-- <div class='text-center banner'>
            <a><i class="bi bi-house footer"></i></a>

            <a><i class="bi bi-megaphone footer"></i></a>

            <a><i class="bi bi-geo-alt footer"></i></a>

            <a><i class="bi bi-person footer"></i></a>

            <a><i class = "bi bi-chat-dots footer"></i></a>
        </div> -->
    </div>
        
    

    
    
    


    



    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    
    <!-- <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script> -->
    
</body>
</html>