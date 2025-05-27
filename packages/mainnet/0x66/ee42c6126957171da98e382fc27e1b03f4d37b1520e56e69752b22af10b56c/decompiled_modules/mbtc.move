module 0x66ee42c6126957171da98e382fc27e1b03f4d37b1520e56e69752b22af10b56c::mbtc {
    struct MBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBTC>(arg0, 6, b"M-BTC", b"Merlin BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

