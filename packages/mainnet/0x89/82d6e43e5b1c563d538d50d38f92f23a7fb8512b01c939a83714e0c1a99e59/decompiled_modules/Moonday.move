module 0x8982d6e43e5b1c563d538d50d38f92f23a7fb8512b01c939a83714e0c1a99e59::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/ecc2837e-3a2d-4eb2-9c78-85a48110e6a7/moonphasecoin.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/ecc2837e-3a2d-4eb2-9c78-85a48110e6a7/moonphasecoin.webp"))
        };
        let v1 = b"aMPC";
        let v2 = b"bMoon Phase Coin";
        let v3 = b"cTHis is moon phase coin.   we are going to the moon....";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 190203240;
        if (190203240 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

