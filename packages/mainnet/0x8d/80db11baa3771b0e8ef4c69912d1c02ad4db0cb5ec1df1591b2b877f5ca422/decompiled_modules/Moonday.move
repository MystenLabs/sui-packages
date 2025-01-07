module 0x8d80db11baa3771b0e8ef4c69912d1c02ad4db0cb5ec1df1591b2b877f5ca422::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/7f02c306-cd11-4a4d-8985-7d6da1b57236/dinocoin.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/7f02c306-cd11-4a4d-8985-7d6da1b57236/dinocoin.webp"))
        };
        let v1 = b"aDINO";
        let v2 = b"bDino Coin";
        let v3 = b"cThis is the dino Coin. Lets go to moon.";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 192397186;
        if (192397186 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

