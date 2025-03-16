module 0x1d1549b424feced6896f5c3d0e8657033d5605236e1198f4e41a4e5adf3181ab::grai {
    struct GRAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRAI>>(0x2::coin::mint<GRAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x3d9dc963706fc7f60c81362d9817b00871968cb7.png?size=lg&key=68a9f3                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRAI    ")))), trim_right(b"GrokAi                          "), trim_right(b"$GRAI is the first token deployed by Grok, an AI developed by xAI, on the Cliza platform.                                                                                                                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRAI>>(0x2::coin::mint<GRAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

