module 0x74eb3d4e8eb22902738a557e7f20186208bc916e5bac1dd622a14cfad694acf7::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/967b59ca-b602-4a03-a2ab-12315ab794cc/Diamondhand.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/967b59ca-b602-4a03-a2ab-12315ab794cc/Diamondhand.webp"))
        };
        let v1 = b"aDIAMOND";
        let v2 = b"bDiamond Hands";
        let v3 = b"cGet rid of all these paperhand loser and join the diamond hand community for bigger gains, BELIEVE in something!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

