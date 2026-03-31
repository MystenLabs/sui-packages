module 0x56c2be634b7957e01e9576ea5303ae8fad3f9d3481c43da00275a15e4fb5756::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"Cto Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CTO>>(v2);
    }

    // decompiled from Move bytecode v6
}

