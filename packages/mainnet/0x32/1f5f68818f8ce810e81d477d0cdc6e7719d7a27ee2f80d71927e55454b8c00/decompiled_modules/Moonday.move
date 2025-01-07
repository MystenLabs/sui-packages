module 0x321f5f68818f8ce810e81d477d0cdc6e7719d7a27ee2f80d71927e55454b8c00::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/9f3cba13-b41a-4775-923e-485bf6264fc2/Gbzi0weWwAM2CLD.jpg" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/9f3cba13-b41a-4775-923e-485bf6264fc2/Gbzi0weWwAM2CLD.jpg"))
        };
        let v1 = b"aAKITA";
        let v2 = b"bAKITA on SUI";
        let v3 = b"cAKITA - The first dog on Moon.day";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

