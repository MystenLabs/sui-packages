module 0x20d69ddc4f5753b2ba4370845a3d4a79dfdc718ad6175cb0f88f0f4fe7eea57c::signal {
    struct SIGNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7tdz79GSDzRdG3XJVV1fhgPB3jBtFf3n8YaxrQPxpump.png?size=lg&key=30b5eb                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIGNAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SIGNAL  ")))), trim_right(b"Groupchat                       "), trim_right(b"ur not invited to the cabinet group chat                                                                                                                                                                                                                                                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGNAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGNAL>>(v4);
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

