module 0xe604d3873d2777480186dcbc49a211156e3be864161f664dcaa3508846ae6fc1::Duck_you {
    struct DUCK_YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK_YOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK_YOU>(arg0, 9, b"DUCK", b"Duck you", b"would you fuck a posh duck?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a70e5412-c2fe-4497-97ef-46be7d5fae0e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK_YOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK_YOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

