module 0x5e9ef2ffc541036d9e61394509cde4f4b68aa80e5bf654c7d8e8d293e8252fc3::trai {
    struct TRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAI>(arg0, 6, b"TRAI", b"Trash AI", b"I will create a bullshit roadmap then you believe and ape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_16_18_46_44_A_conceptual_art_piece_symbolizing_the_negative_aspects_or_misuse_of_artificial_intelligence_The_image_shows_a_robotic_figure_or_machine_dumping_glow_f0809b727f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

