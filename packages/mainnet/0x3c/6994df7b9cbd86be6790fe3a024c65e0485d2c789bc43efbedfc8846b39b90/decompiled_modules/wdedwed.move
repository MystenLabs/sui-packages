module 0x3c6994df7b9cbd86be6790fe3a024c65e0485d2c789bc43efbedfc8846b39b90::wdedwed {
    struct WDEDWED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDEDWED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDEDWED>(arg0, 6, b"WDEDWED", b"wedwe", b"wddwd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDEDWED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDEDWED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

