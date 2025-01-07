module 0x8292b0c0fc01568b3126414a95afc779af160e21f724f1a68a6fc8235742bc94::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/ec06b306-f56a-4bb6-a40e-94d55c022d00/e3d2e1d8d738580833e20dd22def0984.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/ec06b306-f56a-4bb6-a40e-94d55c022d00/e3d2e1d8d738580833e20dd22def0984.jpg"))
        };
        let v1 = b"aDANCE";
        let v2 = b"bDance Coin";
        let v3 = b"cDance coins";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 191894843;
        if (191894843 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

