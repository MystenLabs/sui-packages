module 0x461a770a42a691c61655ea4d9a2d7882d64f577a214352341decba2c06b43100::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/9373f9d5-a6c5-4afd-be63-31b580aefa9f/Monk.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/9373f9d5-a6c5-4afd-be63-31b580aefa9f/Monk.png"))
        };
        let v1 = b"aMONKY";
        let v2 = b"bMonky";
        let v3 = b"cI used to meditate on enlightenment, but then I discovered memecoins and, well, nirvana can wait! Now I live for market swings and virtual banana beer. HODL? ";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

