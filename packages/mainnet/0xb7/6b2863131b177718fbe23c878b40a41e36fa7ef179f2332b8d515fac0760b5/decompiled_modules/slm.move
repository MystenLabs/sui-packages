module 0xb76b2863131b177718fbe23c878b40a41e36fa7ef179f2332b8d515fac0760b5::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLM>, arg1: 0x2::coin::Coin<SLM>) {
        0x2::coin::burn<SLM>(arg0, arg1);
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 9, b"SLM", b"SLM", b"Custom SUI Token: SLM", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLM>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<SLM>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLM>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

