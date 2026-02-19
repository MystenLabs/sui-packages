module 0x13c010649c8ec446c3e76b05e6b46f45197694779d9000a2bf9f7748a42f8939::manager_efc {
    struct MANAGER_EFC has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_EFC>, arg1: 0x2::coin::Coin<MANAGER_EFC>) {
        0x2::coin::burn<MANAGER_EFC>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_EFC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MANAGER_EFC> {
        0x2::coin::mint<MANAGER_EFC>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_EFC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGER_EFC>>(0x2::coin::mint<MANAGER_EFC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MANAGER_EFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER_EFC>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-igxyUUMm3e.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MANAGER_EFC>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGER_EFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

