FROM python:3.9-slim

# Системные зависимости
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Ansible
RUN pip install --no-cache-dir ansible ansible-core

WORKDIR /infra

COPY . .

# Кладём ansible.cfg в /etc/ansible/
RUN mkdir -p /etc/ansible && \
    cat > /etc/ansible/ansible.cfg <<'EOF'
[defaults]
host_key_checking = False
remote_user=ansible

[privilege_escalation]
become = True
become_user = root
become_method = sudo
EOF

ENV ANSIBLE_CONFIG=/etc/ansible/ansible.cfg
