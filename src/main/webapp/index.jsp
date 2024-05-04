<html>
<body>
<h1>Hi........ Hellow world!!!!!!!!!!</h1>
<h1>This is simple java web application</h1>
<h1>Jenkins integartion with Git, Maven, sonar and Docker</h1>
<p>pipeline {
    agent {
            label 'slave1'
        }
        tools {
          maven 'maven-3.9.6'  
        }
		 environment {
         SCANNER_HOME=tool 'sonar-scanner'
     }

       stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
          stage('Git clone') {
            steps {
               git credentialsId: 'git-creds', url: 'https://github.com/jyoshikanchana/Maven1.git'
            }
        }
         stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
			}
			stage('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
			}
	    stage('docker image build') {
         steps {
           script {
              withDockerRegistry(credentialsId: 'docker-creds', toolName: 'docker') {
               sh '''
                 docker build -t javawebapp .
                 docker tag javawebapp:latest kanchanajyoshi/javawebapp:latest
                 docker push kanchanajyoshi/javawebapp:latest
             	 '''
                }   
             }
         }
       }
	   stage('Docker run') {
           steps {
            sh 'docker run -d -p 8090:8080 kanchanajyoshi/javawebapp:latest'
            }
       }
	   }
	   }
</p>


</body>
</html>
