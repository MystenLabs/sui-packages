module 0x1dd6cffcf41e79b261d82a598c45b2d59e0891ce27d3500733572c167a3633::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"aqUSDC", b"AquaYield Vault Token", b"Auto-compounding USDC vault token on Sui. Earn optimized yield, withdraw anytime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/LGWQ0045SzePRFHnuGK5mxF25zBOToRmEpWrUSpSkOI")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

