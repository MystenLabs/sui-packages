module 0xdb9457cad0125998948ecf2b85e799e599091e9d46523b1413ea2195393bfd60::mzynar {
    struct MZYNAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZYNAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3f8c49d86ec59c24de29fa4c68bfec566232bf0ae3edc5269b71b96359d099f3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MZYNAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MZYNAR      ")))), trim_right(b"Mzynar                          "), trim_right(b"$MZYNAR powers the most complete privacy suite on Solana: shielded swaps, anonymous transfers, stealth addresses, OTC marketplace and cross-chain privacy bridge. Default privacy, minimal fees, maximum freedom.                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZYNAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MZYNAR>>(v4);
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

