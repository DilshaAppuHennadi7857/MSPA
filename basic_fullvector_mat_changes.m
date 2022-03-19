clear

% This example shows how to calculate and plot both the
% fundamental TE eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
% n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
currmode = 1;         % number of modes to compute

index = 1;
    
for n2 = linspace(3.305,3.44,10)
    
    % loop through indicies of the ridge (core or n2) and plot the effects
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                        rh,rw,side,dx,dy); 

    [Hx,Hy,neff] = wgmodes(lambda,n2,currmode,dx,dy,eps,'000A');

    fprintf(1,'neff = %.6f\n',neff);

    figure(index);
    subplot(1,2,1);
    contourmode(x,y,Hx(:,:,currmode));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
%     view(2)

    subplot(1,2,2);
    contourmode(x,y,Hy(:,:,currmode));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
%     view(2)
    
    Neff(index) = neff(1);
    
    index = index + 1;
    
end

n2 = linspace(3.305,3.44,10);

figure(index)
plot(n2,Neff,'-')
xlabel('Ridge/Core Index of Refraction')
ylabel('N_{eff}')
title('Ridge Index affect on N_{eff}')
    
