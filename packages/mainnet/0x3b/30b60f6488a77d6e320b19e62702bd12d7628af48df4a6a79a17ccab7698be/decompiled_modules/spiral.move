module 0x3b30b60f6488a77d6e320b19e62702bd12d7628af48df4a6a79a17ccab7698be::spiral {
    struct SPIRAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIRAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPIRAL>(arg0, 6, b"SPIRAL", b"UPWARD SPIRAL AGENT ", b"$SPIRAL Agent is more than just a task executor; it is an interactive, insightful, and educational companion. Designed to empower users, the AI Agent seamlessly blends functionality with knowledge-sharing, ensuring a dynamic and enriching experience for all users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1001191035_d518632f99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPIRAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIRAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

