module 0xbc326692992666c3fd4187b14454e946e131b5e498f6c79767fe62ab862696dd::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/fec79254-26f9-40e7-8dee-6abf44d0bedd/VMt_cJ0W_400x400.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/fec79254-26f9-40e7-8dee-6abf44d0bedd/VMt_cJ0W_400x400.jpg"))
        };
        let v1 = b"aMOON";
        let v2 = b"bMOONDAY";
        let v3 = b"cJust Moon.day!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

