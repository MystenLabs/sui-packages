module 0xd8a19586e58a91df1e70fbf433489805c9854780649406ff418eb0e515f1f2e1::middlesbrough_1775638812933_no {
    struct MIDDLESBROUGH_1775638812933_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIDDLESBROUGH_1775638812933_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIDDLESBROUGH_1775638812933_NO>(arg0, 0, b"MIDDLESBROUGH_1775638812933_NO", b"MIDDLESBROUGH_1775638812933 NO", b"MIDDLESBROUGH_1775638812933 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIDDLESBROUGH_1775638812933_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIDDLESBROUGH_1775638812933_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

