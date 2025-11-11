module 0x4fccca17cac05f8f918c61ef754da4f67caca8dbe0537605dd992e38379e9655::incog {
    struct INCOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<INCOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INCOG>>(0x2::coin::mint<INCOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: INCOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/2dca3d4a54f0dac362841ffb31e81cd4871b84259fb9eff8e3895c8286398e02?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<INCOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"INCOG   ")))), trim_right(b"Incognito                       "), trim_right(b"Welcome to INCOGNITO - the original mascot of privacy. This token represents the timeless pursuit of digital anonymity. Trade freely, browse privately, stay anonymous.                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INCOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INCOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<INCOG>>(0x2::coin::mint<INCOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

