module 0x1e2e7b6b0f5a17d3722d32f7e08ec0aedcdad756641c15153277c195f6c4e713::token_supply {
    struct TokenSupplyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        forId: 0x2::object::ID,
    }

    struct TokenSupply<phantom T0> has key {
        id: 0x2::object::UID,
        max_supply: u64,
        mutable: bool,
    }

    struct TokenSupplyCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        is_mutable: bool,
    }

    public fun increase_supply<T0>(arg0: &TokenSupplyCap<T0>, arg1: &mut TokenSupply<T0>, arg2: u64) {
        assert!(arg1.mutable, 300);
        assert!(arg2 >= arg1.max_supply, 300);
        arg1.max_supply = arg2;
    }

    public fun max_supply<T0>(arg0: &TokenSupply<T0>) : u64 {
        arg0.max_supply
    }

    public fun new_token_supply<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (TokenSupply<T0>, TokenSupplyCap<T0>) {
        let v0 = TokenSupply<T0>{
            id         : 0x2::object::new(arg3),
            max_supply : arg1,
            mutable    : arg2,
        };
        let v1 = TokenSupplyCap<T0>{
            id    : 0x2::object::new(arg3),
            forId : 0x2::object::id<TokenSupply<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun share_supply<T0>(arg0: TokenSupply<T0>) {
        let v0 = TokenSupplyCreated<T0>{
            id         : 0x2::object::id<TokenSupply<T0>>(&arg0),
            is_mutable : arg0.mutable,
        };
        0x2::event::emit<TokenSupplyCreated<T0>>(v0);
        0x2::transfer::share_object<TokenSupply<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

