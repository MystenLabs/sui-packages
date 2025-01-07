module 0xa144a687e5cd5582af2cc72779034fd8de6f4687f2d7f40551265cc6192eb759::scrap {
    struct SCRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAP>(arg0, 9, b"SCRAP", b"SCRAP", b"SCRAP", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCRAP>(&mut v2, 33333333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

