module 0x4266f033ec98a9f46813c34a5e38f55e789b321a24099ac870a079148ee84cb5::tpor {
    struct TPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPOR>(arg0, 6, b"TPOR", b"Testing Portal", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TPOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

