pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        echo 'Message 1'
        s3DoesObjectExist(bucket: 'arn:aws:s3:::ita212', path: 'udacity.zip')
      }
    }

  }
}