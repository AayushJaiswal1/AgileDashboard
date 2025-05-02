pipeline {
    agent any

    environment {
        IMAGE_NAME = "agile-dashboard"
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/AayushJaiswal1/AgileDashboard.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run App Container') {
            steps {
                sh 'docker run -d -p 5000:5000 --name agile-dashboard $IMAGE_NAME'
            }
        }
    }
}
