module 0x97cd838120fe94cab55cca2eaebb97a560eea589f1b86a7d3b349e2f3f8a6775::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 6, b"DF", b"f", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

