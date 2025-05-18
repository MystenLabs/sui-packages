module 0xcf88b4809e6b4c8ca4b4ca71621820559fb57f3939c3e3057aed53b8ca51e3ed::holder {
    struct HOLDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GCx3DgxM6UUXwNWd71rozY8SD4s8LWNVpb2c4z9fpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOLDER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HOLDER      ")))), trim_right(b"HolderScore                     "), trim_right(b"Welcome to HolderScore, the innovative platform revolutionizing how crypto communities reward and empower token holders. Founded in 2025 by a passionate team of blockchain enthusiasts, developers, and community builders, HolderScore is dedicated to creating a transparent, engaging, and rewarding ecosystem for crypto in"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLDER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLDER>>(v4);
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

