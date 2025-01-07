module 0x7f519d5fa30e6d029fbe97b91e0e74d44c81ad00e7bf283b6a56b28d95a58dc1::gnf {
    struct GNF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GNF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GNF>>(0x2::coin::mint<GNF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GNF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4dpkB1pjkTY46uby65YxXZ7CH4pbhimLbQP2rURbcDob.png?size=lg&key=ae12a1                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GNF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GNF     ")))), trim_right(b"Gain Frog                       "), trim_right(b"Our muscular green champion isnt just a memeits a movement. Gain Frog combines fun, community, and tokenomics that are designed to pump harder than your post-gym protein shake.                                                                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GNF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GNF>>(0x2::coin::mint<GNF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

