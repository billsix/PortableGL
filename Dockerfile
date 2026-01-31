FROM registry.fedoraproject.org/fedora:43


COPY backends /portablegl/backends/
COPY clib.json /portablegl/clib.json
COPY demos /portablegl/demos/
COPY Dockerfile /portablegl/Dockerfile
COPY examples /portablegl/examples/
COPY external /portablegl/external/
COPY glcommon /portablegl/glcommon/
COPY LICENSE /portablegl/LICENSE
COPY Makefile /portablegl/Makefile
COPY media /portablegl/media/
COPY portablegl.h /portablegl/portablegl.h
COPY README.md /portablegl/README.md
COPY src /portablegl/src/
COPY testing /portablegl/testing/
COPY entrypoint/dotfiles/ /root/
COPY entrypoint/*.sh /usr/local/bin
COPY entrypoint/entrypoint.sh /

RUN  --mount=type=cache,target=/var/cache/libdnf5 \
     --mount=type=cache,target=/var/lib/dnf \
     echo "keepcache=True" >> /etc/dnf/dnf.conf && \
     dnf upgrade -y && \
     dnf install -y \
                   assimp \
                   assimp-devel \
                   bear \
		   clang \
                   clang-tools-extra \
		   gcc \
		   gdb \
		   lldb \
		   llvm \
                   premake \
		   SDL2 \
		   SDL2-devel \
                   tmux \
                   which && \
       dnf install -y \
                   libglvnd-gles \
                   libXcomposite \
                   libXcursor \
                   libXdamage \
                   libXfixes \
                   libXft \
                   libXi \
                   libXinerama \
                   libXmu \
                   libXrandr \
                   libXrender \
                   libXres \
                   libXtst \
                   libXv \
                   libXxf86vm \
                   mesa-dri-drivers  \
                   mesa-libGLU-devel && \
      dnf install -y \
                  emacs \
                  emacs-gtk+x11 \
                  emacs-pgtk && \
      emacs --batch --load /root/.emacs.d/install-melpa-packages.el && \
      echo "alias ls='ls --color=auto'" >> ~/.bashrc ;\
    echo "exit() {" >> ~/.bashrc && \
    echo "    echo "Formatting on shell exit"" >> ~/.bashrc && \
    echo "    format.sh" >> ~/.bashrc && \
    echo "    builtin exit "$@"" >> ~/.bashrc && \
    echo "}" >> ~/.bashrc && \
    echo "cd /portablegl/" >> ~/.bashrc && \
    echo "PS1='\[\e[36m\]┌─(\t) \[\e[32m\]\u@\h:\w\n\[\e[36m\]└─λ \[\e[0m\]'" >> ~/.bashrc


RUN echo 'set debuginfod enabled off' > /root/.gdbinit && \
    echo "export CC=clang" >> ~/.bashrc && \
    echo "export CXX=clang++" >> ~/.bashrc


RUN cd /portablegl/examples && \
    bear -- make && \
    cd /portablegl/demos && \
    bear -- make




COPY entrypoint/dotfiles/.lldbinit /root/.lldbinit

ENTRYPOINT ["/entrypoint.sh"]
