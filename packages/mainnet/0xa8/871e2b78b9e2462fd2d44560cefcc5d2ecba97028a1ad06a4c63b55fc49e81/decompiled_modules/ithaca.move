module 0xa8871e2b78b9e2462fd2d44560cefcc5d2ecba97028a1ad06a4c63b55fc49e81::ithaca {
    struct ITHACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITHACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITHACA>(arg0, 6, b"ITHACA", b"Ithaca Protocol", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITHACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITHACA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

