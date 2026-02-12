module 0x210bce7a9b79054bc5feec8f89dce666b4a1b56c326a20cd2423e90052b9a910::module_9dd {
    struct MODULE_9DD has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MODULE_9DD>, arg1: 0x2::coin::Coin<MODULE_9DD>) {
        0x2::coin::burn<MODULE_9DD>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<MODULE_9DD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MODULE_9DD> {
        0x2::coin::mint<MODULE_9DD>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<MODULE_9DD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MODULE_9DD>>(0x2::coin::mint<MODULE_9DD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MODULE_9DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODULE_9DD>(arg0, 9, b"SUIUSDE", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-vdCGFPkZM6.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MODULE_9DD>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODULE_9DD>>(v1);
    }

    // decompiled from Move bytecode v6
}

