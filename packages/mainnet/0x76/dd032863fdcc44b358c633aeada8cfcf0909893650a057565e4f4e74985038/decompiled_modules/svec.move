module 0x76dd032863fdcc44b358c633aeada8cfcf0909893650a057565e4f4e74985038::svec {
    struct SVEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVEC>(arg0, 6, b"SVEC", b"SVEC", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVEC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

