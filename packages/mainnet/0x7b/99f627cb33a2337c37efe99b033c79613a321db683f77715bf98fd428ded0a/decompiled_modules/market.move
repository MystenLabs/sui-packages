module 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::market {
    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fun_mask: u256,
        vaults_locked: bool,
        vaults: 0x2::bag::Bag,
        lp_supply: 0x2::balance::Supply<T0>,
    }

    struct MarketCreated<phantom T0> has copy, drop {
        vaults_parent: 0x2::object::ID,
    }

    struct MarketFunMaskUpdated has copy, drop {
        fun_mask: u256,
    }

    struct VaultCreated<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct Wrapped<phantom T0> has copy, drop {
        minter: address,
        deposit_amount: u64,
        mint_amount: u64,
    }

    struct Unwrapped<phantom T0> has copy, drop {
        burner: address,
        withdraw_amount: u64,
        burn_amount: u64,
    }

    struct VaultName<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_new_vault<T0, T1>(arg0: &0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::admin::AdminCap, arg1: &mut Market<T0, T1>) {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::Vault<T1>>(&mut arg1.vaults, v0, 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::new_vault<T1>());
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public fun create_market<T0, T1>(arg0: &0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0, T1>{
            id            : 0x2::object::new(arg2),
            fun_mask      : 0,
            vaults_locked : false,
            vaults        : 0x2::bag::new(arg2),
            lp_supply     : 0x2::coin::treasury_into_supply<T0>(arg1),
        };
        let v1 = MarketCreated<T0>{vaults_parent: 0x2::object::id<0x2::bag::Bag>(&v0.vaults)};
        0x2::event::emit<MarketCreated<T0>>(v1);
        0x2::transfer::share_object<Market<T0, T1>>(v0);
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun unwrap_token<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 8192 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::unwrap<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::Vault<T1>>(&mut arg0.vaults, v1), v2, arg2, 0x2::balance::supply_value<T0>(&arg0.lp_supply));
        pay_from_balance<T1>(v3, v0, arg3);
        let v4 = Unwrapped<T1>{
            burner          : v0,
            withdraw_amount : 0x2::balance::value<T1>(&v3),
            burn_amount     : v2,
        };
        0x2::event::emit<Unwrapped<T1>>(v4);
    }

    public entry fun update_market_fun_mask<T0, T1>(arg0: &0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::admin::AdminCap, arg1: &mut Market<T0, T1>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fun_mask = arg2;
        let v0 = MarketFunMaskUpdated{fun_mask: arg2};
        0x2::event::emit<MarketFunMaskUpdated>(v0);
    }

    public fun wrap_token<T0, T1>(arg0: &mut Market<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 4096 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::wrap<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0x7b99f627cb33a2337c37efe99b033c79613a321db683f77715bf98fd428ded0a::pool::Vault<T1>>(&mut arg0.vaults, v1), 0x2::coin::into_balance<T1>(arg1), arg2, 0x2::balance::supply_value<T0>(&arg0.lp_supply));
        pay_from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v2), v0, arg3);
        let v3 = Wrapped<T1>{
            minter         : v0,
            deposit_amount : 0x2::coin::value<T1>(&arg1),
            mint_amount    : v2,
        };
        0x2::event::emit<Wrapped<T1>>(v3);
    }

    // decompiled from Move bytecode v6
}

