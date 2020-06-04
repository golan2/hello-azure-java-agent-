package com.golan.azure.java.agent;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

@SuppressWarnings("unused")
@RequestMapping("/")
@RestController
@Slf4j
public class LocalController {

    @GetMapping(value = "try/{me}")
    public String tryMe(@PathVariable("me") String me) throws InterruptedException {
        if (me.equalsIgnoreCase("error")) throw new RuntimeException("You wanted an error.");

        final int r = new Random().nextInt(1500);
        log.debug("~~~[try_me] [{}] [{}]", me, r);
        Thread.sleep(r);
        return me;
    }

}