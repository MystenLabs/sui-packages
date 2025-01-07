module 0x8b9c56588952448a2f90b9c950324cc2b125c6538b9b80241606f917458a7f2d::suiranger {
    struct SUIRANGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRANGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRANGER>(arg0, 6, b"SuiRanger", b"Sui Rangers", b"Sui Rangers are protecting the world from galactical forces! It's Sui-phin time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732325395763.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRANGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRANGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

