module 0x832ad32dfdda557a32bd491a681fb36c043fbdefa5f888ad9d6e4349f551624c::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"SUIPREME", b"Suipreme", b"SUIPREME is a meme token combining the hype of Supreme with the power of SUI. Exclusive, fun, and for the cultureperfect for streetwear and crypto lovers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_09_20_002453_21a988686c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

