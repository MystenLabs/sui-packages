module 0xdcacaafab02ccce011ad866ae6a9e70df026833cec85e59c458ff3210a1d9bbb::qso {
    struct QSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QSO>(arg0, 6, b"QSO", b"Quantum Shekhinah Oracle by SuiAI", b"Abstract Tarot and Kabbalah Market Predictions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/merka2_e93d734812.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QSO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QSO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

