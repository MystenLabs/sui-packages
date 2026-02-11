module 0x871f955a91c8051d1cfab0a65360429a4a97f8e361926d9cd137789fad3001bb::service_c5e {
    struct SERVICE_C5E has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_C5E>, arg1: 0x2::coin::Coin<SERVICE_C5E>) {
        0x2::coin::burn<SERVICE_C5E>(arg0, arg1);
    }

    fun init(arg0: SERVICE_C5E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERVICE_C5E>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Gu98gwsCU2.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SERVICE_C5E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERVICE_C5E>>(v1);
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_C5E>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SERVICE_C5E> {
        0x2::coin::mint<SERVICE_C5E>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<SERVICE_C5E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SERVICE_C5E>>(0x2::coin::mint<SERVICE_C5E>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

