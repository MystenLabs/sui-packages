module 0x1756dad12b53991655d840f7574da13a9dc679ccc1844b9a5373438f46277215::suigon {
    struct SUIGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGON>(arg0, 6, b"SUIGON", b"Dragon of Sui", b"Unleashing fiery strength and mystic power, $SUIGON is the dragon that soars above the Sui skies. Majestic and fierce, this tokens got fire in its veins. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_UPA_revival_art_style_thick_lines_cartoon_logo_design_8782d47c_973a_471d_b34a_0c8e61c62e32_2_f099de8ce6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

