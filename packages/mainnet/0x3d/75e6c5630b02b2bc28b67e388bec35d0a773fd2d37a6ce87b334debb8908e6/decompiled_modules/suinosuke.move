module 0x3d75e6c5630b02b2bc28b67e388bec35d0a773fd2d37a6ce87b334debb8908e6::suinosuke {
    struct SUINOSUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOSUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOSUKE>(arg0, 6, b"SUINOSUKE", b"SUINOSUKE NOHARA", b"\"I'm not small, I'm just fun-sized!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_25_cfd0394178.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOSUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOSUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

