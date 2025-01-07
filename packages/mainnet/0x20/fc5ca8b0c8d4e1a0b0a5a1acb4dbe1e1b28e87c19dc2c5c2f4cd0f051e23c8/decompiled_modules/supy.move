module 0x20fc5ca8b0c8d4e1a0b0a5a1acb4dbe1e1b28e87c19dc2c5c2f4cd0f051e23c8::supy {
    struct SUPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bykzp3Bd3hDFUEiVHJkmg9oMcFsKLbmMHLCJsu4Fpump.png?size=lg&key=e6d7ab                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUPY    ")))), trim_right(b"SUPY                            "), trim_right(b"When $pupy hits the market, everyone stops their crypto rubs. With his meme posture alone, the little guy says - STOP FIGHTING, Fu*k, IT'S TIME TO HOLD! His little paws are doing big things in the crypt, stopping wars.                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPY>>(v4);
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

