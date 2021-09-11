---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python
  - go

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to the Profilora API,

before You start to hit request on some of our endpoints, it is required to integrate Your **WhatsApp Account** and creating an **API Client** to get the `key` and the `secret` code before going any further.

# Authentication

> To test the API, use this code:


```shell
# With shell, you can just pass the correct header with each request
curl "https://api.profilora.com/ping" \
  -H "Authorization: Basic <authkey>"
```

```javascript
const axios = require('axios');
const profiloraApi = axios.create({
  baseURL: 'https://api.profilora.com',
  auth: {
    username: '<key>',
    password: '<secret>'
  }
})
const result = profiloraApi.get('/ping');
```

```python
import requests

result = requests.get('https://api.profilora.com/ping', 
  auth=('<key>', '<secret>'),
  headers={
    'Content-Type': 'application/json',
  })
```

```go
package main

import (
	"fmt"
	"github.com/imroc/req"
)

func main() {
	header := req.Header{
		"Accept":        "application/json",
		"Authorization": "Basic <authkey>",
	}

	resp, _ := req.Get("https://api.profilora.com/ping", header)

	fmt.Println(resp.ToString())
}
```

> Make sure to encrypt `<authkey>` using base64 encode with format `<key>:<secret>`.

Profilora expect you to attach an Authorization key on every API request.

The auth key should be encoded using `base64` encryption, formatted  as:

`<your-key>:<your-secret>`

and attached as `Authorization` header with prefix `Basic`.

`Authorization: Basic <authkey>`

You will get JSON response `{"status":"ok"}` once the request API is valid. This is a good signal to continue with another APIs.

<aside class="notice">
Again!, You must replace <code><authkey></code> with your personal API key encoded with <strong>Base64</strong> in `key:secret` format.
</aside>
# WhatsApp API

## Send Message

```shell
curl -X POST \
  --url https://api.profilora.com/whatsapp/send-message \
  --header 'Authorization: Basic <authkey>' \
  --header 'Content-Type: application/json' \
  --data '{
	"to": "6285xxx@s.whatsapp.net",
	"sender": "6285xxx@s.whatsapp.net",
	"message": "Sent from API"
  }'
```

```javascript
// reuse "profiloraApi" from previous example
const { status, body } = profiloraApi.post('/whatsapp/send-message');
// 200: OK, message processed
if (status === 200) {
  console.log(body)
}
```

```python
import requests
import json

result = requests.post('https://api.profilora.com/whatsapp/send-message', 
  auth=('<key>', '<secret>'),
  headers={
    'Content-Type': 'application/json',
  },
  data=json.dumps({
    'sender': '6285xxx@s.whatsapp.net',
    'to': '6285xxx@s.whatsapp.net',
    'message': 'Sent from API'
  }))

print(result.json())
```

```go
package main

import (
	"github.com/imroc/req"
)

func main() {
	header := req.Header{
		"Accept":        "application/json",
		"Authorization": "Basic <authkey>",
	}

  payloads := map[string]interface{}{
    "sender": "6285xxx@s.whatsapp.net",
    "to": "6285xxx@s.whatsapp.net",
    "message": "Sent from API",
  }

  bodyJson := req.BodyJSON(&payloads)

	resp, _ := req.Post(
    "https://api.profilora.com/whatsapp/send-message",
    header,
    bodyJson,
  )

  result := make(map[string]interface{})
  resp.ToJSON(&result)
}
```

> The above request returns JSON structured like this:

```json
{
  "eventId": "p0YRyUyFLpbNgB_VGq2Ga",
  "message": "Message will be processed"
}
```

Send a text message.

### HTTP Request

`POST https://api.profilora.com/whatsapp/send-message`

### JSON Parameters

Parameter | Required | Description
--------- | ------- | -----------
sender | true | WhatsApp sender identity, the number should match with one of Your active WhatsApp Agents
to | true | WhatsApp recipient identity
message | true | Text message to send

### JSON Response

Parameter | type | Description
--------- | ------- | -----------
eventId | string | The event to track for delivery status via WebHook
messae | string | Status message

<aside class="success">
Successful request API will return "200" status code
</aside>
<aside class="warning">Successful request for sending message doesn't mean it's delivered, You should check the delivery status via our WebHook request, matching with the <strong>eventId<strong>.</aside>

## Get a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.get(2)
```

```shell
curl "http://example.com/api/kittens/2" \
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.get(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Max",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">Inside HTML code blocks like this one, you can't use Markdown, so use <code>&lt;code&gt;</code> blocks to denote code.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to retrieve

## Delete a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.delete(2)
```

```python
import kittn

api = kittn.authorize('meowmeowmeow')
api.kittens.delete(2)
```

```shell
curl "http://example.com/api/kittens/2" \
  -X DELETE \
  -H "Authorization: meowmeowmeow"
```

```javascript
const kittn = require('kittn');

let api = kittn.authorize('meowmeowmeow');
let max = api.kittens.delete(2);
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "deleted" : ":("
}
```

This endpoint deletes a specific kitten.

### HTTP Request

`DELETE http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to delete

