module 0x63c64d2b1dca5fed53e9684003d6c5dc0dc67271cb9f7b34945c24bbf41a274b::gort {
    struct GORT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GORT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GORT>>(0x2::coin::mint<GORT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EdTcPriYAHEgGrf2G7mSJ9aD8kYDfvnBSWHJpfgxGF5r.png?size=lg&key=88edb4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GORT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Gort    ")))), trim_right(b"His name Gort                   "), trim_right(b"Who or What is Gort? Gort is a vague, usually humanoid character who started popping up in random online posts, especially on platforms like Tumblr and Twitter. No one really knows what or who Gort is, but thats the point. Gort is just Gort.                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GORT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GORT>>(0x2::coin::mint<GORT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

