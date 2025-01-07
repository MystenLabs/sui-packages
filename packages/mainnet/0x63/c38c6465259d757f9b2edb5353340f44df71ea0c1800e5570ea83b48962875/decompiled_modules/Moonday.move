module 0x63c38c6465259d757f9b2edb5353340f44df71ea0c1800e5570ea83b48962875::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/556261ec-810a-4862-9bb1-85bb4cf3d820/relax.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/556261ec-810a-4862-9bb1-85bb4cf3d820/relax.png"))
        };
        let v1 = b"aCCC";
        let v2 = b"bCool Calm Collective";
        let v3 = b"cCool, Calm and Collective bathing in generational wealth...";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

