module 0xd7a3fdf8c6e4bb7625fdb6fbbaaa28557fd9deeb55ef77aaebcab3f12a2cc156::nrdac {
    struct NRDAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRDAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRDAC>(arg0, 6, b"NRDAC", b"NRDAC", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRDAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NRDAC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

