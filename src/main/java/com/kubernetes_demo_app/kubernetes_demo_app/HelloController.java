package com.kubernetes_demo_app.kubernetes_demo_app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello from Spring Boot running in Kubernetes! 2.01";
    }
}
