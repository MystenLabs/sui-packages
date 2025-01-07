module 0xcbedd7e9e79bab5da27c54605388ea0fdf493c16682b85a188ca48d69e0e1aa7::hfg {
    struct HFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFG>(arg0, 6, b"HFG", b"HopFrog", b"First Frog on Turbos!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731073803537.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

