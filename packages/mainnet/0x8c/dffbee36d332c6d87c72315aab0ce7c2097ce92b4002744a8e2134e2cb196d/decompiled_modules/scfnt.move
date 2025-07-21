module 0x8cdffbee36d332c6d87c72315aab0ce7c2097ce92b4002744a8e2134e2cb196d::scfnt {
    struct SCFNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCFNT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CMe23KMuWpD1PGq3B1gpu7evYCLRj33e4Ba9UCMsbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SCFNT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SCFNT       ")))), trim_right(b"SCF: New Testament              "), trim_right(b"The New Testament of the Church of the Smoking Chicken Fish, created by the legal owner of the church on Bonk                                                                                                                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCFNT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCFNT>>(v4);
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

