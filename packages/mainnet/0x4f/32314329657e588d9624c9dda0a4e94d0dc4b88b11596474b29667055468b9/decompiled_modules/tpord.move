module 0x4f32314329657e588d9624c9dda0a4e94d0dc4b88b11596474b29667055468b9::tpord {
    struct TPORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPORD>(arg0, 6, b"TPORD", b"Testing Portal", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TPORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

