exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const hostname = request.headers.host[0].value;

    if (hostname === "${redirect_to}") {
        return callback(null, request);
    }

    const response = {
        status: '301',
        statusDescription: 'Found',
        headers: {
            location: [{
                key: 'Location',
                value: "https://${redirect_to}" + request.uri + (request.querystring === "" ? "" : "?" + request.querystring),
            }],
        },
    }

    callback(null, response);
}
