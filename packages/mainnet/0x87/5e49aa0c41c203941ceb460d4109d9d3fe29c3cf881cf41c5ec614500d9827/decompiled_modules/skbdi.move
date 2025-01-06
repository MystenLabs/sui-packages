module 0x875e49aa0c41c203941ceb460d4109d9d3fe29c3cf881cf41c5ec614500d9827::skbdi {
    struct SKBDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SKBDI>(arg0, 6, b"SKBDI", b"SKIBIDI  by SuiAI", b"just skibidi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/maxresdefault_3_bb9fe2d190.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKBDI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

