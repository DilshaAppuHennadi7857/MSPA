clear

% This example uses the original basic_fullvector.m script to demonstrate
% how changes to the ridge half-width affect the mode. Specifically, this
% script looks at the fundamental TE eigenmode of the 3-layer ridge
% waveguide from the previous example with variations in its geometery.

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
% rw = linspace(0.325,1.0,10);           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125; %*8;        % grid size (horizontal)
dy = 0.0125; %*8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
currmode = 1;         % number of modes to compute
index = 1;

for rw = linspace(0.325,1.0,10)
    
    % loop through values of ridge half-width and plot the effects
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                        rh,rw,side,dx,dy); 

    [Hx,Hy,neff] = wgmodes(lambda,n2,currmode,dx,dy,eps,'000A');

    fprintf(1,'neff = %.6f\n',neff);

    figure(index);
    subplot(1,2,1);
    contourmode(x,y,Hx(:,:,currmode));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(1,2,2);
    contourmode(x,y,Hy(:,:,currmode));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    Neff(index) = neff;
    
    index = index + 1;
    
end

rw = linspace(0.325,1.0,10);

figure(index)
plot(rw,Neff,'-')
xlabel('Ridge half-width')
ylabel('N_{eff}')
title('Ridge half-width affect on N_{eff}')
    
