module 0xe7bd85b2c76367160504396ecbd2af8263d94a5cadf20c5820251d3e7f4d550b::schrdinger {
    struct SCHRDINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHRDINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHRDINGER>(arg0, 6, b"Schrdinger", b"Elon's Schrdinger", x"5765206861766520612062696720646f672063616c6c6564204761747362792c2061206c6974746c6520646f672063616c6c6564204d617276696e20746865204d61727469616e2026206120636174206e616d6564205363687264696e6765720a4750542067656e657261746564205363687264696e676572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_27_03_17_43_A_close_up_portrait_of_a_meme_worthy_cat_named_Schr_A_dinger_with_a_playful_mischievous_expression_The_cat_is_fluffy_with_gray_and_white_fur_and_its_586a83dd5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHRDINGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHRDINGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

