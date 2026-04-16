module 0xa6c05d3c1259ec52752e2db5bdbd5d47422bcccb4931660e917e69ce4c527700::aston_villa_1775120415410_yes {
    struct ASTON_VILLA_1775120415410_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTON_VILLA_1775120415410_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTON_VILLA_1775120415410_YES>(arg0, 0, b"ASTON_VILLA_1775120415410_YES", b"ASTON_VILLA_1775120415410 YES", b"ASTON_VILLA_1775120415410 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTON_VILLA_1775120415410_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTON_VILLA_1775120415410_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

