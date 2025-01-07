module 0xcfd40d2d410a9570ec8a77063a40a2a244fbc43ac6feeb5bf96c989047fa031b::mofa {
    struct MOFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOFA>(arg0, 6, b"MOFA", b"Make Orwell Fiction Again", b"The new reality ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6913_271f03e065.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

