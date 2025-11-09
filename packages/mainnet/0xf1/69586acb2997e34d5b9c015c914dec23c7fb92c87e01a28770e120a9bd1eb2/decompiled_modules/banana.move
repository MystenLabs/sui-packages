module 0xf169586acb2997e34d5b9c015c914dec23c7fb92c87e01a28770e120a9bd1eb2::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4ce703eb969c88177134e756099e500d09e39822b2b8a4bbbd076bb5258443c0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BANANA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BANANA      ")))), trim_right(b"Banana Dex                      "), trim_right(b"BananaDex is a professional-grade decentralized perpetual futures exchange built on Solana, delivering up to 100 leverage, low trading fees, and sub-millisecond execution. With deep liquidity, audited smart contracts, and institutional-grade API access, it offers cross-margin trading, advanced order types, and redundan"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v4);
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

