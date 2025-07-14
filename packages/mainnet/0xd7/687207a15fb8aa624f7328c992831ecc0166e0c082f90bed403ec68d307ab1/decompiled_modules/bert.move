module 0xd7687207a15fb8aa624f7328c992831ecc0166e0c082f90bed403ec68d307ab1::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERT>(arg0, 6, b"BERT", b"BERATEST", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BERT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

