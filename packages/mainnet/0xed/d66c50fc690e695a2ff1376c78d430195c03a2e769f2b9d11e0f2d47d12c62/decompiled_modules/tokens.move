module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens {
    struct AuthorityVault has key {
        id: 0x2::object::UID,
        rflh_minted_total: u128,
        rflh_burned_total: u128,
        rflh_initial_supply_initialized: bool,
    }

    struct RflhInitialSupplyInitialized has copy, drop {
        treasury_object_id: 0x2::object::ID,
        amount: u64,
        minted_total_after: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AuthorityVault {
        AuthorityVault{
            id                              : 0x2::object::new(arg0),
            rflh_minted_total               : 0,
            rflh_burned_total               : 0,
            rflh_initial_supply_initialized : false,
        }
    }

    public fun admin_initialize_rflh_initial_supply(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.rflh_initial_supply_initialized, 10);
        let v0 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_initial_supply();
        let v1 = mint_rflh_internal(arg1, arg2, v0, arg4);
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::deposit_treasury(arg3, v1);
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::mark_initial_supply_deposited(arg3);
        arg1.rflh_initial_supply_initialized = true;
        let v2 = RflhInitialSupplyInitialized{
            treasury_object_id : 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::id(arg3),
            amount             : v0,
            minted_total_after : (arg1.rflh_minted_total as u64),
        };
        0x2::event::emit<RflhInitialSupplyInitialized>(v2);
    }

    public fun burn_rflh_for_game<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) : u64 {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        burn_rflh_internal(arg2, arg3, arg4)
    }

    public(friend) fun burn_rflh_internal(arg0: &mut AuthorityVault, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg2: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>) : u64 {
        let v0 = 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg2);
        assert!(current_total_tracked_supply(arg0) >= v0, 1);
        assert!(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::burn(arg1, arg2) == v0, 6);
        arg0.rflh_burned_total = arg0.rflh_burned_total + (v0 as u128);
        v0
    }

    public fun current_total_tracked_supply(arg0: &AuthorityVault) : u64 {
        ((arg0.rflh_minted_total - arg0.rflh_burned_total) as u64)
    }

    public fun mint_rflh_for_game<T0: drop>(arg0: T0, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH> {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<T0>(arg1);
        mint_rflh_internal(arg2, arg3, arg4, arg5)
    }

    public(friend) fun mint_rflh_internal(arg0: &mut AuthorityVault, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH> {
        arg0.rflh_minted_total = arg0.rflh_minted_total + (arg2 as u128);
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::mint(arg1, arg2, arg3)
    }

    public fun rflh_initial_supply_initialized(arg0: &AuthorityVault) : bool {
        arg0.rflh_initial_supply_initialized
    }

    public(friend) fun share_authority_vault(arg0: AuthorityVault) {
        0x2::transfer::share_object<AuthorityVault>(arg0);
    }

    // decompiled from Move bytecode v7
}

