module 0x207ca2225abc6deedb5dca25919679acc0bf207463e8c6c621be1efc3bd8e8c5::zro {
    struct ZRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZRO>(arg0, 6, b"ZRO", b"AlphaZero by SuiAI", b"The ultimat AI agent specialized in analyzing trading charts provides real-time insights into market trends, patterns, and price movements. It employs advanced algorithms to identify opportunities, predict outcomes, and optimize trading strategies. Equipped with data analysis, it offers precision, speed, and consistent decision-making, revolutionizing trading for both novice and professional investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/maxresdefault_06b1ed12ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZRO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZRO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

