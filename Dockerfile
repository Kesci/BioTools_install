FROM ubuntu:latest

MAINTAINER Widget_An <anchunyu@heywhale.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get -y upgrade && apt-get autoremove && apt-get autoclean
RUN apt-get install -y wget openjdk-17-jdk && cd /opt && mkdir tools

RUN cd /opt/tools \
    && wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.3/sratoolkit.2.11.3-ubuntu64.tar.gz \
    && tar -xvzf sratoolkit.2.11.3-ubuntu64.tar.gz \
    && rm sratoolkit.2.11.3-ubuntu64.tar.gz

ENV PATH=$PATH:/opt/tools/sratoolkit.2.11.3-ubuntu64/bin

RUN cd /opt/tools \
    && wget https://file-1258430491.cos.ap-shanghai.myqcloud.com/fastqc_v0.11.5.zip \
    && unzip fastqc_v0.11.5.zip \
    && rm fastqc_v0.11.5.zip

ENV PATH=$PATH:/opt/tools/FastQC

RUN cd /opt/tools \
    && wget https://github.com/torognes/vsearch/releases/download/v2.19.0/vsearch-2.19.0-linux-x86_64.tar.gz \
    && tar xzf vsearch-2.19.0-linux-x86_64.tar.gz \
    && rm vsearch-2.19.0-linux-x86_64.tar.gz

RUN cd /opt \
    && mkdir packages \
    && cd packages \
    && wget https://cran.r-project.org/src/contrib/Archive/pacman/pacman_0.5.0.tar.gz \
    && R CMD INSTALL pacman_0.5.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/magrittr/magrittr_1.5.tar.gz \
    && R CMD INSTALL magrittr_1.5.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/reshape2/reshape2_1.4.tar.gz \
    && R CMD INSTALL reshape2_1.4.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_1.0.6.tar.gz \
    && R CMD INSTALL dplyr_1.0.6.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggsci/ggsci_2.8.tar.gz \
    && R CMD INSTALL ggsci_2.8.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggplot2/ggplot2_3.3.4.tar.gz \
    && R CMD INSTALL ggplot2_3.3.4.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggrepel/ggrepel_0.9.0.tar.gz \
    && R CMD INSTALL ggrepel_0.9.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/cowplot/cowplot_1.1.0.tar.gz \
    && R CMD INSTALL cowplot_1.1.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/cowplot/cowplot_1.1.0.tar.gz \
    && R CMD INSTALL cowplot_1.1.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggsignif/ggsignif_0.6.2.tar.gz \
    && R CMD INSTALL ggsignif_0.6.2.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/gridExtra/gridExtra_2.2.1.tar.gz \
    && R CMD INSTALL gridExtra_2.2.1.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/polynom/polynom_1.3-9.tar.gz \
    && R CMD INSTALL polynom_1.3-9.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/rstatix/rstatix_0.6.0.tar.gz \
    && R CMD INSTALL rstatix_0.6.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggpubr/ggpubr_0.3.0.tar.gz \
    && R CMD INSTALL ggpubr_0.3.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/patchwork/patchwork_1.1.0.tar.gz \
    && R CMD INSTALL patchwork_1.1.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/mixOmics/mixOmics_6.3.2.tar.gz \
    && R CMD INSTALL mixOmics_6.3.2.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/tidyverse/tidyverse_1.3.0.tar.gz \
    && R CMD INSTALL tidyverse_1.3.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/openxlsx/openxlsx_4.2.4.tar.gz \
    && R CMD INSTALL openxlsx_4.2.4.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/vegan/vegan_2.5-6.tar.gz \
    && R CMD INSTALL vegan_2.5-6.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/scales/scales_1.1.0.tar.gz \
    && R CMD INSTALL scales_1.1.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggh4x/ggh4x_0.2.0.tar.gz \
    && R CMD INSTALL ggh4x_0.2.0.tar.gz

RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/ggvenn/ggvenn_0.1.8.tar.gz \
    && R CMD INSTALL ggvenn_0.1.8.tar.gz
    
RUN cd /opt/packages \
    && wget https://cran.r-project.org/src/contrib/Archive/BiocManager/BiocManager_1.30.15.tar.gz \
    && R CMD INSTALL BiocManager_1.30.15.tar.gz \
    && touch install.R \
    && echo "BiocManager::install(\"phyloseq\")" >> install.R \
    && sed -i '$a BiocManager::install("MicrobiotaProcess")' install.R \
    && R CMD BATCH --no-save --no-restore install.R


811938384917.dkr.ecr.cn-northwest-1.amazonaws.com.cn/kcr/kesci_kernel_lab:datascience-r-4.1.1