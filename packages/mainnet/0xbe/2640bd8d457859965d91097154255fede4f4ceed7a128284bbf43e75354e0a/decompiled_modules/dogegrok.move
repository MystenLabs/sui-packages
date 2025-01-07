module 0xbe2640bd8d457859965d91097154255fede4f4ceed7a128284bbf43e75354e0a::dogegrok {
    struct DOGEGROK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGEGROK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGEGROK>>(0x2::coin::mint<DOGEGROK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOGEGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x855b400f98a57992a804eecd047d3dbc4c0a2cead993b34ecc0e15360a21f7c6::doge::doge.png?size=lg&key=e41a16                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGEGROK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DogeGrok")))), trim_right(b"DogeGrok on Sui                 "), trim_right(b"Join the #DOGEGROK revolution today! We are a united and passionate community dedicated to safeguarding the greater good, privacy, and freedom of humanity. In #DOGEGROK, each one of us holds the power to shape the future of the financial world.                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEGROK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGEGROK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGEGROK>>(0x2::coin::mint<DOGEGROK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

