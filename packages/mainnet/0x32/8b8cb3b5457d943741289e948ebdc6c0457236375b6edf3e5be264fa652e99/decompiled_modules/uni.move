module 0x328b8cb3b5457d943741289e948ebdc6c0457236375b6edf3e5be264fa652e99::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 8, b"UNI", b"Wrapped UNI", b"ZO Finance Virtual Coin for UNI (Uniswap)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UNI>>(v0);
    }

    // decompiled from Move bytecode v7
}

