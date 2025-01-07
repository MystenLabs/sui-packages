module 0xcfcd95e7873000fd155a77d8737a88e4b6161ce4a15b728faeb9d17f254ded7b::hny2025 {
    struct HNY2025 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HNY2025>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HNY2025>>(0x2::coin::mint<HNY2025>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HNY2025, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6Y9bduDh9RHgA9PLj6HxbMz66pihtXkpD84HAhEnpump.png?size=lg&key=80dd3c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HNY2025>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HNY2025 ")))), trim_right(b"Happy New Year 2025             "), trim_right(b"Happy New Year ($HNY)  Start the new year with $HNY, the crypto that turns every beginning into a celebration.  Dont be the person explaining why you missed out - celebrate with us or regret it all year!                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNY2025>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HNY2025>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HNY2025>>(0x2::coin::mint<HNY2025>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

