module 0x439f41efe604d3faaa4dd351375516a7407ec6ecaf33b63ff0f60c8ad1410ab2::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/c49d8868-9aab-4eee-a94d-c828e8770fb9/cute-funny-laptop-waving-hand-character_464314-1806.avif" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/c49d8868-9aab-4eee-a94d-c828e8770fb9/cute-funny-laptop-waving-hand-character_464314-1806.avif"))
        };
        let v1 = b"aLAPTOP";
        let v2 = b"bLaptop";
        let v3 = b"cLaptop token";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 186040401;
        if (186040401 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

