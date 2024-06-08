pipeline {
    agent any
    triggers {
        cron('0 18 * * *') // run daily at 18:00
    }
    environment {
        REPO_URL = credentials('repo-url')
        AWS_PROFILE = credentials('aws-profile')
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    git "${REPO_URL}"
                }
            }
        }
        stage('Build Packages') {
            steps {
                script {
                    docker.build('vyos-apt-builder').inside {
                        sh 'scripts/build_packages.sh'
                    }
                }
            }
        }
        stage('Update APT Repo') {
            steps {
                script {
                    docker.build('vyos-apt-builder').inside {
                        sh 'scripts/update_repo.sh'
                    }
                }
            }
        }
        stage('Upload to R2') {
            steps {
                script {
                    docker.build('vyos-apt-builder').inside {
                        withCredentials([string(credentialsId: 'aws-profile', variable: 'AWS_PROFILE')]) {
                            sh 'scripts/upload_repo.sh'
                        }
                    }
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
