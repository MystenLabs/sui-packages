module 0x256a9c2ebb0619a4be5903690ee71b3e27640edf9a52ef479e03f3e5db70772f::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/d87b080c-f6c8-40f5-9e1b-31b4233f7402/Sui_logo_sea_1200x720_1705946671zSLPXgx87z.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/d87b080c-f6c8-40f5-9e1b-31b4233f7402/Sui_logo_sea_1200x720_1705946671zSLPXgx87z.jpg"))
        };
        let v1 = b"a010";
        let v2 = b"bTESTING010";
        let v3 = b"cTesting coin 0101";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 189114814;
        if (189114814 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

