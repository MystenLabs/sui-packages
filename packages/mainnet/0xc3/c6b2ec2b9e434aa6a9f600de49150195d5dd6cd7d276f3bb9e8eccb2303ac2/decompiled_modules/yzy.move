module 0xc3c6b2ec2b9e434aa6a9f600de49150195d5dd6cd7d276f3bb9e8eccb2303ac2::yzy {
    struct YZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YZY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/WW3n3o75qQcbUPPycap8QM7TgJZ1Geddv6XVX9pVXjQ.png?claimId=dGYGSGtRtTMHB1MS                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YZY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YZY         ")))), trim_right(b"YZY                             "), trim_right(x"5448495320495320544845203173742024595a59204d4f4e4559205052452d4c41554e4348204d454d4520544f4b454e204558434c55534956454c59204f4e20534f4c414e410a0a4e4f204f54484552204d454d4520434f494e20494e2043525950544f20484953544f5259204841532041203135304d205350494b450a0a24595a595f4d4e5920534f4c414e41204d454d452020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YZY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YZY>>(v4);
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

