module 0x3bfd32a0afb433c7d49ddbe6bb4576625c7b2c71218e30d077de0c9f185b9786::redwooda {
    struct REDWOODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDWOODA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8db10059d3fec133eedef827c95efe4e0a2e6c7700a9a8ffd3503619b95260d5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REDWOODA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REDWOOD     ")))), trim_right(b"NEOS AI                         "), trim_right(x"526564776f6f642069732031587320627265616b7468726f756768204149206d6f64656c20746861742077696c6c20626520706f776572696e67204e454f2047616d6d612e20526564776f6f64206769766573204e454f20746865206162696c69747920746f206c6561726e2066726f6d207265616c2d776f726c6420657870657269656e63652c206d616b696e672069742073616665722c20736d61727465722c20616e64206d6f72652063617061626c65206f7665722074696d652e0a0a24524544574f4f4420726570726573656e74732074686520696e74656c6c6967656e6365206c6179657220626568696e6420244e454f202074686520627261696e2074686174206272696e6773206d6f74696f6e20746f206c6966652e2020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDWOODA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDWOODA>>(v4);
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

