package practice.deployment;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {
    @GetMapping("/")
    public String home() {
        return "Hello, World!";
    }

    @GetMapping("/hi")
    public String hi() {
        return "Hi, there!";
    }
}


