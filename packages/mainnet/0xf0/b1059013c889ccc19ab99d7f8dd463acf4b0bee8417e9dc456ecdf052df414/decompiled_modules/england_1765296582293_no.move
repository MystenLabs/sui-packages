module 0xf0b1059013c889ccc19ab99d7f8dd463acf4b0bee8417e9dc456ecdf052df414::england_1765296582293_no {
    struct ENGLAND_1765296582293_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGLAND_1765296582293_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGLAND_1765296582293_NO>(arg0, 0, b"ENGLAND_1765296582293_NO", b"ENGLAND_1765296582293 NO", b"ENGLAND_1765296582293 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENGLAND_1765296582293_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGLAND_1765296582293_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

