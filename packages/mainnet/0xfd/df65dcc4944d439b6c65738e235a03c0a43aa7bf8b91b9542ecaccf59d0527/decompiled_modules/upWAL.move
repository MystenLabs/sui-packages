module 0xfddf65dcc4944d439b6c65738e235a03c0a43aa7bf8b91b9542ecaccf59d0527::upWAL {
    struct UPWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPWAL>(arg0, 9, b"syupWAL", b"SY upWAL", b"SY DoubleUp Staked Walrus", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

