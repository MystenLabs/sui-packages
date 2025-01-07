module 0x6013f4e9e98b5655b0100d4b99cdfd2e4cca14850ac1efd5cd8bc47b02c0f90e::hkf {
    struct HKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKF>(arg0, 6, b"HKF", b"Hello Kitty Fans ", b"Just a place for all Hello kitty fans to be together as ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730822418948.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

