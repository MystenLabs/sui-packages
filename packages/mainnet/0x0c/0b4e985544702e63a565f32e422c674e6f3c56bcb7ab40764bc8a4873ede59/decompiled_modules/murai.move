module 0xc0b4e985544702e63a565f32e422c674e6f3c56bcb7ab40764bc8a4873ede59::murai {
    struct MURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAI>(arg0, 6, b"MURAI", b"Suimurai", b"SUImurai  Slashing through the crypto battlefield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_13_11_27_16_A_playful_childlike_drawing_of_a_samurai_character_named_SUIMURAI_The_character_is_a_cute_cartoonish_samurai_wearing_traditional_armor_but_in_a_s_f71cbd9b81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

