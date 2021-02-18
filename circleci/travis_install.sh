# Adapted shamelessly from https://github.com/scikit-learn-contrib/project-template/blob/master/ci_scripts/install.sh
# Deactivate the travis-provided virtual environment and setup a
# conda-based environment instead
deactivate

# Use the miniconda installer for faster download / install of conda
# itself
pushd .
cd
mkdir -p download
cd download
echo "Cached in $HOME/download :"
ls -l
echo
if [[ ! -f miniconda.sh ]]
   then
   wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
       -O miniconda.sh
   fi
chmod +x miniconda.sh && ./miniconda.sh -b
cd ..
export PATH="$HOME/miniconda3/bin:$PATH"
conda update --yes conda
popd

conda info -a

# Configure the conda environment and put it in the path using the
# provided versions
conda env create -n book -f environment.yml
conda init zsh
source /home/travis/miniconda/etc/profile.d/conda.sh
conda activate book
pip install -U jupyter-book
pip install pyppeteer
python -c 'import pyppeteer; pyppeteer.chromium_downloader.download_chromium()'
pip install sphinxcontrib-bibtex

# Kevins environment
# conda create -n testenv --yes python=$PYTHON_VERSION pip nose pytest
# conda env update -n testenv -f binder/environment.yml -q
# source activate testenv

# chmod a+x binder/postBuild
# sh binder/postBuild
