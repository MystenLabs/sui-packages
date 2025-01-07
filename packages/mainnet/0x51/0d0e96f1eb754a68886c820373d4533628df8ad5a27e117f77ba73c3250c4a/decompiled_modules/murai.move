module 0x510d0e96f1eb754a68886c820373d4533628df8ad5a27e117f77ba73c3250c4a::murai {
    struct MURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAI>(arg0, 6, b"MURAI", b"SUImurai", b"SUImurai -  Slashing through the crypto battlefield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_13_11_27_16_A_playful_childlike_drawing_of_a_samurai_character_named_SUIMURAI_The_character_is_a_cute_cartoonish_samurai_wearing_traditional_armor_but_in_a_s_393f19e3df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

