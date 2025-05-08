module 0x1d4a038b70558ff86d15006226a2f5ee9067b7cc3052d1086054f6634106f4ec::duong {
    struct DUONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUONG>(arg0, 9, b"DUONG", b"DUONG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUONG>(&mut v2, 540050000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUONG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DUONG>>(v2);
    }

    // decompiled from Move bytecode v6
}

