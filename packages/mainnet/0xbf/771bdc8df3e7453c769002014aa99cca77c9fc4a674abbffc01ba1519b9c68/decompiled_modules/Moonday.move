module 0xbf771bdc8df3e7453c769002014aa99cca77c9fc4a674abbffc01ba1519b9c68::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/6a0a6721-8b1d-473c-ac2f-b38f5f7efe28/Gbzi0weWwAM2CLD.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/6a0a6721-8b1d-473c-ac2f-b38f5f7efe28/Gbzi0weWwAM2CLD.jpg"))
        };
        let v1 = b"aAKITA";
        let v2 = b"bAKITA on SUI";
        let v3 = b"cAKITA - The first dog on Moonday!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

