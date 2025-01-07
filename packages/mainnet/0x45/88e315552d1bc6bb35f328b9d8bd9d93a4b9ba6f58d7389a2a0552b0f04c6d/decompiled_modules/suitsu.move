module 0x4588e315552d1bc6bb35f328b9d8bd9d93a4b9ba6f58d7389a2a0552b0f04c6d::suitsu {
    struct SUITSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITSU>(arg0, 6, b"SUITSU", b"Suitsu", b"SuITSU PI KA KA KAK AK A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_15_19_23_10_A_vibrant_and_fun_illustration_featuring_an_original_blue_electric_themed_creature_similar_to_the_SUI_chu_character_riding_on_a_rocket_The_creatur_1ee8ec7087.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

