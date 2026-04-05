module 0xebc01eb0ed39a5f8b2507151532724ba9f9decf2d81ec973f4d9e64ecf0e67f0::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 6, b"SCAM", b"Scam Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAM>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCAM>>(v2);
    }

    // decompiled from Move bytecode v6
}

