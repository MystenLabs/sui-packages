module 0xf19980fc65579bbf56f0da7356c61bcd50df310ee03a28fa4c51973df9a53fe3::suiragon {
    struct SUIRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAGON>(arg0, 6, b"SUIRAGON", b"Sui Dragon", b"Meet Sui Dragon ($SUIRAGON) the fiery beast that breathes under water. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_UPA_revival_art_style_thick_lines_cartoon_logo_design_8782d47c_973a_471d_b34a_0c8e61c62e32_1_1_7caee2dffc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

