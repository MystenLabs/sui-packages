module 0xb97178d68d2633365287489181eb846b0dddcfae27433682d686cb55f5cf3687::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/dc322a55-362e-42c2-95c8-c3c76653e999/Diamondhand.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/dc322a55-362e-42c2-95c8-c3c76653e999/Diamondhand.webp"))
        };
        let v1 = b"aDIAMOND";
        let v2 = b"bDiamond Hands";
        let v3 = b"cGet rid of all these paperhand loser and join the diamond hand community for bigger gains, BELIEVE in something!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 185798803;
        if (185798803 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

