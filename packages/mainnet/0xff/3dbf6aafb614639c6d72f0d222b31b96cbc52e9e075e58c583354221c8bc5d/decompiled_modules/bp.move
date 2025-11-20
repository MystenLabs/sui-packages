module 0xff3dbf6aafb614639c6d72f0d222b31b96cbc52e9e075e58c583354221c8bc5d::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9de6a25cc5d4e4ae6d8d3218ed74d8caa3b5d3be8dba1931d6ba8c172bbd489f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"bp          ")))), trim_right(b"blackpill                       "), trim_right(b"The blackpill is the belief that physical attractiveness, especially facial features and height, controls most outcomes in dating and social life. It claims that in everyday situations, attractive people get more attention, respect, and chances, while unattractive people are overlooked or rejected. It presents a very n"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BP>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

