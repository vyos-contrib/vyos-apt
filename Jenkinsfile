pipeline {
    agent any
    triggers {
        cron('0 18 * * *') // run daily on 18:00
    }
    environment {
        REPO_URL = credentials('repo-url')
    }    
    stages {
        stage('Checkout') {
            steps {
                git "${REPO_URL}"
            }
        }
        stage('Build Packages') {
            steps {
                sh 'scripts/build_packages.sh'
            }
        }
        stage('Update APT Repo') {
            steps {
                sh 'scripts/update_repo.sh'
            }
        }
        stage('Upload to R2') {
            steps {
                withCredentials([string(credentialsId: 'aws-profile', variable: 'AWS_PROFILE')]) {
                    sh 'scripts/upload_repo.sh'
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '**/output/**/*.deb', allowEmptyArchive: true
            cleanWs()
        }
    }
}
