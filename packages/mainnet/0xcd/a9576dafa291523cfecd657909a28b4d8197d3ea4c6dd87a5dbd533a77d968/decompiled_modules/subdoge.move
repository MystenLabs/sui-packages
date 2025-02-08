module 0xcda9576dafa291523cfecd657909a28b4d8197d3ea4c6dd87a5dbd533a77d968::subdoge {
    struct SUBDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/bL19NBXBQhuSTb3Bv4YEZDRHVhsp3e343a5Szv1pump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUBDOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUBDOGE     ")))), trim_right(b"Doge Subcommittee               "), trim_right(b"House Subcommittee on Delivering on Government Efficiency Est. 2025 | Account created and managed by the personal office of Chairwoman                                                                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBDOGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBDOGE>>(v4);
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

