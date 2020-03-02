pipeline {
  agent any
  stages {
    stage('error') {
      steps {
        echo 'Message 1'
        s3DoesObjectExist(bucket: 'ita212', path: 'udacity.zip')
      }
    }

  }
}