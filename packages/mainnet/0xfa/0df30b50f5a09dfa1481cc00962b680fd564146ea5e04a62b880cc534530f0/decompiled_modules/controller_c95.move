module 0xfa0df30b50f5a09dfa1481cc00962b680fd564146ea5e04a62b880cc534530f0::controller_c95 {
    struct CONTROLLER_C95 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C95>, arg1: 0x2::coin::Coin<CONTROLLER_C95>) {
        0x2::coin::burn<CONTROLLER_C95>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C95>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_C95> {
        0x2::coin::mint<CONTROLLER_C95>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C95>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_C95>>(0x2::coin::mint<CONTROLLER_C95>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CONTROLLER_C95, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_C95>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-h8m3_QSCmx.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_C95>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_C95>>(v1);
    }

    // decompiled from Move bytecode v6
}

