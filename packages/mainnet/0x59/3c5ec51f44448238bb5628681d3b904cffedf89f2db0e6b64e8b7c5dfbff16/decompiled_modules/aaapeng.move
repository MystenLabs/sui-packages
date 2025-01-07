module 0x593c5ec51f44448238bb5628681d3b904cffedf89f2db0e6b64e8b7c5dfbff16::aaapeng {
    struct AAAPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPENG>(arg0, 6, b"AAAPENG", b"$AAAPENG", b"AAAPENG CTO on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_12_34_18_A_humorous_avatar_design_for_the_aaapeng_token_featuring_a_playful_penguin_character_The_penguin_is_wearing_pixelated_sunglasses_and_a_gold_necklac_25e453c43d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

