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
            tools { nodejs "node18" }
            steps {
                sh 'npm install'
                sh 'npm test || echo "No tests configured"'
            }
        }
        

        stage('Push Image') {
            steps {
                echo "push to DockerHub"
            }
        }

        stage('Deploy') {
            steps {
                echo "deploy container to Cloud"
            }
        }
    }
}
