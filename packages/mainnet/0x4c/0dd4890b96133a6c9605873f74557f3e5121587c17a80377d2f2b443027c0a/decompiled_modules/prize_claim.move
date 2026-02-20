module 0x4c0dd4890b96133a6c9605873f74557f3e5121587c17a80377d2f2b443027c0a::prize_claim {
    struct PRIZE_CLAIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIZE_CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIZE_CLAIM>(arg0, 0, b"NFT", b"Notification", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIZE_CLAIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRIZE_CLAIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

