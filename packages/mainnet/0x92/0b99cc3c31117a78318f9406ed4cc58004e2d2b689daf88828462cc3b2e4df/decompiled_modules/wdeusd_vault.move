module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::wdeusd_vault {
    struct WDEUSDVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        is_paused: bool,
    }

    struct VaultInitialized has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultPaused has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultUnpaused has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct DeUSDClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        to: address,
        amount: u64,
    }

    struct DeUSDReturned has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        to: address,
    }

    public fun balance<T0>(arg0: &WDEUSDVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun assert_not_paused<T0>(arg0: &WDEUSDVault<T0>) {
        assert!(!arg0.is_paused, 1);
    }

    fun assert_paused<T0>(arg0: &WDEUSDVault<T0>) {
        assert!(arg0.is_paused, 2);
    }

    public fun claim_deusd<T0>(arg0: &mut WDEUSDVault<T0>, arg1: &mut 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DeUSDConfig, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::mint(arg1, arg3, v0, arg4);
        let v1 = DeUSDClaimed{
            vault_id : 0x2::object::id<WDEUSDVault<T0>>(arg0),
            sender   : 0x2::tx_context::sender(arg4),
            to       : arg3,
            amount   : v0,
        };
        0x2::event::emit<DeUSDClaimed>(v1);
    }

    public fun initialize<T0>(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::get_decimals<T0>(arg1) == 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::decimals(), 0);
        let v0 = WDEUSDVault<T0>{
            id        : 0x2::object::new(arg2),
            balance   : 0x2::balance::zero<T0>(),
            is_paused : false,
        };
        0x2::transfer::share_object<WDEUSDVault<T0>>(v0);
        let v1 = VaultInitialized{vault_id: 0x2::object::id<WDEUSDVault<T0>>(&v0)};
        0x2::event::emit<VaultInitialized>(v1);
    }

    public fun is_paused<T0>(arg0: &WDEUSDVault<T0>) : bool {
        arg0.is_paused
    }

    public fun pause<T0>(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut WDEUSDVault<T0>) {
        assert_not_paused<T0>(arg1);
        arg1.is_paused = true;
        let v0 = VaultPaused{vault_id: 0x2::object::id<WDEUSDVault<T0>>(arg1)};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun return_deusd<T0>(arg0: &mut WDEUSDVault<T0>, arg1: &mut 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DeUSDConfig, arg2: 0x2::coin::Coin<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::DEUSD>(&arg2);
        assert!(v0 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v0, 4);
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::deusd::burn_from(arg1, arg2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg4), arg3);
        let v1 = DeUSDReturned{
            vault_id : 0x2::object::id<WDEUSDVault<T0>>(arg0),
            sender   : 0x2::tx_context::sender(arg4),
            amount   : v0,
            to       : arg3,
        };
        0x2::event::emit<DeUSDReturned>(v1);
    }

    public fun unpause<T0>(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut WDEUSDVault<T0>) {
        assert_paused<T0>(arg1);
        arg1.is_paused = false;
        let v0 = VaultUnpaused{vault_id: 0x2::object::id<WDEUSDVault<T0>>(arg1)};
        0x2::event::emit<VaultUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

