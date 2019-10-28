
%CHECK
function checkupdates(varargin)

if nargin==1
    if strcmp(varargin{1},'install')
         intaller
        return
    end
    
end


initialize();
mkgui();



end

function intaller
atime=tic;
mkgui()


fprintf(['installation..please wait..\n']);
setstatus(1,'fresh installation..');

global antupd;
if isempty(antupd.patempup)
    disp('instert selection here');
end

disp('hallo');
disp(which('checkupdates.m'));

if exist(fullfile(antupd.patempup,'antx2'))==7
    disp('renaming')
    disp(fullfile(antupd.patempup,'antx2'));
    disp(fullfile(antupd.patempup,'_antx2'));
    movefile(fullfile(antupd.patempup,'antx2'),fullfile(antupd.patempup,'_antx2'),'f')
end
disp('cloning')
git clone https://github.com/pstkoch/antx2
fprintf(['installation..done t=%2.3f min\n'],toc(atime)/60);
cd(fullfile(antupd.patempup,'antx2'));
setstatus(0);
checkupdates


end



function initialize
p.pwd        = pwd;
p.updatepath = fileparts(which(mfilename));
p.antxpath   = which('ant.m');
global antupd;
antupd=p;
cd(p.updatepath);
if ~isempty(p.antxpath); antlink(0);end

end

function pbcheckupdatescall(e,e2,updatecode)

pbcheckupdates(updatecode);

end

function pbcheckupdates(updatecode);

global antupd;
atime=tic;
% prevdir    =p.pwd;
% updatepath =p.updatepath;
% antxpath   =p.antxpath;

if exist('.git','dir')~=7
    disp('version control (".git") folder has been removed previously');
    disp('set [keepVersionControl] to true and re-clone repository')
end



if updatecode==1 %check before
   setstatus(1,'checking updates');
    git fetch
    git diff master origin/master
    %     git diff --compact-summary master origin/master
    [msg st]=git('diff --compact-summary master origin/master')
    if isempty(msg);
        disp('no changes/no updates');
    else
        button = questdlg(['updates where found' char(10) 'Update toolbox now? '],'',...
            'YES, update now','Cancel','canel');
        if ~isempty(regexpi(button,'yes'))
            updatecode=2;
        else
            disp('nothing updated');
            return
        end
    end
end
if updatecode==2
    setstatus(1,'updating..');
    fprintf(['updating using version control (".git")..please wait..\n']);
    if exist(fullfile(pwd,'.git'))~=7
        button = questdlg(['".git-dir" not found, but mandatory for update' char(10)...
            'Create/Recreate ".git"-dir? ' char(10) ...
            '    ..this might take a while..'],'',...
            'YES, do it','Cancel','canel');
        git reset --hard HEAD;
        if ~isempty(regexpi(button,'yes'))
            updatecode=3;
        else
            disp('..".git"-not found, .git not restored');
            return
        end
    else
        git pull;
    end
    fprintf(['updating..done t=%2.3f min\n'],toc(atime)/60);
end

if updatecode==3
    setstatus(1,'create ".git" & updating..');
    % need to initialize a new Git repository in your machine:
     fprintf(['creating/restore ".git"..please wait..\n']);
    git init
    %Add your remote repository (published on GitHub):
    git remote add origin https://github.com/pstkoch/antx2
    git pull origin master

    %Or you can simply clone the existing remote repository as suggested in the above comments:
    %git clone https://your_repot_url
    fprintf(['..done t=%2.3f min\n'],toc(atime)/60);
end
if updatecode==4
    
     pa=uigetdir(pwd,'select path to install "antx2"');
    if isnumeric(pa);        return ;    end
    
    [pa2 pa1]=fileparts(pa);
    if strcmp(pa1,'antx2');%antx2-path selected
        patempup=pa2;
    elseif exist((fullfile(pa,'antx2')))==7
        patempup=pa;
    else
        patempup=pa;
    end
    antupd.patempup=patempup;
    cd(patempup);
    try
    copyfile(fullfile(antupd.updatepath,'checkupdates.m'), fullfile(antupd.patempup,'checkupdates.m'),'f')
    end    
    
    checkupdates('install');
    
        
%     F:\github\fromGITHUB\antx2
%     F:\github\fromGITHUB
    

%     setstatus(1,'installing..');

%     [paup pamain]=fileparts(pa);
%     if strcmp(pamain,'antx2') || exist((fullfile(pa,'antx2')))==7
%         
%         if exist((fullfile(pa,'antx2')))==7
%             paup=pa;
% %         elseif strcmp(pamain,'antx2') 
% %             paup=   
%         end
%         
%         
%         cd(pa)
%         rename()
%     else
%         git clone https://github.com/pstkoch/antx2
%     end
    
%     % need to initialize a new Git repository in your machine:
%     cd(fileparts(antupd.updatepath));
%     fprintf(['creating/restore ".git"..please wait..\n']);
%     
%     
%     git init .
%     git remote add origin https://github.com/pstkoch/antx2
%     git pull origin master
%     
%     cd(antupd.updatepath);
%     fprintf(['..done t=%2.3f min\n'],toc(atime)/60); 
end




setstatus(0);
end

function posthoc
global antupd;

if ~isempty(p.antxpath);
    antlink(1);
    rehash path;
end
cd(p.prevdir);
disp('..updated');


edit(fullfile(paantx,'README.txt'));

end


function mkgui()
% global antpd
try;  delete(findobj(0,'tag','fupd')); end
figure; set(gcf,'color','w','units','normalized','menubar','none',...
    'position',[0.3750    0.3544    0.2896    0.2289],'tag','fupd');

hp=uicontrol('style','text','units','norm','string','status: --','fontsize',9)
set(hp,'position',[.01 0.6 .4 .07],'tag','msg','foregroundcolor',[.4 .4 .4],'backgroundcolor',[1 1 1]);
set(hp,'horizontalalignment','left');
setstatus(0);

hp=uicontrol('style','pushbutton','units','norm','string','check for updates','fontsize',9)
set(hp,'position',[.01 .5 .3 .1],'callback',{@pbcheckupdatescall,1});

hp=uicontrol('style','pushbutton','units','norm','string','update without check','fontsize',9)
set(hp,'position',[.01 .4 .3 .1],'callback',{@pbcheckupdatescall,2});

hp=uicontrol('style','pushbutton','units','norm','string','fresh installation','fontsize',9)
set(hp,'position',[.01 .3 .3 .1],'callback',{@pbcheckupdatescall,4},'foregroundcolor','r');

end

function setstatus(arg,msg)
if arg==0
   set(findobj( findobj(0,'tag','fupd') ,'tag','msg'),'foregroundcolor',[.4 .4 .4],'string','status: idle');
else
    set(findobj( findobj(0,'tag','fupd') ,'tag','msg'),'foregroundcolor',[1 0 1],'string',['..busy ' msg]); 
end

drawnow
end




function [cmdout, statout] =  git(varargin)
% A thin MATLAB wrapper for Git.
%
%   Short instructions:
%       Use this exactly as you would use the OS command-line verison of Git.
%
%   Long instructions are:
%       This is not meant to be a comprehensive guide to the near-omnipotent
%       Git SCM:
%           http://git-scm.com/documentation
%
%       Common MATLAB workflow:
%
%       % Creates initial repository tracking all files under some root
%       % folder
%       >> cd ~/
%       >> git init
%
%       % Shows changes made to all files in repo (none so far)
%       >> git status
%
%       % Create a new file and add some code
%       >> edit foo.m
%
%       % Check repo status, after new file created
%       >> git status
%
%       % Stage/unstage files for commit
%       >> git add foo.m          % Add file to repo or to stage
%       >> git reset HEAD .       % To unstage your files from current commit area
%
%       % Commit your changes to a new branch, with comments
%       >> git commit -m 'Created new file, foo.m'
%
%       % Other useful commands (replace ellipses with appropriate args)
%       >> git checkout ...       % To restore files to last commit
%       >> git branch ...         % To create or move to another branch
%       >> git diff ...           % See line-by-line changes
%
%   Useful resources:
%       1. GitX: A visual interface for Git on the OS X client
%       2. Github.com: Remote hosting for Git repos
%       3. Git on Wikipedia: Further reading
%
% v0.1,     27 October 2010 -- MR: Initial support for OS X & Linux,
%                               untested on PCs, but expected to work
%
% v0.2,     11 March 2011   -- TH: Support for PCs
%
% v0.3,     12 March 2011   -- MR: Fixed man pages hang bug using redirection
%
% v0.4,     20 November 2013-- TN: Searching for git in default directories,
%                               returning results as variable
%
% v0.5,     22 January 2015 -- TP: Suppressed printing of ans before
%                                  git command output
%
% v0.6,     26 January 2015 -- HG: Add path to git
%
% v0.7      09 April 2015   -- VF: If user requests it, return Git results
%                              as a variable instead of displaying them.
%
% v0.8      24 Juli 2015    -- MvdL: Return status output
%
%
% Contributors: (MR) Manu Raghavan
%               (TH) Timothy Hansell
%               (TN) Tassos Natsakis
%               (TP) Tyler Parsons
%               (HG) Han Geerligs
%               (VF) Vadim Frolov
%               (MvdL) Marcel van der Linden
%
orgpath=getenv('PATH');
quit_function=0;
try
    % Test to see if git is installed
    [status,~] = system('git --version');
    % if git is in the path this will return a status of 0
    % it will return a 1 only if the command is not found
    
    % git command output
    result = '';
    
    if status
        % Checking if git exists in the default installation folders (for
        % Windows)
        if ispc
            search = ~isempty(dir('c:\Program Files\Git\bin\git.exe'));
            searchx86 = ~isempty(dir('c:\Program Files (x86)\Git\bin\git.exe'));
        else
            search = 0;
            searchx86 = 0;
        end
        
        if ~(search||searchx86)
            % If git is NOT installed, then this should end the function.
            result = sprintf('git is not installed\n%s\n',...
                'Download it at http://git-scm.com/download');
            quit_function=1; % set quit_function flag: only result is displayed
        end
    end
    
    % if quit_function then only display message
    if ~quit_function
        % If git exists but the status is 1, then it means that it is
        % not in the path. We should add the path
        if status
            if search
                gitpath='c:\Program Files\Git\bin';
            else if searchx86
                    gitpath='c:\Program Files (x86)\Git\bin';
                end
            end
            setenv('PATH',[gitpath pathsep orgpath]); % add path to git
        end
        
        % We can call the real git with the arguments
        arguments = parse(varargin{:});
        if ispc
            prog = '';
        else
            prog = ' | cat';
        end
        if strcmp(arguments, 'commit ')
            answer = inputdlg('Comments:','Commit''s comments');
            arguments = [arguments '-m"' char(answer) '"'];
        end
        [status,result] = system(['git ',arguments,prog]);
    end
    if nargout >= 1
        cmdout = strtrim(result);
        statout = status;
    else
        % Display result instead of returning it
        % to suppress output of ans
        disp(result);
    end
    
    % restore the original path
    setenv(orgpath);
catch
    % restore the original path
    setenv(orgpath);
end
end

function space_delimited_list = parse(varargin)
space_delimited_list = cell2mat(...
    cellfun(@(s)([s,' ']),varargin,'UniformOutput',false));
end
