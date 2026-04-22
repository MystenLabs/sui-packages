module 0xd8a19586e58a91df1e70fbf433489805c9854780649406ff418eb0e515f1f2e1::middlesbrough_1775638812933_yes {
    struct MIDDLESBROUGH_1775638812933_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIDDLESBROUGH_1775638812933_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIDDLESBROUGH_1775638812933_YES>(arg0, 0, b"MIDDLESBROUGH_1775638812933_YES", b"MIDDLESBROUGH_1775638812933 YES", b"MIDDLESBROUGH_1775638812933 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIDDLESBROUGH_1775638812933_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIDDLESBROUGH_1775638812933_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

