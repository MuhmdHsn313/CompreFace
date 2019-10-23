package com.exadel.frs.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.BAD_REQUEST)
public class NullAccessTypeException extends RuntimeException {

    public NullAccessTypeException() {
        super("Access type can not be null");
    }

}
