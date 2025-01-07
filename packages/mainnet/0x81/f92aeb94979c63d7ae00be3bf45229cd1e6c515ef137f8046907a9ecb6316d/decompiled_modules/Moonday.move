module 0x81f92aeb94979c63d7ae00be3bf45229cd1e6c515ef137f8046907a9ecb6316d::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/01341c92-edbc-4783-a138-46d4841ced89/Fastest-Flying-Insect-is-the-Dragonfly-1199x630.jpeg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/01341c92-edbc-4783-a138-46d4841ced89/Fastest-Flying-Insect-is-the-Dragonfly-1199x630.jpeg"))
        };
        let v1 = b"aDRAGON";
        let v2 = b"bDrago";
        let v3 = b"cDragon coin";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 186031542;
        if (186031542 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

