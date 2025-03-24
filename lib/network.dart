import 'package:http/http.dart' as http;

Future<String> getpostid(url) async {
  var request = http.Request('GET', Uri.parse(url));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return (await response.stream.bytesToString());
  } else {
    return (response.reasonPhrase!);
  }
}

Future<String> getvideolink(postid, url) async {
  var headers = {
    'authority': 'www.threads.net',
    'accept': '*/*',
    'accept-language': 'en-US,en;q=0.9',
    'content-type': 'application/x-www-form-urlencoded',
    'origin': 'https://www.threads.net',
    'referer': url.toString(),
    'sec-ch-prefers-color-scheme': 'light',
    'sec-ch-ua':
        '"Not_A Brand";v="99", "Microsoft Edge";v="109", "Chromium";v="109"',
    'sec-ch-ua-full-version-list':
        '"Not_A Brand";v="99.0.0.0", "Microsoft Edge";v="109.0.1518.115", "Chromium";v="109.0.5414.149"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '"Windows"',
    'sec-ch-ua-platform-version': '"0.3.0"',
    'sec-fetch-dest': 'empty',
    'sec-fetch-mode': 'cors',
    'sec-fetch-site': 'same-origin',
    'user-agent':
        'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.115',
    'x-asbd-id': '129477',
    'x-fb-friendly-name': 'BarcelonaPostPageQuery',
    'x-fb-lsd': 'riXJzK7l0Es4LKN7RHMd5c',
    'x-ig-app-id': '238260118697367'
  };
  var request =
      http.Request('POST', Uri.parse('https://www.threads.net/api/graphql'));
  request.bodyFields = {
    'av': '0',
    '__user': '0',
    '__a': '1',
    '__req': '2',
    '__hs': '19548.HYP:barcelona_web_pkg.2.1..0.0',
    'dpr': '1',
    '__ccg': 'EXCELLENT',
    '__rev': '1007810978',
    '__s': '452xf9:hghy8p:793oz7',
    '__hsi': '7254062053506657556',
    '__dyn':
        '7xeUmwlEnwn8K2WnFw9-2i5U4e0yoW3q32360CEbo1nEhw2nVE4W0om78b87C0yE5ufz81s8hwGwQw9m1YwBgao6C0Mo5W3S7Udo5qfK0EUjwGzE2swwwNwKwHw8Xxm16waCm7-0iK2S3qazo7u0zE2ZwrUdUcobU2cwmo6O0A8pw',
    '__csr': 'hRZ6F2xsw01kW61Ee4UaP07dwU8azk48S1Em0Mk0JU0oB7NGxR4gqN0',
    '__comet_req': '29',
    'lsd': 'riXJzK7l0Es4LKN7RHMd5c',
    'jazoest': '21792',
    '__spin_r': '1007810978',
    '__spin_b': 'trunk',
    '__spin_t': '1688967936',
    '__jssesw': '1',
    'fb_api_caller_class': 'RelayModern',
    'fb_api_req_friendly_name': 'BarcelonaPostPageQuery',
    'variables': '{"postID":"' + postid + '"}',
    'server_timestamps': 'true',
    'doc_id': '6529829603744567'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return (await response.stream.bytesToString());
  } else {
    return (response.reasonPhrase!);
  }
}
