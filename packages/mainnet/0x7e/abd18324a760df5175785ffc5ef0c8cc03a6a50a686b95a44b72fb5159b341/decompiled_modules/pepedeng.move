module 0x7eabd18324a760df5175785ffc5ef0c8cc03a6a50a686b95a44b72fb5159b341::pepedeng {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDENG>(arg0, 6, b"PEPEDENG", b"pepe in a moodeng world", b"pepe is now in a moodeng world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_28_15_48_40_A_lively_and_humorous_scene_featuring_multiple_Pepe_the_Frog_meme_characters_along_with_a_family_of_hippopotamuses_and_a_family_of_cats_The_Pepe_cha_18ac1b7ada.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

