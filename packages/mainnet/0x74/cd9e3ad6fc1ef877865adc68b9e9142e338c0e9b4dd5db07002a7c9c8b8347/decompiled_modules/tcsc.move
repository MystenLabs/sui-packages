module 0x74cd9e3ad6fc1ef877865adc68b9e9142e338c0e9b4dd5db07002a7c9c8b8347::tcsc {
    struct TCSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCSC>(arg0, 6, b"TCSC", b"TACO Supreme Command", x"20225472756d7020416c7761797320436869636b656e73204f757420e2809420627574206174206c6561737420746865207461636f73206172652073706963792e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749141877208.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

