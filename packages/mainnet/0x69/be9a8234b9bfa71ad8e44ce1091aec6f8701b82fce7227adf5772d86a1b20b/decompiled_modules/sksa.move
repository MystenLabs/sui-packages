module 0x69be9a8234b9bfa71ad8e44ce1091aec6f8701b82fce7227adf5772d86a1b20b::sksa {
    struct SKSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKSA>(arg0, 6, b"SKSA", b"SuikasaFi", b"Ai Sci-Fi meme token with zombie issues ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_robust_resident_ev_b662054997.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

