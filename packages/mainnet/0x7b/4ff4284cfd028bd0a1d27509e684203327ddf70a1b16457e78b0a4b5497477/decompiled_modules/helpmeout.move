module 0x7b4ff4284cfd028bd0a1d27509e684203327ddf70a1b16457e78b0a4b5497477::helpmeout {
    struct HELPMEOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELPMEOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELPMEOUT>(arg0, 6, b"HelpMeOut", b"HelpToken", b"Help you out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_06_07_41_29_A_cartoon_style_image_featuring_a_blue_bull_with_wild_orange_hair_labeled_Team_Bull_and_a_futuristic_eagle_labeled_Team_Eagle_Both_characters_sta_358c92f4f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELPMEOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELPMEOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

