module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::tyde_shift {
    struct TYDE_SHIFT has drop {
        dummy_field: bool,
    }

    struct MintManager has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<TYDE_SHIFT>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut MintManager, arg1: 0x2::coin::Coin<TYDE_SHIFT>) {
        0x2::coin::burn<TYDE_SHIFT>(&mut arg0.treasury, arg1);
    }

    public fun total_supply(arg0: &MintManager) : u64 {
        0x2::coin::total_supply<TYDE_SHIFT>(&arg0.treasury)
    }

    public fun create_mint_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg1)}
    }

    public(friend) fun create_mint_cap_(arg0: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg0)}
    }

    fun init(arg0: TYDE_SHIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYDE_SHIFT>(arg0, 9, b"TYDE", b"TydeShift", b"TydeShift Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gl4a35wvmzqmqjlpsr27kki3dfd2fm5qq7bab5uxfnzgx2ioiw7a.arweave.net/MvgN9tVmYMglb5R19SkbGUeis7CHwgD2lytya-kORb4")), arg1);
        let v2 = MintManager{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        let v3 = MintCap{id: 0x2::object::new(arg1)};
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYDE_SHIFT>>(v1);
        0x2::transfer::share_object<MintManager>(v2);
        0x2::transfer::transfer<MintCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_with_cap(arg0: &mut MintManager, arg1: &MintCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TYDE_SHIFT> {
        0x2::coin::mint<TYDE_SHIFT>(&mut arg0.treasury, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

