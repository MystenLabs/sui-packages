module 0xc96a627105b19b84822d02bf249fd55d13a4fac8c7fad8143a819d30f55e3ed7::scallop_hbtc {
    struct SCALLOP_HBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_HBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_HBTC>(arg0, 8, b"sHBTC", b"sHBTC", b"Scallop interest-bearing token for hBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://q4vl5zwixiyxcquz7ud3rjhdtt5ouaalt5znq5vhtekpimpxli7a.turbo-gateway.com/hyq-5si6MXFCmf0HuKTjnPrqAAufcth2p5kU9DH3Wj4?")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_HBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_HBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

