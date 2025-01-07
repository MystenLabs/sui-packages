module 0xeaf67de139f61e28d223f541a4e64edbea2213a23f9401df13a78f6a7b317bca::btts {
    struct BTTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTTS>(arg0, 6, b"BTTS", b"Back To The Suiture", b"Where were going, we don't need roads...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BACKTOFUTURE_ba9abcc411.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

