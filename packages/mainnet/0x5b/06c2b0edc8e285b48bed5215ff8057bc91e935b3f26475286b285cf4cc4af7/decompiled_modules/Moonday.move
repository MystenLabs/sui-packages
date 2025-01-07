module 0x5b06c2b0edc8e285b48bed5215ff8057bc91e935b3f26475286b285cf4cc4af7::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/725c853e-c776-42a9-958c-18809673827c/thunder.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/725c853e-c776-42a9-958c-18809673827c/thunder.webp"))
        };
        let v1 = b"aTHUNDER";
        let v2 = b"bThunder AI";
        let v3 = b"cBy the ower of thor I command you to follow my lead to glory";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

