module 0x5923e96a45e0be743b38802623a6ea5c23bac5b4c9fd8640150a8049f4e249cb::inx {
    struct INX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<INX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INX>>(0x2::coin::mint<INX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: INX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/fadbe0c7c9d08dc9734e18f2d0d3f7e2028d9985d86d3910c5d503706892e6f2?width=64&height=64&fit=crop&quality=95&format=auto                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<INX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"INX     ")))), trim_right(b"Infinex                         "), trim_right(b"A new kind of crypto superapp. Unified portfolio. Serious Opsec. Built-in multi-provider trading.                                                                                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<INX>>(0x2::coin::mint<INX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

