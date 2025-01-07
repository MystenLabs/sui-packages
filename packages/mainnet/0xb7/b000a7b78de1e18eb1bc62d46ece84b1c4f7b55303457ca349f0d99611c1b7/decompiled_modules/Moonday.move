module 0xb7b000a7b78de1e18eb1bc62d46ece84b1c4f7b55303457ca349f0d99611c1b7::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/0b932d81-000c-4837-8b8b-51eb8fa4566f/Galaxy_Wearing_Sunglasses_On_Solid_Black_Background.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/0b932d81-000c-4837-8b8b-51eb8fa4566f/Galaxy_Wearing_Sunglasses_On_Solid_Black_Background.png"))
        };
        let v1 = b"aCIRC";
        let v2 = b"bCircle";
        let v3 = b"cCircle token";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 185073541;
        if (185073541 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

