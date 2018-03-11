<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <title>Thank You!</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300" />
    <link rel="stylesheet" type="text/css" href="../assets/style.css">
    <style>
        div {
            text-align: center;
            display: table;
            width: 50%;
            max-width: 1336px;
            border-radius: 5px;
            background-color: #f2f2f2;
        }

        .center {
            margin: auto;
            width: 60%;
            padding: 10px 20px;
            border-radius: 5px;
        }

        @media screen and (max-width: 700px) {
            .center {
                width: 90%;
            }
        }

    </style>
</head>

<body>
    <header>
        <h1>
            <a href="index.html">Blake Trebelhorn</a>
        </h1>
    </header>
    <nav>
        <ul>
            <!--https://css-tricks.com/fighting-the-space-between-inline-block-elements/ -->
            <li><a href="../index.html">Home</a></li>
            <li><a href="../hobbies/index.html">Hobbies</a></li>
            <li><a href="../contact/index.html" class="active">Contact</a></li>
            <li><a href="../resume/index.html">R&eacute;sum&eacute;</a></li>
        </ul>
    </nav>
    <?php
        $to = "blake.trebelhorn@drake.edu";
        $subject = $_POST["subject"];
        $message = $_POST["message"];
        $email_from= $_POST["email"];
        $headers = "From: ".$email_from."\r\n". "Reply-To: ".$email_from."\r\n";
        mail($to,$subject,$message,$headers);
    ?>
        <div class="center">
            <h1>Thank you!</h1>
            <?php
            echo $_POST["name"];
        ?>
                <h3>For your message:</h3>
                <?php
            echo $message;
        ?>
        </div>
        <footer>
            <a href="https://twitter.com/TrebelMaker" target="_blank"><img src="../assets/images/twitter.png" alt="Twitter" /></a> &nbsp;
            <a href="https://facebook.com/blake.trebelhorn" target="_blank"><img src="../assets/images/facebook.png" alt="Facebook" /></a> &nbsp;
            <a href="https://drake.edu" target="_blank"><img src="../assets/images/drake.png" alt="Drake" /></a> &nbsp;
            <a href="https://github.com/BlakeTrebelhorn" target="_blank"><img src="../assets/images/github.png" alt="GitHub" /></a>
            <a href="https://validator.w3.org/check?url=referer" target="_blank"><img src="https://validator.w3.org/images/HTML5_Badge_32.png" alt="HTML Icon" /></a>
            <a href="https://jigsaw.w3.org/css-validator/check?url=referer" target="_blank"><img src="https://www.w3.org/Icons/valid-css" style="width: auto" alt="CSS Icon" /></a>
            <br /> Blake Trebelhorn
        </footer>
</body>

</html>
