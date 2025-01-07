module 0xc705f5c1b0c6f701e7e1da7279fd1cf676b19e210275accc081958eb8070da31::critter {
    struct CRITTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRITTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://pump.mypinata.cloud/ipfs/QmWGhzP5yB3hieyfcrUzm9AFXAKAaKP5asj7TUCDpA73ze?img-width=256&img-dpr=2&img-onerror=redirect                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CRITTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CRITTER ")))), trim_right(b"CritterCharm On TikTok          "), trim_right(b"CritterCharm, a captivating rabbit originating from Charming Critter Haven on TikTok, has already garnered over 15 million followers and more than 300 million views for its iconic appearances.                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRITTER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRITTER>>(v4);
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

