module 0x65e1b4d0f0e669cf06dd3d7a771713bea7199002c212bcdabd2345b82cb3fba2::manager_9eb {
    struct MANAGER_9EB has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_9EB>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MANAGER_9EB> {
        0x2::coin::mint<MANAGER_9EB>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_9EB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGER_9EB>>(0x2::coin::mint<MANAGER_9EB>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MANAGER_9EB>, arg1: 0x2::coin::Coin<MANAGER_9EB>) {
        0x2::coin::burn<MANAGER_9EB>(arg0, arg1);
    }

    fun init(arg0: MANAGER_9EB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER_9EB>(arg0, 9, b"WAL", b"WAL Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-qSXI6Ryw-i.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MANAGER_9EB>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGER_9EB>>(v1);
    }

    // decompiled from Move bytecode v6
}

