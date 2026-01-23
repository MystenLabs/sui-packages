module 0xdb6e4bc4c6164c9aa1a8ea771686e4ee1d3093accab54d54b43d6ceb1459a9ad::resource_units {
    struct RESOURCE_UNITS has drop {
        dummy_field: bool,
    }

    public entry fun allocate_units(arg0: &mut 0x2::coin::TreasuryCap<RESOURCE_UNITS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESOURCE_UNITS>>(0x2::coin::mint<RESOURCE_UNITS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RESOURCE_UNITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESOURCE_UNITS>(arg0, 9, b"RU", b"Resource Units", b"Compute resource utilization tracking units", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://compute.metrics.io/ru.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESOURCE_UNITS>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESOURCE_UNITS>>(v0);
    }

    public entry fun release_units(arg0: &mut 0x2::coin::TreasuryCap<RESOURCE_UNITS>, arg1: 0x2::coin::Coin<RESOURCE_UNITS>) {
        0x2::coin::burn<RESOURCE_UNITS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

