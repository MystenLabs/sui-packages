module 0x9c515c6e4ea5593f6e6611dfc11dcdac5e4d85aa7d8bc72af5dff80ee22d3fc9::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/20587886-0689-4086-8e33-d1ec3da0f30a/GabHNedXkAAMHOy.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/20587886-0689-4086-8e33-d1ec3da0f30a/GabHNedXkAAMHOy.jpg"))
        };
        let v1 = b"aAAA";
        let v2 = b"bAAA-Moonday";
        let v3 = b"cCant Stop Wont Stop";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

