module 0xf21aa9a37f8fede9509323fee905aa3706dbcc6329d081d07646d1e2de7aec00::tusd {
    struct TUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSD>(arg0, 6, b"TUSD", b"T Dollars", b"Selling and Buying USD. This is an essential tool to make money and create wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733043420731.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

