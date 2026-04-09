module 0x1ac564662a1825be9c840082df10b3643ca0d7f0dd16ba8a2cf152d756e36d2::pd {
    struct PD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PD>(arg0, 6, b"PD", b"PD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

