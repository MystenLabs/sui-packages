module 0x5a5f1d4b74f18c388389551ae4272e71c8165a2b243d69383f29978660449db1::Tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 8, b"TSUI", b"TSUI", b"TSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

