module 0xa3c2950532cc5b9632ea6ef2300a7003ff4024a108bd57f4feedfabe2b6d6bb9::nam {
    struct NAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAM>(arg0, 6, b"NAM", b"NAM on SUI", b"NAM Powered by snacks and belly rubs. Will moon for treats! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Qa_V94f0_400x400_1fb7524bbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

