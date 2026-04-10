module 0xff1a78397f494e498e3a9a301fe3641faf98081f392a06b26eee77baa37cab34::ttttt {
    struct TTTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTTT>(arg0, 6, b"TTTTT", b"TTTTT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTTTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

