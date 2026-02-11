module 0x72f4ecfb8ad64d0a305eabde4ddcce82bd8bfcbd65668b3fbfc11de6aa644937::hbtfs {
    struct HBTFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBTFS>(arg0, 6, b"HBTFS", b"HeartbeatFlowToSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBTFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBTFS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

