module 0xab102dbedd14744efc0632429046f42cbd28fefdade1754452da7206c3c6e20b::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/bab10c31-d609-4817-bd4d-31f8643e7c45/wizard.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/bab10c31-d609-4817-bd4d-31f8643e7c45/wizard.png"))
        };
        let v1 = b"AIWIZ";
        let v2 = b"AI Wizard";
        let v3 = b"The ultimate degen spellcaster ruling the crypto realm! This AI wizard doesn't just predict the market, he bends it to his will. Get in, ride the magic, and let the wizard lead you to those degen gains!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 208109318;
        if (208109318 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

