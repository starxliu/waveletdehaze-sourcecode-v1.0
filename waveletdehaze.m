%  This is the reference implementation of the wavelet dehaze
%  described in the paper:
% 
%    Efficient single image dehazing and denoising: An efficient multi-scale correlated wavelet approach
%    Xin Liu, He Zhang, Yiu-ming Cheung, Xinge You, YuanYan Tang
%    Computer Vision and Image Understanding. Volume 162 (2017), Pages 23-33.
%
%  Please refer to the publication above if you use this software.
%
%  THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY EXPRESSED OR IMPLIED WARRANTIES
%  OF ANY KIND, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
%  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%  OUT OF OR IN CONNECTION WITH THIS SOFTWARE OR THE USE OR OTHER DEALINGS IN
%  THIS SOFTWARE.
%
%  Version 1.0 - December 2017.

% For the noisy image, the noise removal part can be embeded into this
% wavelet framework directly, and it is easy to design by the intertested designers themself.


function d = waveletdehaze(f,level, wname)
if (~exist('level','var'))
  level = 2;
end
if (~exist('wname','var'))
  wname = 'sym4';
end

coef = 2^level;

[C,S] = wavedec2(f,level,wname);

% estimate the noise standard deviation from the detail coefficients at level 1
if level~=0
    det1 = detcoef2('compact',C,S,1);
    tau = median(abs(det1))/0.6745;
end

A = appcoef2(C,S,wname,level);
[imD,t]= dehaze(A/coef,level); % removal haze in low frequency
NA=  (imD(:)*coef)';

for n = level:-1:1
    [CHD,CVD,CDD] = detcoef2('all',C,S,n);
    t = imresize(t,[size(CHD,1),size(CHD,2)],'bicubic');
   
    tD = cat(3,t,t,t);
    CHD = wthresh(CHD,'s',tau);              %Eqn(12)
    CVD = wthresh(CVD,'s',tau);              %Eqn(12)
    CDD = wthresh(CDD,'s',tau);              %Eqn(12)
   
    NCHD = bsxfun(@rdivide,CHD,t);           %Equ(16)
    NCVD = bsxfun(@rdivide,CVD,t);           %Equ(16)
    NCDD = bsxfun(@rdivide,CDD,t);           %Equ(16) 
  
    NA = [NA NCHD(:)' NCVD(:)' NCDD(:)'];
end

d = waverec2(NA,S,wname);
d(d>1) = 1;
d(d<0) = 0;






