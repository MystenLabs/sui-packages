module 0x65a4c9cb7aaa01b6909b21fc6570c384e5cc82a9b75e0ed0badab700d7f1ed6c::axe {
    struct AXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXE>(arg0, 6, b"AXE", b"AXE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

