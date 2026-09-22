module 0x5eff2d725a9d2e656c285d33f15b8b95b4a7ae1987dc953131c20e9830a3b913::amd {
    struct AMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMD>(arg0, 6, b"AMD", b"Advanced Micro Devices", b"ZO Virtual Coin for Advanced Micro Devices", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AMD>>(v0);
    }

    // decompiled from Move bytecode v7
}

