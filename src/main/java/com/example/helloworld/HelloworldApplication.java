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

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class HelloworldApplication {

    @Value("${NAME:World}")
    String name;
    String version = " Version 7";

    @RestController
    class HelloworldController {

        @GetMapping("/")
        String hello() {
            return "Hello " + name + " " + version;
        }

        @GetMapping("/200")
        String say200() {
            System.out.println("{\"logging.googleapis.com/labels\":{\"myCustomLabel\":\"200\"},\"httpRequest\":{\"requestMethod\":\"GET\"},\"severity\":\"DEBUG\"}");
            return "200 " + name + " " + version;
        }

        @GetMapping("/500")
        String say500() throws Exception {
            System.out.println("{\"labels\":{\"myCustomLabel\":\"500\"},\"httpRequest\":{\"requestMethod\":\"GET\"},\"severity\":\"ERROR\"}");
            throw new Exception("500" + version);
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(HelloworldApplication.class,
                              args);
    }
}
// [END run_helloworld_service]
// [END cloudrun_helloworld_service]
