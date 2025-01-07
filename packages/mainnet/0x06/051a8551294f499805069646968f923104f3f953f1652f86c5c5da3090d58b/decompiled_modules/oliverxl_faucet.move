module 0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet {
    struct OLIVERXL_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVERXL_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLIVERXL_FAUCET>(arg0, 6, b"Faucet Coin", b"Faucet Coin", b"this is my Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLIVERXL_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<OLIVERXL_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

