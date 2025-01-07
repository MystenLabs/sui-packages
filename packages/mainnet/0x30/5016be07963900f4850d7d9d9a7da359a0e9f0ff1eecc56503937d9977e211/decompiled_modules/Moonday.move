module 0x305016be07963900f4850d7d9d9a7da359a0e9f0ff1eecc56503937d9977e211::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/67cfaf6f-64a7-4d6d-a0b4-2f7ab219f17e/mr_orangex_a_chimpansee_in_the_style_of_the_dragonball_z_comic__367fd3b4-4f72-47a6-808e-e36c7c4df335.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/67cfaf6f-64a7-4d6d-a0b4-2f7ab219f17e/mr_orangex_a_chimpansee_in_the_style_of_the_dragonball_z_comic__367fd3b4-4f72-47a6-808e-e36c7c4df335.png"))
        };
        let v1 = b"aCHINGU";
        let v2 = b"bChingu Ape";
        let v3 = b"cChingu, the legendary Saiyan chimp warrior, trained in secret jungles by the gods of combat. With unmatched strength and a playful spirit, he fights for justice, channeling wild power in every punch!";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

