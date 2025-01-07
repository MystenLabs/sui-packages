module 0xd474708016f8354c91f5675eefbabfa7523648e7d4dadb1421216c9bfde32cf4::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 1, b"HOLD", b"HOLD", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLD>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

