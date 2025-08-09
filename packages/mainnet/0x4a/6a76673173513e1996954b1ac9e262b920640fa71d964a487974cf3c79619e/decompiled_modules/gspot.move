module 0x4a6a76673173513e1996954b1ac9e262b920640fa71d964a487974cf3c79619e::gspot {
    struct GSPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"GIblNxfdglCJCDrR                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GSPOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GSpot       ")))), trim_right(b"GSpot Coin                      "), trim_right(b"Welcome to GSpot, the coin thats all about the ultimate questfinding that elusive sweet spot! They say its hard to find, but with GSpot, we make it fun, educational, and rewarding. More than just a memecoin, GSpot is an entire universe filled with adventure, mystery, and a rich story mode that immerses you in the thril"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSPOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSPOT>>(v4);
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

