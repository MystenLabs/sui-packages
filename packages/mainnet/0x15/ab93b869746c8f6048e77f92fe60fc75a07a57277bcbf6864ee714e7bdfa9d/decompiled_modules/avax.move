module 0x15ab93b869746c8f6048e77f92fe60fc75a07a57277bcbf6864ee714e7bdfa9d::avax {
    struct AVAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAX>(arg0, 8, b"AVAX", b"Avalanche", b"ZO Virtual Coin for Avalanche", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVAX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AVAX>>(v0);
    }

    // decompiled from Move bytecode v6
}

