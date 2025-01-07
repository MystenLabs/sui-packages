module 0x56a876507a3240ab7478678015425713a02fed897ba0903dad7fe3ee1cddce95::bib {
    struct BIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIB>(arg0, 6, b"BIB", b"BotBucks", b"Bot Intelligence Bucks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_20_11_14_33_A_logo_for_a_memecoin_called_Bot_Bucks_with_an_AI_and_robotic_theme_The_design_should_be_fun_futuristic_and_playful_with_a_robot_character_as_the_ec857818ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

