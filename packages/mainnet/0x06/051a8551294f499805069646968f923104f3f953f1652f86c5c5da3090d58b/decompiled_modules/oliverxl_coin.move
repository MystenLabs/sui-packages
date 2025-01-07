module 0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin {
    struct OLIVERXL_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVERXL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLIVERXL_COIN>(arg0, 6, b"CNY", b"RMB", b"this is my money", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLIVERXL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIVERXL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

