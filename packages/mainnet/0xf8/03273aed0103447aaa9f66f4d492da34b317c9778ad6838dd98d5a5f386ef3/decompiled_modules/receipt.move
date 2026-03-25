module 0xf803273aed0103447aaa9f66f4d492da34b317c9778ad6838dd98d5a5f386ef3::receipt {
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

