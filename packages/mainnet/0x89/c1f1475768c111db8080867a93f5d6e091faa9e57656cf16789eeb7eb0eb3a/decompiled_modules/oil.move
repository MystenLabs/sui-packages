module 0x89c1f1475768c111db8080867a93f5d6e091faa9e57656cf16789eeb7eb0eb3a::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HjzW3cWKctHxiVow1aco4zcDcyVhW85BS8VpjKY6pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OIL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OIL         ")))), trim_right(b"Black Gold                      "), trim_right(b"Oil, often dubbed \"black gold,\" is a cornerstone of global energy, driving transportation and industry with its vast potential. Under Donald Trumps leadership, the U.S. embraced its \"liquid gold\" reserves, pushing policies to boost oil production and reduce energy costs, aiming to bolster economic strength and global i"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIL>>(v4);
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

