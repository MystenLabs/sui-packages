module 0xcb383a503fa877aa04d9a881a4d50cb83d1940d11598969f577f653dcb33a48::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/60115582-7130-4cbf-a761-22dc6e5a78c6/aiwiz.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/60115582-7130-4cbf-a761-22dc6e5a78c6/aiwiz.png"))
        };
        let v1 = b"aAIWIZ";
        let v2 = b"bAI Wizard";
        let v3 = b"cThe ultimate degen spellcaster ruling the crypto realm! This AI wizard doesn't just predict the market, he bends it to his will. Get in, ride the magic, and let the wizard lead you to those degen gains!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 185621704;
        if (185621704 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

