module 0x33404551f1ac6c50154b120bd29c23487c8926040b6d4f57b8adf0b026efbffb::tcs {
    struct TCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCS>(arg0, 6, b"TCS", b"TURBO CAT SUI ", x"466972737420636174206f6e20545552424f2046756e200a0a4e4f2050524553414c45200a0a5472616465206f6e20537569207573696e67204d6f6f6e6c6974650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990877698.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

