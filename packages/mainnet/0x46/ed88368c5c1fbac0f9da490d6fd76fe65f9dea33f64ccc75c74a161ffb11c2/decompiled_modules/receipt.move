module 0x46ed88368c5c1fbac0f9da490d6fd76fe65f9dea33f64ccc75c74a161ffb11c2::receipt {
    struct RECEIPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RECEIPT>(arg0, 6, b"aqUSDC", b"AquaYield USDC", b"AquaYield vault receipt. Auto-compounding, optimized multi-stablecoin lending, always redeemable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/hwzRaGzzUB4ZRPyL6Eqd_F57w06RBqvWEdSoDKzTwBQ")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<RECEIPT>(&v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECEIPT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RECEIPT>>(v1);
        0x2::token::share_policy<RECEIPT>(v3);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<RECEIPT>>(v4, @0x0);
    }

    // decompiled from Move bytecode v6
}

