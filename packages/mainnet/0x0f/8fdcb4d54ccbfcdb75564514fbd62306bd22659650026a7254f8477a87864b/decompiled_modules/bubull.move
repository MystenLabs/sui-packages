module 0xf8fdcb4d54ccbfcdb75564514fbd62306bd22659650026a7254f8477a87864b::bubull {
    struct BUBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBULL>(arg0, 6, b"BUBULL", b"BLUE BULL", b"SUI launched the new SUI mascot: Blue Bull in 2024 as an effort to bring hope and encouragement to the industry. Blue Bull token represents the community, vitality, and encouragement that was brought to SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_14_50_59_A_promotional_image_for_the_Blue_Bull_token_featuring_the_cute_and_cartoonish_blue_bull_mascot_with_big_round_eyes_and_a_cheerful_expression_The_ae9af7dfe1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

