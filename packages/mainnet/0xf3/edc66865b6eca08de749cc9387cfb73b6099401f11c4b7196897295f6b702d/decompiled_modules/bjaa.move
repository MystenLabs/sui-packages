module 0xf3edc66865b6eca08de749cc9387cfb73b6099401f11c4b7196897295f6b702d::bjaa {
    struct BJAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BJAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cd36c77bbd64ca7800cadc0cf9418b68db9ad2445ccc7e7016f3cfd43801b1b1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BJAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"bja         ")))), trim_right(b"Big Jons Auto                   "), trim_right(x"424a4120204275696c642e204a6f75726e65792e20416368696576652e0a0a24424a41206973206120636f6d6d756e6974792d64726976656e2070726f6a65637420666f6375736564206f6e207265616c2070656f706c652c207265616c2067726f7774682c20616e64206c6f6e672d7465726d2076616c75652e2057657265206275696c64696e6720736f6d657468696e672074686174206c617374732c206272696e67696e6720746f676574686572207472616465727320616e64206e6577636f6d6572732077686f2062656c6965766520696e207472616e73706172656e637920616e64207465616d776f726b2e0a0a54686520646576656c6f70657220686173206c6f636b65642032342070657263656e74206f662074686520746f74616c20737570706c7920756e74696c20466562727561727920323032362c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BJAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BJAA>>(v4);
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

