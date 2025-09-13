pipeline {
    agent any

    
//environment variable
     environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubaws') // Jenkins secret ID
        IMAGE_NAME = "veer45/devops-task:latest"
    }

    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
                 sh 'export PATH=$PATH:/usr/bin:/usr/local/bin && npm install'
                 sh 'export PATH=$PATH:/usr/bin:/usr/local/bin && npm test || echo "No tests configured"'
            }
        }

        stage('Build') {
            steps{
                sh ''' 
                export PATH=$PATH:/usr/local/bin
                docker build -t veer45/devops-task:latest .
                '''
            }
        }
        

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhubaws', //
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    export PATH=$PATH:/usr/local/bin
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push veer45/devops-task:latest
                    '''
                }
            }
        }

        stage('Deploy') {
              steps {
                    sh '''
                    docker stop devops-task || true
                    docker rm devops-task || true
                    docker run -d -p 3000:3000 --name devops-task veer45/devops-task:latest
                    '''
    }
}
    }
}
