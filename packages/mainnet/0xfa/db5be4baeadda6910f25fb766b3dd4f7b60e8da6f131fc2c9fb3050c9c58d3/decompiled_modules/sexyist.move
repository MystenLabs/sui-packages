module 0xfadb5be4baeadda6910f25fb766b3dd4f7b60e8da6f131fc2c9fb3050c9c58d3::sexyist {
    struct SEXYIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXYIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXYIST>(arg0, 6, b"SEXYIST", b"SEXYIST", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXYIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEXYIST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

