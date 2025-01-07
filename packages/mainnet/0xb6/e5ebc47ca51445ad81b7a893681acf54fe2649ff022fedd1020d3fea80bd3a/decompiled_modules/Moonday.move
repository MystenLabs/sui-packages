module 0xb6e5ebc47ca51445ad81b7a893681acf54fe2649ff022fedd1020d3fea80bd3a::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/a5a62a43-2808-4132-9d24-89a9069f83a5/Minimalist_Raccoon_Face_With_Sunglasses_On_Black_Background.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/a5a62a43-2808-4132-9d24-89a9069f83a5/Minimalist_Raccoon_Face_With_Sunglasses_On_Black_Background.png"))
        };
        let v1 = b"aRAC";
        let v2 = b"bRaccoon";
        let v3 = b"cRacoon token";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 184637689;
        if (184637689 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

