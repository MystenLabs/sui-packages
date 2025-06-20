module 0x8ac42502aacf65a173a9a8b662b2f2aabee6a683f9d3e9cafdd1e4f9a2650c2d::matrix {
    struct MATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4H4Rgr28bR6NsRc95Rk7gutrLYYemvjr9BMKSVwbpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MATRIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MATRIX      ")))), trim_right(b"Homeless Escaping The Matrix    "), trim_right(b"Helping homeless people escape The Matrix. Live on Pump Fun, Twitch, Kick and X.                                                                                                                                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATRIX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATRIX>>(v4);
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

