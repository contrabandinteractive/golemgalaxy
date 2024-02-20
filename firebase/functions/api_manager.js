const axios = require("axios").default;
const qs = require("qs");

async function _getImgCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var token = ffVariables["token"];
  var prompt = ffVariables["prompt"];

  var url = `https://api.replicate.com/v1/predictions`;
  var headers = {
    Authorization: `Token ${token}`,
    "Content-Type": `application/json`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "version": "ff6cc781634191dd3c49097a615d2fc01b0a8aae31c448e55039a04dcbf36bba",
  "input": {
    "prompt": "${prompt}",
    "num_outputs": 1,
    "guidance_scale": 7.5,
    "num_inference_steps": 50
  }
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}
async function _getPredictionCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var token = ffVariables["token"];
  var prediction = ffVariables["prediction"];

  var url = `https://api.replicate.com/v1/predictions/${prediction}`;
  var headers = { Authorization: `Token ${token}` };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    GetImgCall: _getImgCall,
    GetPredictionCall: _getPredictionCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}

module.exports = { makeApiCall };
