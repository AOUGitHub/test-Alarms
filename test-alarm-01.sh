instanceId=`curl -s http://169.254.169.254/latest/meta-data/instance-id`
hostName=`curl -s http://169.254.169.254/latest/meta-data/hostname`

aws cloudwatch put-metric-alarm  \
--alarm-name "$instanceId CPU-Usage" \
--alarm-description "Alarm when CPU exceeds 70%" \
--metric-name node_cpu_utilization \
--namespace ContainerInsights \
--statistic Maximum \
--period 180 \
--threshold 70 \
--comparison-operator GreaterThanThreshold \
--dimensions Name=InstanceId,Value=$instanceId Name=NodeName,Value=$hostName Name=ClusterName,Value=OSS-EKS-Cluster-02 \
--evaluation-periods 2 \
--alarm-actions arn:aws:sns:eu-west-3:390623597627:OSS_Test_CloudWatch_Alarms_Topic \
--unit Percent
