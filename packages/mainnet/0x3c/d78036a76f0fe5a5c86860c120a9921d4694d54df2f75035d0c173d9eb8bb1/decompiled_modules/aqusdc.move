module 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::aqusdc {
    struct AQUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUSDC>(arg0, 6, b"aqUSDC", b"AquaYield USDC", b"Auto-compounding USDC vault token on Sui. Earn optimized yield, withdraw anytime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/hwzRaGzzUB4ZRPyL6Eqd_F57w06RBqvWEdSoDKzTwBQ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

