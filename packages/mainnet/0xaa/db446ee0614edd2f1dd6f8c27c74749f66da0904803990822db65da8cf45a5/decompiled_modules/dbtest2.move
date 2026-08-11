module 0xaadb446ee0614edd2f1dd6f8c27c74749f66da0904803990822db65da8cf45a5::dbtest2 {
    struct DBTEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBTEST2>(arg0, 6, b"DBTEST2", b"Database TVL Test Token 2", b"Legacy CoinMetadata-compatible token for validating pool indexing and TVL calculations.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DBTEST2>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DBTEST2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DBTEST2>>(0x2::coin::mint<DBTEST2>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

