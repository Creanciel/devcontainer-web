# devcontainer-web

Claude + TypeScript 開発向け Dev Container

- pnpm (mise 経由)
- vp (Vite+)

## Setup

### settings

このリポジトリにある .devcontainer 配下そのもの。

#### .devcontainer/Dockerfile

ベースイメージは `ghcr.io/creanciel/devcontainer-web:latest`

https://github.com/Creanciel/devcontainer-web/pkgs/container/devcontainer-web

`docker/Dockerfile` をデプロイしたもの。自前でデプロイしてもらって構わない。

Claude Code は頻繁に更新がかかるのでこちらで定義している。

```Dockerfile
FROM ghcr.io/creanciel/devcontainer-web:latest

RUN curl -fsSL https://claude.ai/install.sh | bash
```

#### .devcontainer/settings.json

お好みで Dev Container 内での Claude の設定。

```json
{
  "permissions": {
    "allow": [
      "*"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Write(./.git/**)",
      "Write(./.claude/settings.json)"
    ]
  }
}
```

#### .devcontainer/Dockerfile

Dev Container の設定

.claude/ や .claude.json がないとマウントでコケるのでもしなくても落ちないように `initializeCommand` で前処理をしている。

そのほかホスト側の Claude のディレクトリをマウントするようにしている。

```json
{
  "name": "Dev Container for Web",
  "build": {
    "dockerfile": "./Dockerfile"
  },
  "initializeCommand": [
    "bash",
    "-c",
    "mkdir -p ${localEnv:HOME}/.claude && touch ${localEnv:HOME}/.claude.json"
  ],
  "mounts": [
    "source=${localEnv:HOME}/.claude/,target=/home/development/.claude,type=bind",
    "source=${localEnv:HOME}/.claude.json,target=/home/development/.claude.json,type=bind",
    "source=${localWorkspaceFolder}/.devcontainer/settings.json,target=/home/development/.claude/settings.json,type=bind",
    "source=${localWorkspaceFolder},target=/devcontainer_web,type=bind"
  ],
  "workspaceFolder": "/devcontainer_web",
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.cwd": "/devcontainer_web",
        "terminal.integrated.defaultProfile.linux": "bash"
      },
      "extensions": [
        "anthropic.claude-code",
        "VoidZero.vite-plus-extension-pack"
      ]
    }
  }
}
```

### Open

VSCode で .devcontainer 配下に上記ファイルを置き、 Ctrl + Shift + p でコマンドパレットを開き、 `Dev Containers: Reopen in Container` を選択
