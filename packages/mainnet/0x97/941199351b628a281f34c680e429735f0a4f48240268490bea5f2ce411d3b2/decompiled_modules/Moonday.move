module 0x97941199351b628a281f34c680e429735f0a4f48240268490bea5f2ce411d3b2::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/5904c5e1-8508-40be-aae9-31048fec0907/Untitled_design.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/5904c5e1-8508-40be-aae9-31048fec0907/Untitled_design.png"))
        };
        let v1 = b"a$MOON";
        let v2 = b"bMOONSHOT";
        let v3 = x"634d6f6f6e73686f742e0d0a0d0a4e6f20736f6369616c732c206a75737420676f6f642076696265732e";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

