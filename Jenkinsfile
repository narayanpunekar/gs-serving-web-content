pipeline {
    agent any  
    options { timeout(time: 30) }
    stages {
        stage("Stage One") {
            steps {
                sleep 30
            }
        }
        stage("Stage Two") {
            steps {
                echo 'Hello, World web site with Spring'
            }
        }
        stage("Checkout") {
            steps {
                echo 'git url: https://github.com/narayanpunekar/gs-serving-web-content.git'
                git url: 'https://github.com/narayanpunekar/gs-serving-web-content.git'
            }
        }
        stage("Compile") {
            steps {
                sh "mvn clean compile"
            }
        }
        stage("Unit Test") {
            steps {
                sh "mvn test"
            }
        }
		stage("Package") {
            steps {
                sh "mvn package"
            }
		}
		stage("Docker build") {
			steps {
				sh "docker build -t npunekar/gs-serving-web-content ."
			}
		}
		stage("Docker push") {
			steps {
				sh "cat ./password | docker login --username npunekar --password-stdin"  
				sh "docker push npunekar/gs-serving-web-content"
				sh "docker logout" 
			}
		}
		stage("Deploy to staging") {
			steps { 
				sh "docker container rm -f gs-serving-web-content-app" 
				sh "docker run -d -p 8763:8080 --name gs-serving-web-content-app npunekar/gs-serving-web-content"
			}
		}
    }
    post {
        always {
            mail to: 'narayan.v.punekar@gmail.com',
            subject: "Completed Pipeline: ${currentBuild.fullDisplayName}", 
            body: "Build completed, ${env.BUILD_URL}"
        }
    }
} 

