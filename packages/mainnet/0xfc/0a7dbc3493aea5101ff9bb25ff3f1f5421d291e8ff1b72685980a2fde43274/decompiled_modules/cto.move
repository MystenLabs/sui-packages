module 0xfc0a7dbc3493aea5101ff9bb25ff3f1f5421d291e8ff1b72685980a2fde43274::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"114514", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CTO>>(v2);
    }

    // decompiled from Move bytecode v6
}

