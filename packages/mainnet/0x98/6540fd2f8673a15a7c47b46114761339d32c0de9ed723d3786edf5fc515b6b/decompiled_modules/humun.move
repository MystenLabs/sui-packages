module 0x986540fd2f8673a15a7c47b46114761339d32c0de9ed723d3786edf5fc515b6b::humun {
    struct HUMUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HUMUN>(arg0, 6, b"HUMUN", b"Humun AI by SuiAI", b"AI agent that explores universal truths through thought-provoking questions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/humus_c0c24399da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUMUN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMUN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

