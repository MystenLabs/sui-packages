module 0x6961171bd55bb5d4a6e2f1a4ed9e0073a65c2bc041c0bc4c453b5ff26e3829f2::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUG>>(0x2::coin::mint<PUG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4FBr6xMkvVzgYyPBaesDmgiaaQncptedZuUU4d28pump.png?size=lg&key=187854                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUG     ")))), trim_right(b"Pump Up God                     "), trim_right(b"Pug is surfing on his jetski while dolphins are jumping around him and whales are swimming.                                                                                                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PUG>>(0x2::coin::mint<PUG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

