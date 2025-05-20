module 0x6ea49f03ce025f4fd3ca76c8b50e127644acad214e7d95a8548f884ba94b5ed8::dugg {
    struct DUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AUzA9Cgzw35R49tvBtJj5G99aHYZTWx82cMqfTjnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DUGG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DUGG        ")))), trim_right(b"Doges Retarded Brother          "), trim_right(x"447567672069732074686520666f72676f7474656e2c2072657461726465642062726f74686572206f6620446f67652d636c756d73792c206d6973756e64657273746f6f642c20627574207365637265746c79206f6e20612067656e6975732d6c6576656c206d697373696f6e2e0a0a4f6e6365206c65667420696e2074686520736861646f77732c2068652773206e6f772072616c6c79696e6720616e20756e73746f707061626c6520636f6d6d756e69747920746f207265766976652074686520536f6c616e61207472656e636865732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUGG>>(v4);
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

