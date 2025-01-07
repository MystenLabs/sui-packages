module 0xa0c494f380f58ba005b74253cdcac08ac62abde97110182c22ea5290b509e14d::bmrt {
    struct BMRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMRT>(arg0, 9, b"BMRT", b"Boomer", b"Booomin and Moonin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAD6APoDASIAAhEBAxEB/8QAHAAAAQUBAQEAAAAAAAAAAAAABgIDBAUHAQgA/8QAUxAAAQMDAwEEBgYDCgsGBwAAAQIDBAAFEQYSITETQVFhBxQicYGRFTJCUqGxI4KiFjNDU2JykrLB0QgkJTREY3OTwuHwFyY2ZLPSNVRVdJSjw//EABsBAAIDAQEBAAAAAAAAAAAAAAQFAgMGAQAH/8QAOREAAQMCBAIHBgYBBQEAAAAAAQACAwQRBRIhMUFREyJhcYGRsQYyocHR4RQVI0JS8DMkNERigrL/2gAMAwEAAhEDEQA/AATHArlKHSu4qV187ukYr7FKxXcVy69dIxX2KViu4zXrryRX2KVtroQcVy68q67IU2wiY0P0sRYeTjvA+sPiM16F9Fl7RcLE3GKgVNJBQfvIPT5VhnZ7gQRlJ4I8aLvRLOVb2YY3f5pLVb3s/cJBQf6Kh/RphQvzB0R7wm1DJmYWHh8/78VvZHNfYxXaStSW0Fa1BKEjJJOABV90WlACvqB5+uVzVusaRg/SZbO1yc6vsobR83D9Y+SQaEbpNlTFFN7v82crvjWo+px0+W/lxQ+IpPW45SUhLHOzO5DU+PAeKt6EtGZ5sO36LWLhd7dbkbp86LGT4vOpQPxNUq/SBpBBKValtAP/AN2g/wBtZrEhw2lFcDTNs3n+FejmS5/TcJNSVzrowPZjMNJ8EwmwB+zSR/tcL2ZF5ut6Arl4RxJ8FosfXWlZKgljUdpWrwEtGfzq+jyo8pAXGeadQeikKCgflWJvXl5xO2VAtUkd4egtqz+FVw+g+1Lpsv0c+f8ASLPIXEWP1Qdv4VZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BMRT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMRT>>(v2, @0xeb2c089aa1487d98a058f1e022a7da5b8ea24700b243eb6f87995c3cacad4d16);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

