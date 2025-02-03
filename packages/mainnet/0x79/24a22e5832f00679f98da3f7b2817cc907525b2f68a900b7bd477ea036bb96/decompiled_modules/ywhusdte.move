module 0x7924a22e5832f00679f98da3f7b2817cc907525b2f68a900b7bd477ea036bb96::ywhusdte {
    struct YWHUSDTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWHUSDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWHUSDTE>(arg0, 6, b"yUSDT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWHUSDTE>>(v1);
        0x2::transfer::public_transfer<0x7924a22e5832f00679f98da3f7b2817cc907525b2f68a900b7bd477ea036bb96::vault::AdminCap<YWHUSDTE>>(0x7924a22e5832f00679f98da3f7b2817cc907525b2f68a900b7bd477ea036bb96::vault::new<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, YWHUSDTE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

