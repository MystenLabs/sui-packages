module 0x362e7a3c2349b2d0fd55359fe0f3a3b989fb5e3cc919fdbbd376919fe1698ae3::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/50fa9bf9-21a5-48c2-95e3-7d38d41df7fa/aiwiz.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/50fa9bf9-21a5-48c2-95e3-7d38d41df7fa/aiwiz.png"))
        };
        let v1 = b"aAIWIZ";
        let v2 = b"bAI Wizard";
        let v3 = b"cThe ultimate degen spellcaster ruling the crypto realm! This AI wizard doesn't just predict the market, he bends it to his will. Get in, ride the magic, and let the wizard lead you to those degen gains!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

