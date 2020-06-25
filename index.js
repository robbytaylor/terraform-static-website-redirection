exports.handler = (event, context, callback) => {
    const request = event.Records[0].cf.request;
    const hostname = request.headers.host[0].value;

    if ("${primary_hostname}" && hostname === "${primary_hostname}") {
        return callback(null, request);
    }

    const response = {
        status: '301',
        statusDescription: 'Found',
        headers: {
            location: [{
                key: 'Location',
                value: "https://${primary_hostname}" + request.uri + (request.querystring === "" ? "" : "?" + request.querystring),
            }],
        },
    }

    callback(null, response);
}
