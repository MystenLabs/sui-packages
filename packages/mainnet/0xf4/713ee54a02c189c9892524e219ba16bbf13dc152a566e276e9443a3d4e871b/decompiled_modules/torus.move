module 0xf4713ee54a02c189c9892524e219ba16bbf13dc152a566e276e9443a3d4e871b::torus {
    struct TORUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmSBhMrf5mKVAt5h3fu2CJB26Y9LEbskkJazJMedL6ggag                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TORUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TORUS   ")))), trim_right(b"The Torus Network               "), trim_right(b"TORUS magnetically draws SUI coins together, manifesting the best price. We provide pools that link SUI, haSUI, vSUI, afSUI, and sSUI. 100% liquidity locked, 4.20M tokens per pool. Private experimental project, not an investment token.                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORUS>>(v4);
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

