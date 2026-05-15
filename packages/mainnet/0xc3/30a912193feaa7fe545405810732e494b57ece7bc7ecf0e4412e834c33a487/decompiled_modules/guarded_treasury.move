module 0xc330a912193feaa7fe545405810732e494b57ece7bc7ecf0e4412e834c33a487::guarded_treasury {
    struct GuardedTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
        total_minted: u64,
    }

    struct TokensMinted has copy, drop {
        amount: u64,
        total_minted_after: u64,
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : GuardedTreasury<T0> {
        GuardedTreasury<T0>{
            id           : 0x2::object::new(arg1),
            cap          : arg0,
            total_minted : 0,
        }
    }

    public fun guarded_mint<T0>(arg0: &mut GuardedTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.total_minted + arg1 <= 1000000000000000, 9);
        arg0.total_minted = arg0.total_minted + arg1;
        let v0 = TokensMinted{
            amount             : arg1,
            total_minted_after : arg0.total_minted,
        };
        0x2::event::emit<TokensMinted>(v0);
        0x2::coin::mint<T0>(&mut arg0.cap, arg1, arg2)
    }

    public fun max_supply() : u64 {
        1000000000000000
    }

    public fun total_minted<T0>(arg0: &GuardedTreasury<T0>) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v7
}

