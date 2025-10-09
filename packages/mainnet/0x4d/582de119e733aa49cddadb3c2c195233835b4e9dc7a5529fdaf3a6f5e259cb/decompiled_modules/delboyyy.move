module 0x4d582de119e733aa49cddadb3c2c195233835b4e9dc7a5529fdaf3a6f5e259cb::delboyyy {
    struct DELBOYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELBOYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELBOYYY>(arg0, 9, b"DELBOYYY", b"DELBOYYY", b"DELBOYYYYY", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DELBOYYY>>(0x2::coin::mint<DELBOYYY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DELBOYYY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DELBOYYY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

