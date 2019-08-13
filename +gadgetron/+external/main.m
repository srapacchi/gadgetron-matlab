
function main()

    path = fileparts(mfilename('fullpath'));
    javaaddpath(path);

    port = getenv('GADGETRON_EXTERNAL_PORT');
    module = getenv('GADGETRON_EXTERNAL_MODULE');
    
    if isempty(port) || isempty(module)
        fprintf("Gadgetron External MATLAB Module v. %s\n", gadgetron.version);
        return
    end
    
    fprintf("Starting external MATLAB module '%s' in state: [ACTIVE]\n", module)
    fprintf("Connecting to parent on port %s\n", port)
    
    sock = socket.connect('localhost', str2num(port));
    connection = gadgetron.external.Connection(sock);
    
    feval(module, connection);
    sock.write(ismrmrd.Constants.CLOSE);
end
