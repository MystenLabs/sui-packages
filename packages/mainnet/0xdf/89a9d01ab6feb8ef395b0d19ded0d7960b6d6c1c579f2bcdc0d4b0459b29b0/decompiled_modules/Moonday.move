module 0xdf89a9d01ab6feb8ef395b0d19ded0d7960b6d6c1c579f2bcdc0d4b0459b29b0::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/0517db5a-b7ea-47ef-ba27-2d4f6c508ac4/Goldengoat.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/0517db5a-b7ea-47ef-ba27-2d4f6c508ac4/Goldengoat.png"))
        };
        let v1 = b"aGOAT";
        let v2 = b"bGolden Goat";
        let v3 = b"cA mystical creature said to wander hidden valleys, leaving trails of gold dust and secrets. Some say catching a glimpse brings fortune, but only the brave dare to seek its golden glow!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 186239599;
        if (186239599 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

