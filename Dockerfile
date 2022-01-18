FROM 811938384917.dkr.ecr.cn-northwest-1.amazonaws.com.cn/kcr/kesci_kernel_lab:datascience-r-4.1.1

MAINTAINER Widget_An <anchunyu@heywhale.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

COPY sources.list /etc/apt/

RUN apt-get update && apt-get -y upgrade && apt-get autoremove && apt-get autoclean
RUN apt-get install -y apt-utils libharfbuzz-dev libfribidi-dev libfreetype6-dev wget openjdk-17-jdk libexpat-dev sqlite3 libsqlite3-dev cargo libpq-dev libmariadbclient-dev file

RUN cd /home/mw && mkdir .cargo

COPY config /home/mw/.cargo/

RUN R -e "install.packages(c('gifski'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN cd /opt && mkdir tools && cd /opt/tools \
    && wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.3/sratoolkit.2.11.3-ubuntu64.tar.gz \
    && tar -xvzf sratoolkit.2.11.3-ubuntu64.tar.gz \
    && rm sratoolkit.2.11.3-ubuntu64.tar.gz

RUN cd /opt/tools \
    && wget https://file-1258430491.cos.ap-shanghai.myqcloud.com/fastqc_v0.11.5.zip \
    && unzip fastqc_v0.11.5.zip \
    && rm fastqc_v0.11.5.zip

RUN cd /opt/tools \
    && wget https://github.com/torognes/vsearch/releases/download/v2.19.0/vsearch-2.19.0-linux-x86_64.tar.gz \
    && tar xzf vsearch-2.19.0-linux-x86_64.tar.gz \
    && rm vsearch-2.19.0-linux-x86_64.tar.gz

RUN chmod -R 777 /opt/tools

RUN conda install -y r-units
RUN conda install -c conda-forge libgdal jq proj
RUN conda install -c conda-forge av

RUN R -e "install.packages('udunits2', dependencies=TRUE, repos='http://cran.rstudio.com/')"

ARG C_INCLUDE_PATH=/usr/include/freetype2/
ARG CPLUS_INCLUDE_PATH=/usr/include/freetype2/

RUN cp /opt/conda/lib/pkgconfig/fontconfig.pc /usr/local/lib/pkgconfig/ && R -e "install.packages('systemfonts', dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN R -e "install.packages(c('ggpubr'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('BiocManager'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('TH.data'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "options(BioC_mirror='https://mirrors.tuna.tsinghua.edu.cn/bioconductor'); BiocManager::install(version = '3.14')"

RUN R -e "options(BioC_mirror='https://mirrors.tuna.tsinghua.edu.cn/bioconductor'); BiocManager::install(c('MicrobiotaProcess', update = TRUE, dependencies=TRUE))"

RUN R -e "install.packages(c('jqr'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('V8'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('av'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('textshaping'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN cd /opt && cd tools && wget https://mirrors.tuna.tsinghua.edu.cn/CRAN/src/contrib/ragg_1.2.1.tar.gz && R CMD INSTALL ragg_1.2.1.tar.gz --configure-vars='INCLUDE_DIR=/usr/include/freetype2/  LIB_DIR=/opt/conda/lib/'

RUN R -e "install.packages(c('lwgeom'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN', configure.args='--with-proj-include=/opt/conda/include/ --with-proj-lib=/opt/conda/lib/')"

RUN R -e "install.packages(c('ggplot2'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e " install.packages(c('Lahman'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e " install.packages(c('pacman'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e " install.packages(c('magrittr'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e " install.packages(c('reshape2'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e " install.packages(c('dplyr'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "install.packages(c('tidyverse'), dependencies=TRUE, repos='https://mirrors.tuna.tsinghua.edu.cn/CRAN')"

RUN R -e "options(BioC_mirror='https://mirrors.tuna.tsinghua.edu.cn/bioconductor'); BiocManager::install(c('mixOmics'), update = TRUE, dependencies=TRUE)"

RUN R -e "options(BioC_mirror='https://mirrors.tuna.tsinghua.edu.cn/bioconductor'); BiocManager::install(c('phyloseq'), update = TRUE, dependencies=TRUE)"

RUN R -e "install.packages(c('ggsci', 'patchwork', 'openxlsx', 'vegan', 'scales', 'ggh4x', 'ggvenn'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
