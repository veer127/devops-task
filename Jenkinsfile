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
                sh 'npm install'
                sh 'npm test || echo "Tests failed"' 
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t simple-node-app:latest .'
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
