module 0x2931b28eef87359bcaa13334ead576ca05e55306b27d0ce03fd3f1cacccc72ab::axe {
    struct AXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXE>(arg0, 9, b"AXE", b"AXE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

