module 0x8310a80ce5fc17afa1a897c213cd1799e660a866994aba1c13887315401c404::purrfect {
    struct PURRFECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRFECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRFECT>(arg0, 6, b"Purrfect", b"Purrfect Pussy Cat", b"Purrfect Pussy Cat is a modern woman's perfect companion. Most so-called modern women claim that they don't need a man. Purrfect  Pussy Cat agrees. He believes that all modern women who don't need a man should become cat ladies. He is an eligible bachelor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_american_high_fashion_cat_in_an_urban_setting_closeup_view_with_plain_background_formal_male_attire_1_ffd02d20d5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRFECT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURRFECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

