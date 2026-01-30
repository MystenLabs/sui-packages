module 0x73da600c2bade139baa94e1f2e3a1628736727308f48081875ad4efa74a6a074::spars {
    struct SPARS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPARS>, arg1: 0x2::coin::Coin<SPARS>) {
        0x2::coin::burn<SPARS>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPARS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPARS>>(0x2::coin::mint<SPARS>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<SPARS>) : u64 {
        0x2::coin::total_supply<SPARS>(arg0)
    }

    fun init(arg0: SPARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARS>(arg0, 9, b"SPARS", b"Sparsity", b"Sparsity Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARS>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SPARS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SPARS> {
        assert!(arg1 > 0, 0);
        0x2::coin::mint<SPARS>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

