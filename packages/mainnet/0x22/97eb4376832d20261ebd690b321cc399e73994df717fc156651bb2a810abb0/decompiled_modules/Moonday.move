module 0x2297eb4376832d20261ebd690b321cc399e73994df717fc156651bb2a810abb0::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/c6fb1765-16b1-4ec6-9ee4-72a6600f20fd/mochi1.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/c6fb1765-16b1-4ec6-9ee4-72a6600f20fd/mochi1.jpg"))
        };
        let v1 = b"aMOCHI";
        let v2 = b"bMochi";
        let v3 = b"cThe fluffly, squishy and hungry blob living his best life in the Sui universe.";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

