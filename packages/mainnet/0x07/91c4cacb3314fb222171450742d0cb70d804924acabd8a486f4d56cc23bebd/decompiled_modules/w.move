module 0x791c4cacb3314fb222171450742d0cb70d804924acabd8a486f4d56cc23bebd::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"WORMHOLE", b"Wrapped Coin for Wormhole", b"Sudo Wrapped Coin for Wormhole", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<W>>(v0);
    }

    // decompiled from Move bytecode v6
}

