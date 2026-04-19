module 0x9d0a0189ee50ae9ad80f05a1430fa1bec0ad0bba9ea2e252b721903119009004::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPER>, arg1: 0x2::coin::Coin<SUPER>) {
        0x2::coin::burn<SUPER>(arg0, arg1);
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 9, b"SUPER", b"SUPER", b"Custom SUI Token: SUPER", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SUPER>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPER>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

