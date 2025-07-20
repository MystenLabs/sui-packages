module 0xae710ad8fca861cfa074a2ef974db50c210bb2dec4bbba873e6d158196c4d4bb::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"bullrun", b"@suilaunchcoin @suilaunchcoin $BULL + bullrun https://t.co/hiBouGjjMd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bull-85itql.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

