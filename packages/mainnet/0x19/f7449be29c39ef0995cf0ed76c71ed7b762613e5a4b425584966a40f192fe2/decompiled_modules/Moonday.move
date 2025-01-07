module 0x19f7449be29c39ef0995cf0ed76c71ed7b762613e5a4b425584966a40f192fe2::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/8feaa592-ccb3-499f-972d-187085d868b0/couple-dance-illustration_195186-3680.avif" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/8feaa592-ccb3-499f-972d-187085d868b0/couple-dance-illustration_195186-3680.avif"))
        };
        let v1 = b"aBDNCE";
        let v2 = b"bBetter Dancer";
        let v3 = b"cCoin to support better dancers";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 192624404;
        if (192624404 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

