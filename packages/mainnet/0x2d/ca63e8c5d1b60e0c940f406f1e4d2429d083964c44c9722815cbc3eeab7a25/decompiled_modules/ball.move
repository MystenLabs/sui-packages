module 0x2dca63e8c5d1b60e0c940f406f1e4d2429d083964c44c9722815cbc3eeab7a25::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 6, b"BALL", b"BALL", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BALL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

