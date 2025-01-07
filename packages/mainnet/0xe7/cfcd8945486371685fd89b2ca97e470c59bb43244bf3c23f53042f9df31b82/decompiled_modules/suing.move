module 0xe7cfcd8945486371685fd89b2ca97e470c59bb43244bf3c23f53042f9df31b82::suing {
    struct SUING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUING>(arg0, 6, b"SUING", b"SUING TOO HIGH", b"\"Hey Moon,\" he called out, \"you ever get puffy eyes from staying up all night?\" The moon didn't answer, but a sudden breeze made the swing sway higher, as if the universe was sharing a silent chuckle with him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_24_10_42_43_Design_a_logo_for_a_memecoin_called_Suing_Too_High_featuring_a_humorous_and_edgy_theme_Include_a_cartoon_swing_going_extremely_high_with_a_charac_91c65e810c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUING>>(v1);
    }

    // decompiled from Move bytecode v6
}

