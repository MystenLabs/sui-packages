module 0x98f842a697bee3f6bac27247a8585e79076622f2b16fcdffc286c25549ebe5da::fsdfsd {
    struct FSDFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDFSD>(arg0, 6, b"FSDFSD", b"FSDFSD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FSDFSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

