module 0xfa5821d07c42c2550b0e88d3d9a28ba4d3bfce0695fa1824fa3e6c69c9c46fad::aqgr {
    struct AQGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQGR>(arg0, 6, b"AQGR", b"AquaGrace", b"AquaGrace embodies the serene elegance of a blue shark gliding through the ocean, capturing the beauty and tranquility of the underwater world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_15_00_37_28_A_blue_shark_swimming_gracefully_in_the_ocean_The_shark_has_sleek_lines_and_a_bright_blue_color_with_a_gentle_yet_majestic_expression_The_backgroun_8fe2d94b60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

