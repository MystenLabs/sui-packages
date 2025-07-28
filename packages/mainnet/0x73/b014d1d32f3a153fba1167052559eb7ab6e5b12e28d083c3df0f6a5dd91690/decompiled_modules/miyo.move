module 0x73b014d1d32f3a153fba1167052559eb7ab6e5b12e28d083c3df0f6a5dd91690::miyo {
    struct MIYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIYO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/83XaBnHkt3MFbGiqx7y1VpAYGTqCQon6i3isVPmQbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MIYO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Miyo        ")))), trim_right(b"Mi-Young                        "), trim_right(b"The darkest cat on the Bonk ecosystem. Mi-Young is Korean for \"Eternal Beauty\". Through pop culture, visual aesthetics, behavioral perception, and cultural symbolism - $Miyo is here to add a little magic and mysteriousness to the market.                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIYO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIYO>>(v4);
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

