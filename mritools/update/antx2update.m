
function antx2update(varargin)

if nargin==0
    s      =input('cloning [0,1]: ', 's');
    cloning=str2num(s);
    s      =input('forcecloning [0,1]: ', 's');
    forcecloning=str2num(s);
    s     =input('keepgit [0,1]: ', 's');
    keepgit=str2num(s);
    
    if isempty(cloning);      cloning     =0; end
    if isempty(forcecloning); forcecloning=0; end
    if isempty(keepgit);      keepgit     =1; end
    
    
    par.cloning=cloning;
    par.forcecloning=forcecloning;
    par.keepgit=keepgit;
    par.antpath=fileparts(which('antlink2.m'));
 
   
    
    % pars.wd = pwd;
    par.updatedir = fileparts(which('antx2update.m'));
    par.tempdir=fullfile(fileparts(fileparts(fileparts(par.updatedir))),'antx2update_temp');
    
    par.parafile =fullfile(par.tempdir,'updatepara.mat');
    copyfile(par.updatedir,par.tempdir,'f');
    
    
    save(par.parafile,'par');
    
    try; antlink(0); end
    cd(par.tempdir);
    
    if exist(fullfile(fileparts(par.tempdir),'masterdrive.txt'))==2
    disp(['cannot update master-drive, location "' fileparts(par.tempdir) '"-drive' ]);
    return
        
    end
    antx2update(par.tempdir);
    
    
    
    
    return
end


'disp-part2'
par=updatenow(par.tempdir)

function par=updatenow(par.tempdir)
disp('3')

return


return
% ======================================================================
% ======================================================================
%%                     [2] DOWNLOAD                     
% ======================================================================
% ======================================================================
% ==============================================
%%    [1] clone  TBX
% 1st time: 308.056391 seconds.-->5min
% ===============================================
pamain='C:\Users\skoch\Desktop\github4\getTBX2';

cloning     =1;
forcecloning=0;
keepgit     =1;  % keep version control(.git folder)

% -------------------
paantx=fullfile(pamain,'antx2');
cd(pamain);


[er erlog]=system('git --version');
if isempty(strfind(erlog,'version')); %check GIT
   disp('GIT not installed') ; return
else
   disp('..GIT installed [OK]') ;
end
if exist('git','file')==0; %check GIT
   disp('GIT-matlab function not installed') ; return
else
    disp('..GIT-matlab installed [OK]') ;
end


if exist('antx2','dir')==0  ; %dir does not exist
    forcecloning=1;
elseif exist('antx2','dir')==7
    if exist(fullfile(paantx,'.git'))==0; %.git does not exist
        forcecloning=1;
    end
end

if exist('antx2','dir')==7 && forcecloning==1
    atime=tic;
    fprintf(['deleting old repository..please wait..']);
    rmdir(paantx,'s');
    fprintf(['done t=%2.3f min\n'],toc(atime)/60);
end
    
    



if forcecloning==1
    atime=tic;
    fprintf(['cloning repository..please wait..']);
    %%%%% git clone --depth=1 https://github.com/pstkoch/antx2.git
    % git clone https://github.com/pstkoch/antx2.git
    
    git clone --depth=1 https://github.com/pstkoch/antx2.git
    fprintf(['done t=%2.3f min\n'],toc(atime)/60);
    
    
    if keepgit==0
        atime=tic;
        fprintf(['removing version control (".git")..please wait..']);
        try; rmdir(fullfile(paantx,'.git'),'s');end
        fprintf(['done t=%2.3f min\n'],toc(atime)/60);
    end
end

% ==============================================
%%   [2] update client local side
% 24 files deleted: 6s
% ===============================================
if forcecloning==0
    % git branch --set-upstream-to=origin master
    % git init
    
    % git config --global user.name "pstkoch"
    % git config --global user.email “pstkoch@googlemail.com"
    
    % cd(fullfile('C:\Users\skoch\Desktop\github2\repo2\getTBX2','antx2'))
    atime=tic;
    cd(paantx);
    if exist('.git','dir')~=7
        disp('version control (".git") folder has been removed previously');
        disp('set [keepVersionControl] to true and re-clone repository')
    end
    
    
    fprintf(['updating using version control (".git")..please wait..\n']);
    git reset --hard HEAD;
    git pull;
    fprintf(['updating..done t=%2.3f min\n'],toc(atime)/60);
    
    
  % check before  
%     git fetch
%     git diff master origin/master
%     git diff --compact-summary master origin/master
end

% ==============================================
%%   prune on source
% ===============================================


% git checkout --orphan freshBranch
% git add -A
% git commit
% git branch -D master 
% git branch -m master 
% git push -f origin master 
% git gc --aggressive --prune=all
% git push -f origin master
