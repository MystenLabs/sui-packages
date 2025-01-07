module 0x27f0b0dae25351d635b359d6b52f2b82a07065f847fa1664e5a196a373cfc02d::epepsui {
    struct EPEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPEPSUI>(arg0, 6, b"EPEPSUI", b"epepsui", b"epepsui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPEPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EPEPSUI>>(0x2::coin::mint<EPEPSUI>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPEPSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

