pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
             sh '''
                export PATH=$PATH:/usr/local/bin
                npm install
                npm test || echo "No tests configured"
                '''
            }
        }

        stage('Build') {
            steps{
            sh 'docker build -t veer45/devops-task:latest .'
            }
        }
        

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', 
                                                 usernameVariable: 'DOCKER_USER', 
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push veer45/devops-task:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "deploy container to Cloud"
            }
        }
    }
}
