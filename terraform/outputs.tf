output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "post_apply_instructions" {
  value = <<EOT

───────────────────────────────────────────────────────────────────────────────────────────────────────────────
✨                      Thank you for deploying SimpleTimeService to EKS!                                    ✨
───────────────────────────────────────────────────────────────────────────────────────────────────────────────
 ____  _                 _     _____ _                ____                  _          
/ ___|(_)_ __ ___  _ __ | | __|_   _(_)_ __ ___   ___/ ___|  ___ _ ____   _(_) ___ ___ 
\___ \| | '_ ` _ \| '_ \| |/ _ \| | | | '_ ` _ \ / _ \___ \ / _ | '__\ \ / | |/ __/ _ \
 ___) | | | | | | | |_) | |  __/| | | | | | | | |  __/___) |  __| |   \ V /| | (_|  __/
|____/|_|_| |_| |_| .__/|_|\___||_| |_|_| |_| |_|\___|____/ \___|_|    \_/ |_|\___\___|
                  |_|                                                                  
───────────────────────────────────────────────────────────────────────────────────────────────────────────────


✅ EKS cluster simpletimeservice-eks is now up and running!

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
🔍 Monitor your Ingress status live:
    kubectl get ingress simpletimeservice-ingress -n default --watch


🌐 Get your app's public URL:
    echo "Your app is live at: http://$(kubectl get ingress simpletimeservice-ingress -n default -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"


────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
                            🚀 You're ready to roll! Happy shipping!

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

EOT
}
