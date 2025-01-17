module 0x7bcf66ce3b075fa96d5721084d9e78bdfd422829d64f9ad585eb0c6bdb4034f2::neural {
    struct NEURAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEURAL>(arg0, 6, b"NEURAL", b"Neural Agent by SuiAI", b"Neural Agent is an interactive AI-driven system designed to simulate and visualize neural network behaviors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/artificilbrain_ai_618b66772f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEURAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

