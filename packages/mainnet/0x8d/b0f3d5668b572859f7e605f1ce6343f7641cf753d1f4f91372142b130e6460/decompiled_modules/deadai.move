module 0x8db0f3d5668b572859f7e605f1ce6343f7641cf753d1f4f91372142b130e6460::deadai {
    struct DEADAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADAI>(arg0, 6, b"DEADAI", b"DEAD AI", b"The bot will be activated at 15k Market Cap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_05_11_08_18_An_epic_and_vibrant_illustration_featuring_a_mini_superhero_character_inspired_by_the_uploaded_image_The_character_is_a_chibi_style_hero_wearing_a_re_6f250e3ad8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEADAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

