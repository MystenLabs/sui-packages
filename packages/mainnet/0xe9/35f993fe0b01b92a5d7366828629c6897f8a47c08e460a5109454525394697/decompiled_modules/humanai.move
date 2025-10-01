module 0xe935f993fe0b01b92a5d7366828629c6897f8a47c08e460a5109454525394697::humanai {
    struct HUMANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7ff47cd89b9281490b18baffc26d8786a659a43ad2228c17cc76d9a95c033f87                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HUMANAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HUMANAI     ")))), trim_right(b"Human AI                        "), trim_right(b"The Human-AI Mission refers to the collaboration between humans and artificial intelligence to address complex global challenges, drive innovation, and enhance various aspects of life and work. This mission is grounded in the idea that AI is not a replacement for human intelligence but a powerful tool that, when combin"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMANAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMANAI>>(v4);
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

