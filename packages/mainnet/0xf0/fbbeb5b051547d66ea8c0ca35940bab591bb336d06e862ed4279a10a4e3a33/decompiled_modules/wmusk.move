module 0xf0fbbeb5b051547d66ea8c0ca35940bab591bb336d06e862ed4279a10a4e3a33::wmusk {
    struct WMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreihn6u66ciebspcetvfvyh7wbmrd6xi7i7eibed4myyezw6e2kzfgu                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<WMUSK>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WMUSK   ")))), trim_right(b"WAYE MUSL                       "), trim_right(b"WAYE MUSK is a pioneering digital token in the AI agent ecosystem featuring futuristic aesthetics with circuit board patterns and neon green accents It embodies innovation while ensuring accessibility The sleek black design with the LX logo reflects a professional and cutting edge presence in the digital economy       "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<WMUSK>>(0x2::coin::mint<WMUSK>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WMUSK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMUSK>>(v3);
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

