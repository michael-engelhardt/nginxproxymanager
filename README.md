# Install Nginx Proxy Manager for Ubuntu with Docker

### Make the file executable!
```bash
sudo chmod +x generate_credentials.sh
```

### Generate Credentials
Change the Path if you need to
```bash
sudo /home/${USER}/nginxproxymanager/generate_credentials.sh
```

### Compose the Container up
```bash
sudo docker-compose up -d
```


To the Script type in:
```bash
sudo rm -rf generate_credentials.sh
```
