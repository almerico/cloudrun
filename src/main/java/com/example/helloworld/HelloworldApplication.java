/*
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// [START cloudrun_helloworld_service]
// [START run_helloworld_service]

package com.example.helloworld;

import java.io.FileInputStream;
import java.io.IOException;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BucketInfo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.api.gax.paging.Page;
import com.google.auth.appengine.AppEngineCredentials;
import com.google.auth.oauth2.ComputeEngineCredentials;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import com.google.common.collect.Lists;

import static java.nio.charset.StandardCharsets.UTF_8;

@SpringBootApplication
public class HelloworldApplication {

    @Value("${NAME:aletring test}")
    String name;
    String version = " Version 8";

    @RestController
    class HelloworldController {

        @GetMapping("/")
        String hello() {
            return "Hello " + name + " " + version;
        }

        @GetMapping("/200")
        String say200() {
            System.out.println("{\"severity\": \"NOTICE\", \"message\": \"This is the default display field.\", \"component\": \"arbitrary-property\", \"logging.googleapis.com/labels\": {\"user_label_1\": \"value_1\"}}");
            return "200 " + name + " " + version;
        }

        @GetMapping("/500")
        String say500() throws Exception {
            System.out.println("{\"labels\":{\"myCustomLabel\":\"500\"},\"httpRequest\":{\"requestMethod\":\"GET\"},\"severity\":\"ERROR\"}");
            throw new Exception("500" + version);
        }
        @GetMapping("/delay")
        String delay() throws Exception {
            System.out.println("{\"labels\":{\"myCustomLabel\":\"delay\"},\"httpRequest\":{\"requestMethod\":\"GET\"},\"severity\":\"ERROR\"}");
            Thread.sleep(3000);
            return "delay " + name + " " + version;
        }
        @GetMapping("/createblob")
        String blobFromByteArray (@RequestParam String name) throws IOException {
            return createBlobFromByteArray("TestBlob",name);
        }
    }
    String createBlobFromByteArray(String blobName,  String bucketName) throws IOException {

        Storage storage = StorageOptions.newBuilder().build().getService();
        Bucket bucket = storage.create(BucketInfo.of(bucketName));
        Blob blob = bucket.create(blobName, "Test Data ".getBytes(UTF_8), "text/plain");
        return "blobname"+blobName+"  "+ "buketname "+bucketName + "created";
    }
    public static void main(String[] args) {
        SpringApplication.run(HelloworldApplication.class,
                              args);
    }
}
// [END run_helloworld_service]
// [END cloudrun_helloworld_service]
