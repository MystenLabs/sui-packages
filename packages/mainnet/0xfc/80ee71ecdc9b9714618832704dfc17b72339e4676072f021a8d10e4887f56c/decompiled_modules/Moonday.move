module 0xfc80ee71ecdc9b9714618832704dfc17b72339e4676072f021a8d10e4887f56c::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/d6a3f503-48ff-4fce-b441-21c3d90fa5f1/Sui_logo_sea_1200x720_1705946671zSLPXgx87z.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/d6a3f503-48ff-4fce-b441-21c3d90fa5f1/Sui_logo_sea_1200x720_1705946671zSLPXgx87z.jpg"))
        };
        let v1 = b"TEST";
        let v2 = b"Test Coin";
        let v3 = b"THis is a test coin to buy and sell";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 203692566;
        if (203692566 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

