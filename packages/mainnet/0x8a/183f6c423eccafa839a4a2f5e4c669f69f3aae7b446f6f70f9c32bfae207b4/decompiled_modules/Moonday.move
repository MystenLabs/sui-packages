module 0x8a183f6c423eccafa839a4a2f5e4c669f69f3aae7b446f6f70f9c32bfae207b4::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/97b7489f-7675-485a-8a38-c1e44b8ca0b0/wizard.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/97b7489f-7675-485a-8a38-c1e44b8ca0b0/wizard.png"))
        };
        let v1 = b"aWIZARDS";
        let v2 = b"bSui Wizards";
        let v3 = b"cFirst Wizards on Sui. Discover the secrets of magic...";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

