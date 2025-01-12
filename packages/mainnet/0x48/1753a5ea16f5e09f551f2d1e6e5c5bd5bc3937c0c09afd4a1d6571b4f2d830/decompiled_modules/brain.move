module 0x481753a5ea16f5e09f551f2d1e6e5c5bd5bc3937c0c09afd4a1d6571b4f2d830::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"BRAINIAC AI by SuiAI", b"PROGRAMMING ASSISTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4_Z_Xuo3n_P_400x400_b332303f4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

