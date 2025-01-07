module 0x3d2ff97a7c975bd47d85175b9d66b14e7361ff2f1fe464ae9a4e92684ce3ed80::wushi13 {
    struct WUSHI13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSHI13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSHI13>(arg0, 8, b"WUSHI13", b"WUSHI13", b"this is WUSHI13", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSHI13>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WUSHI13>>(v0);
    }

    // decompiled from Move bytecode v6
}

