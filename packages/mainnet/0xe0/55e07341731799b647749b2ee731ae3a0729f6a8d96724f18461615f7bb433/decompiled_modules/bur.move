module 0xe055e07341731799b647749b2ee731ae3a0729f6a8d96724f18461615f7bb433::bur {
    struct BUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUR>(arg0, 6, b"BUR", b"BULL RUN", b"First Battle of Bull Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_13_23_26_21_A_strong_powerful_bull_standing_majestically_on_a_grassy_hill_The_bull_has_a_shiny_muscular_body_with_defined_muscles_large_horns_and_a_determine_24dc84096f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

