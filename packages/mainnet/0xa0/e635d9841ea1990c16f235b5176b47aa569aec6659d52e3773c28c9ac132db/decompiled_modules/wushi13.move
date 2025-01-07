module 0xa0e635d9841ea1990c16f235b5176b47aa569aec6659d52e3773c28c9ac132db::wushi13 {
    struct WUSHI13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSHI13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSHI13>(arg0, 8, b"WUSHI13", b"WUSHI13", b"this is WUSHI13", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSHI13>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUSHI13>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

