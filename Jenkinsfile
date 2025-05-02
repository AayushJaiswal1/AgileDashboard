pipeline {
    agent any

    stages {
        stage('Clone Code') {
            steps {
                git 'https://github.com/AayushJaiswal1/AgileDashboard.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t agile-dashboard .'
            }
        }

        stage('Run App Container') {
            steps {
                sh '''
                docker stop flask-app || true
                docker rm flask-app || true
                docker run -d -p 5000:5000 --name flask-app agile-dashboard
                '''
            }
        }
    }
}

