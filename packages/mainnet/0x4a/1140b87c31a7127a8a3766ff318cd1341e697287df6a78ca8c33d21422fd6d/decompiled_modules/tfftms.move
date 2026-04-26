module 0x4a1140b87c31a7127a8a3766ff318cd1341e697287df6a78ca8c33d21422fd6d::tfftms {
    struct TFFTMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFFTMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFFTMS>(arg0, 6, b"TFFTMS", b"TFFTMS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFFTMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TFFTMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

