module 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing {
    struct Money has copy, drop, store {
        amount: u64,
        currency: 0x1::type_name::TypeName,
    }

    struct AssetDefinition has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        enabled: bool,
    }

    struct CurrencyDefinition has copy, drop, store {
        currency: 0x1::type_name::TypeName,
        decimals: u8,
        assets: vector<AssetDefinition>,
    }

    struct CurrencyRegistry has key {
        id: 0x2::object::UID,
        currencies: vector<CurrencyDefinition>,
        scopes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct CurrencyRegistryAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct SpendingAuthorization has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        grantor: address,
        scope: 0x1::type_name::TypeName,
        currency: 0x1::type_name::TypeName,
        mode: u8,
        max_amount: u64,
        period: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>,
        anchor_ms: u64,
        period_index: u64,
        spent_in_period: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        executors: 0x2::vec_set::VecSet<address>,
        enabled_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        status: u8,
        spender_cap: 0x1::option::Option<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>,
    }

    struct CurrencyRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        creator: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct CurrencyRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        decimals: u8,
    }

    struct AssetConfigured has copy, drop {
        registry_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        enabled: bool,
    }

    struct ScopeRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        scope: 0x1::type_name::TypeName,
    }

    struct AuthorizationGranted has copy, drop {
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        grantor: address,
        scope: 0x1::type_name::TypeName,
        currency: 0x1::type_name::TypeName,
        mode: u8,
        max_amount: u64,
        anchor_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        executors: vector<address>,
        initial_asset: 0x1::type_name::TypeName,
    }

    struct AuthorizationAssetEnabled has copy, drop {
        authorization_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct AuthorizationSpent has copy, drop {
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        caller: address,
        coin_type: 0x1::type_name::TypeName,
        nominal_amount: u64,
        raw_amount: u64,
        period_index: u64,
        spent_in_period: u64,
    }

    struct AuthorizationStatusChanged has copy, drop {
        authorization_id: 0x2::object::ID,
        status: u8,
    }

    public fun deposit<T0>(arg0: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::deposit<T0>(arg0, arg1, arg2);
    }

    public fun deposit_balance<T0>(arg0: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::deposit_balance<T0>(arg0, arg1, arg2);
    }

    public fun spend<T0, T1: drop>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &CurrencyRegistry, arg2: &mut SpendingAuthorization, arg3: T1, arg4: Money, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg2.status == 0, 16);
        assert!(arg2.vault_id == 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0), 12);
        assert!(arg2.registry_id == 0x2::object::id<CurrencyRegistry>(arg1), 24);
        assert!(arg2.scope == 0x1::type_name::with_defining_ids<T1>(), 17);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg2.executors, &v0), 18);
        assert!(arg4.amount > 0, 9);
        assert!(arg4.currency == arg2.currency, 19);
        assert_asset_enabled<T0>(arg1, &arg2.currency);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg2.enabled_assets, &v1), 20);
        assert_not_expired(arg2, 0x2::clock::timestamp_ms(arg5));
        let v2 = 0x1::option::borrow<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&arg2.spender_cap);
        assert!(0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::contains<T0>(arg0, 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(v2)), 23);
        if (arg2.mode == 0) {
            assert!(arg4.amount <= arg2.max_amount, 21);
            arg2.spent_in_period = arg4.amount;
            arg2.status = 1;
        } else {
            assert!(arg2.mode == 1, 15);
            let v3 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::derive_window(arg2.anchor_ms, 0x2::clock::timestamp_ms(arg5), 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg2.period));
            let v4 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::window_index(&v3);
            if (arg2.period_index != v4) {
                arg2.period_index = v4;
                arg2.spent_in_period = 0;
            };
            let v5 = checked_amount_add(arg2.spent_in_period, arg4.amount);
            assert!(v5 <= arg2.max_amount, 21);
            arg2.spent_in_period = v5;
        };
        let v6 = raw_amount<T0>(arg1, &arg4);
        let v7 = 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::spend<T0>(arg0, v2, v6, arg5, arg6);
        if (arg2.mode == 0) {
            0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::renounce(arg0, 0x1::option::extract<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&mut arg2.spender_cap), arg6);
            let v8 = AuthorizationStatusChanged{
                authorization_id : 0x2::object::id<SpendingAuthorization>(arg2),
                status           : 1,
            };
            0x2::event::emit<AuthorizationStatusChanged>(v8);
        };
        let v9 = AuthorizationSpent{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg2),
            vault_id         : arg2.vault_id,
            caller           : 0x2::tx_context::sender(arg6),
            coin_type        : v1,
            nominal_amount   : arg4.amount,
            raw_amount       : v6,
            period_index     : arg2.period_index,
            spent_in_period  : arg2.spent_in_period,
        };
        0x2::event::emit<AuthorizationSpent>(v9);
        v7
    }

    public fun squash<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::squash<T0>(arg0, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::withdraw<T0>(arg0, arg1, arg2, arg3)
    }

    public fun withdraw_all<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::withdraw_all<T0>(arg0, arg1, arg2, arg3)
    }

    public fun active_status() : u8 {
        0
    }

    fun assert_asset_enabled<T0>(arg0: &CurrencyRegistry, arg1: &0x1::type_name::TypeName) {
        let (_, _) = enabled_decimals<T0>(arg0, arg1);
    }

    fun assert_expired(arg0: &SpendingAuthorization, arg1: u64) {
        assert!(0x1::option::is_some<u64>(&arg0.expires_at_ms), 22);
        assert!(arg1 >= *0x1::option::borrow<u64>(&arg0.expires_at_ms), 22);
    }

    fun assert_not_expired(arg0: &SpendingAuthorization, arg1: u64) {
        if (0x1::option::is_some<u64>(&arg0.expires_at_ms)) {
            assert!(arg1 < *0x1::option::borrow<u64>(&arg0.expires_at_ms), 14);
        };
    }

    fun assert_owner_binding(arg0: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &SpendingAuthorization) {
        assert!(arg2.vault_id == 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0), 12);
        assert!(0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::owner_cap_vault_id(arg1) == 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0), 12);
    }

    fun assert_registry_admin(arg0: &CurrencyRegistry, arg1: &CurrencyRegistryAdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<CurrencyRegistry>(arg0), 1);
    }

    public fun authorization_anchor_ms(arg0: &SpendingAuthorization) : u64 {
        arg0.anchor_ms
    }

    public fun authorization_currency(arg0: &SpendingAuthorization) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun authorization_enabled_assets(arg0: &SpendingAuthorization) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.enabled_assets)
    }

    public fun authorization_executors(arg0: &SpendingAuthorization) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.executors)
    }

    public fun authorization_expiry(arg0: &SpendingAuthorization) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun authorization_grantor(arg0: &SpendingAuthorization) : address {
        arg0.grantor
    }

    public fun authorization_has_asset<T0>(arg0: &SpendingAuthorization) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.enabled_assets, &v0)
    }

    public fun authorization_id(arg0: &SpendingAuthorization) : 0x2::object::ID {
        0x2::object::id<SpendingAuthorization>(arg0)
    }

    public fun authorization_is_active(arg0: &SpendingAuthorization) : bool {
        arg0.status == 0
    }

    public fun authorization_max_amount(arg0: &SpendingAuthorization) : u64 {
        arg0.max_amount
    }

    public fun authorization_mode(arg0: &SpendingAuthorization) : u8 {
        arg0.mode
    }

    public fun authorization_period(arg0: &SpendingAuthorization) : 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod> {
        arg0.period
    }

    public fun authorization_period_index(arg0: &SpendingAuthorization) : u64 {
        arg0.period_index
    }

    public fun authorization_registry_id(arg0: &SpendingAuthorization) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun authorization_scope(arg0: &SpendingAuthorization) : 0x1::type_name::TypeName {
        arg0.scope
    }

    public fun authorization_spent_in_period(arg0: &SpendingAuthorization) : u64 {
        arg0.spent_in_period
    }

    public fun authorization_status(arg0: &SpendingAuthorization) : u8 {
        arg0.status
    }

    public fun authorization_vault_id(arg0: &SpendingAuthorization) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun calendar_recurring_mode() : u8 {
        1
    }

    fun checked_amount_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 7);
        arg0 + arg1
    }

    public fun close_expired(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &mut SpendingAuthorization, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.status != 0) {
            return
        };
        assert!(arg1.vault_id == 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0), 12);
        assert_expired(arg1, 0x2::clock::timestamp_ms(arg2));
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::renounce(arg0, 0x1::option::extract<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&mut arg1.spender_cap), arg3);
        mark_expired(arg1);
    }

    public fun close_expired_orphaned(arg0: &mut SpendingAuthorization, arg1: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        assert_expired(arg0, 0x2::clock::timestamp_ms(arg1));
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::delete_orphaned_cap(0x1::option::extract<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&mut arg0.spender_cap));
        mark_expired(arg0);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_vault(arg0);
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::share(v0);
        0x2::transfer::public_transfer<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun destroy_vault(arg0: 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::destroy(arg0, arg1, arg2);
    }

    public fun enable_asset<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &CurrencyRegistry, arg3: &mut SpendingAuthorization, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner_binding(arg0, arg1, arg3);
        assert!(arg3.registry_id == 0x2::object::id<CurrencyRegistry>(arg2), 24);
        assert!(arg3.status == 0, 16);
        assert_asset_enabled<T0>(arg2, &arg3.currency);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.enabled_assets, &v0)) {
            return
        };
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::set_allowance<T0>(arg0, arg1, 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(0x1::option::borrow<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&arg3.spender_cap)), 18446744073709551615, oz_expiry(&arg3.expires_at_ms), 0x1::option::none<u64>(), arg4, arg5);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.enabled_assets, v0);
        let v1 = AuthorizationAssetEnabled{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg3),
            coin_type        : v0,
        };
        0x2::event::emit<AuthorizationAssetEnabled>(v1);
    }

    fun enabled_decimals<T0>(arg0: &CurrencyRegistry, arg1: &0x1::type_name::TypeName) : (u8, u8) {
        let v0 = 0x1::vector::borrow<CurrencyDefinition>(&arg0.currencies, require_currency_index(arg0, arg1));
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = find_asset_index(v0, &v1);
        assert!(0x1::option::is_some<u64>(&v2), 4);
        let v3 = 0x1::vector::borrow<AssetDefinition>(&v0.assets, 0x1::option::destroy_some<u64>(v2));
        assert!(v3.enabled, 5);
        (v0.decimals, v3.decimals)
    }

    fun executor_set(arg0: vector<address>) : 0x2::vec_set::VecSet<address> {
        assert!(!0x1::vector::is_empty<address>(&arg0), 13);
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = &arg0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = 0x1::vector::borrow<address>(v1, v2);
            assert!(*v3 != @0x0 && !0x2::vec_set::contains<address>(&v0, v3), 13);
            0x2::vec_set::insert<address>(&mut v0, *v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun expired_status() : u8 {
        3
    }

    fun find_asset_index(arg0: &CurrencyDefinition, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetDefinition>(&arg0.assets)) {
            if (0x1::vector::borrow<AssetDefinition>(&arg0.assets, v0).coin_type == *arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_currency(arg0: &CurrencyRegistry, arg1: &0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CurrencyDefinition>(&arg0.currencies)) {
            if (0x1::vector::borrow<CurrencyDefinition>(&arg0.currencies, v0).currency == *arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun fulfilled_status() : u8 {
        1
    }

    fun grant<T0, T1: drop>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &CurrencyRegistry, arg3: T1, arg4: Money, arg5: u8, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>, arg7: 0x1::option::Option<u64>, arg8: vector<address>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SpendingAuthorization {
        assert!(0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::owner_cap_vault_id(arg1) == 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0), 12);
        assert!(arg4.amount > 0, 9);
        let v0 = find_currency(arg2, &arg4.currency);
        assert!(0x1::option::is_some<u64>(&v0), 3);
        assert_asset_enabled<T0>(arg2, &arg4.currency);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg2.scopes, &v1), 10);
        if (arg5 == 0) {
            assert!(0x1::option::is_none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg6) && 0x1::option::is_some<u64>(&arg7), 15);
        } else {
            assert!(arg5 == 1, 15);
            assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg6), 15);
        };
        let v2 = 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::mint_cap(arg0, arg1, arg10);
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::set_allowance<T0>(arg0, arg1, 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&v2), 18446744073709551615, oz_expiry(&arg7), 0x1::option::none<u64>(), arg9, arg10);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v5, v4);
        let v6 = SpendingAuthorization{
            id              : 0x2::object::new(arg10),
            vault_id        : 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0),
            registry_id     : 0x2::object::id<CurrencyRegistry>(arg2),
            grantor         : 0x2::tx_context::sender(arg10),
            scope           : v1,
            currency        : arg4.currency,
            mode            : arg5,
            max_amount      : arg4.amount,
            period          : arg6,
            anchor_ms       : v3,
            period_index    : 0,
            spent_in_period : 0,
            expires_at_ms   : arg7,
            executors       : executor_set(arg8),
            enabled_assets  : v5,
            status          : 0,
            spender_cap     : 0x1::option::some<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(v2),
        };
        let v7 = AuthorizationGranted{
            authorization_id : 0x2::object::id<SpendingAuthorization>(&v6),
            vault_id         : 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(arg0),
            registry_id      : 0x2::object::id<CurrencyRegistry>(arg2),
            grantor          : 0x2::tx_context::sender(arg10),
            scope            : v1,
            currency         : arg4.currency,
            mode             : arg5,
            max_amount       : arg4.amount,
            anchor_ms        : v3,
            expires_at_ms    : arg7,
            executors        : *0x2::vec_set::keys<address>(&v6.executors),
            initial_asset    : v4,
        };
        0x2::event::emit<AuthorizationGranted>(v7);
        v6
    }

    public fun grant_calendar_recurring<T0, T1: drop>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &CurrencyRegistry, arg3: T1, arg4: Money, arg5: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod, arg6: 0x1::option::Option<u64>, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SpendingAuthorization {
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) > 0x2::clock::timestamp_ms(arg8), 14);
        };
        grant<T0, T1>(arg0, arg1, arg2, arg3, arg4, 1, 0x1::option::some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(arg5), arg6, arg7, arg8, arg9)
    }

    public fun grant_single_use<T0, T1: drop>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &CurrencyRegistry, arg3: T1, arg4: Money, arg5: u64, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : SpendingAuthorization {
        assert!(arg5 > 0x2::clock::timestamp_ms(arg7) && arg5 < 18446744073709551615, 14);
        grant<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, 0x1::option::none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(), 0x1::option::some<u64>(arg5), arg6, arg7, arg8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_registry(arg0);
        0x2::transfer::share_object<CurrencyRegistry>(v0);
        0x2::transfer::public_transfer<CurrencyRegistryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_asset_enabled<T0>(arg0: &CurrencyRegistry, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = find_currency(arg0, &arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        let v1 = 0x1::vector::borrow<CurrencyDefinition>(&arg0.currencies, 0x1::option::destroy_some<u64>(v0));
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = find_asset_index(v1, &v2);
        if (0x1::option::is_none<u64>(&v3)) {
            return false
        };
        0x1::vector::borrow<AssetDefinition>(&v1.assets, 0x1::option::destroy_some<u64>(v3)).enabled
    }

    public fun is_scope_registered<T0>(arg0: &CurrencyRegistry) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.scopes, &v0)
    }

    fun mark_expired(arg0: &mut SpendingAuthorization) {
        arg0.status = 3;
        let v0 = AuthorizationStatusChanged{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg0),
            status           : 3,
        };
        0x2::event::emit<AuthorizationStatusChanged>(v0);
    }

    public fun money<T0>(arg0: u64) : Money {
        Money{
            amount   : arg0,
            currency : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun money_amount(arg0: &Money) : u64 {
        arg0.amount
    }

    public fun money_currency(arg0: &Money) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun money_from_parts(arg0: u64, arg1: 0x1::type_name::TypeName) : Money {
        Money{
            amount   : arg0,
            currency : arg1,
        }
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : (CurrencyRegistry, CurrencyRegistryAdminCap) {
        let v0 = CurrencyRegistry{
            id         : 0x2::object::new(arg0),
            currencies : 0x1::vector::empty<CurrencyDefinition>(),
            scopes     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = 0x2::object::id<CurrencyRegistry>(&v0);
        let v2 = CurrencyRegistryAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = CurrencyRegistryCreated{
            registry_id  : v1,
            admin_cap_id : 0x2::object::id<CurrencyRegistryAdminCap>(&v2),
            creator      : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<CurrencyRegistryCreated>(v3);
        (v0, v2)
    }

    public fun new_vault(arg0: &mut 0x2::tx_context::TxContext) : (0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap) {
        let (v0, v1) = 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = VaultCreated{
            vault_id     : 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault>(&v3),
            owner_cap_id : 0x2::object::id<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap>(&v2),
            owner        : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v4);
        (v3, v2)
    }

    public fun nominal_amount<T0>(arg0: &CurrencyRegistry, arg1: u64, arg2: 0x1::type_name::TypeName) : Money {
        let (v0, v1) = enabled_decimals<T0>(arg0, &arg2);
        Money{
            amount   : scale_exact(arg1, v1, v0),
            currency : arg2,
        }
    }

    fun oz_expiry(arg0: &0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_some<u64>(arg0)) {
            *0x1::option::borrow<u64>(arg0)
        } else {
            18446744073709551615
        }
    }

    fun pow10(arg0: u8) : u64 {
        assert!(arg0 <= 19, 6);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            assert!(v0 <= 1844674407370955161, 7);
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun raw_amount<T0>(arg0: &CurrencyRegistry, arg1: &Money) : u64 {
        let (v0, v1) = enabled_decimals<T0>(arg0, &arg1.currency);
        scale_exact(arg1.amount, v0, v1)
    }

    public fun register_asset<T0, T1>(arg0: &mut CurrencyRegistry, arg1: &CurrencyRegistryAdminCap, arg2: &0x2::coin_registry::Currency<T1>) {
        assert_registry_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin_registry::decimals<T1>(arg2);
        assert!(v1 <= 19, 6);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        let v3 = 0x1::vector::borrow_mut<CurrencyDefinition>(&mut arg0.currencies, require_currency_index(arg0, &v0));
        let v4 = find_asset_index(v3, &v2);
        if (0x1::option::is_some<u64>(&v4)) {
            let v5 = 0x1::vector::borrow_mut<AssetDefinition>(&mut v3.assets, 0x1::option::destroy_some<u64>(v4));
            v5.decimals = v1;
            v5.enabled = true;
        } else {
            let v6 = AssetDefinition{
                coin_type : v2,
                decimals  : v1,
                enabled   : true,
            };
            0x1::vector::push_back<AssetDefinition>(&mut v3.assets, v6);
        };
        let v7 = AssetConfigured{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            currency    : v0,
            coin_type   : v2,
            decimals    : v1,
            enabled     : true,
        };
        0x2::event::emit<AssetConfigured>(v7);
    }

    public fun register_currency<T0>(arg0: &mut CurrencyRegistry, arg1: &CurrencyRegistryAdminCap, arg2: u8) {
        assert_registry_admin(arg0, arg1);
        assert!(arg2 <= 19, 6);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = find_currency(arg0, &v0);
        assert!(0x1::option::is_none<u64>(&v1), 2);
        let v2 = CurrencyDefinition{
            currency : v0,
            decimals : arg2,
            assets   : 0x1::vector::empty<AssetDefinition>(),
        };
        0x1::vector::push_back<CurrencyDefinition>(&mut arg0.currencies, v2);
        let v3 = CurrencyRegistered{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            currency    : v0,
            decimals    : arg2,
        };
        0x2::event::emit<CurrencyRegistered>(v3);
    }

    public fun register_scope<T0: drop>(arg0: &mut CurrencyRegistry, arg1: &CurrencyRegistryAdminCap, arg2: T0) {
        assert_registry_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.scopes, &v0), 11);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.scopes, v0);
        let v1 = ScopeRegistered{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            scope       : v0,
        };
        0x2::event::emit<ScopeRegistered>(v1);
    }

    public fun registry_id(arg0: &CurrencyRegistry) : 0x2::object::ID {
        0x2::object::id<CurrencyRegistry>(arg0)
    }

    fun require_currency_index(arg0: &CurrencyRegistry, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = find_currency(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 3);
        0x1::option::destroy_some<u64>(v0)
    }

    public fun revoke(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &mut SpendingAuthorization, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_binding(arg0, arg1, arg2);
        if (arg2.status != 0) {
            return
        };
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::renounce(arg0, 0x1::option::extract<0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::SpenderCap>(&mut arg2.spender_cap), arg3);
        arg2.status = 2;
        let v0 = AuthorizationStatusChanged{
            authorization_id : 0x2::object::id<SpendingAuthorization>(arg2),
            status           : 2,
        };
        0x2::event::emit<AuthorizationStatusChanged>(v0);
    }

    public fun revoked_status() : u8 {
        2
    }

    fun scale_exact(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg2 >= arg1) {
            let v1 = (arg0 as u128) * (pow10(arg2 - arg1) as u128);
            assert!(v1 <= 18446744073709551615, 7);
            (v1 as u64)
        } else {
            let v2 = pow10(arg1 - arg2);
            assert!(arg0 % v2 == 0, 8);
            arg0 / v2
        }
    }

    public fun set_asset_enabled<T0, T1>(arg0: &mut CurrencyRegistry, arg1: &CurrencyRegistryAdminCap, arg2: bool) {
        assert_registry_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::vector::borrow_mut<CurrencyDefinition>(&mut arg0.currencies, require_currency_index(arg0, &v0));
        let v3 = find_asset_index(v2, &v1);
        assert!(0x1::option::is_some<u64>(&v3), 4);
        let v4 = 0x1::vector::borrow_mut<AssetDefinition>(&mut v2.assets, 0x1::option::destroy_some<u64>(v3));
        v4.enabled = arg2;
        let v5 = AssetConfigured{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            currency    : v0,
            coin_type   : v1,
            decimals    : v4.decimals,
            enabled     : arg2,
        };
        0x2::event::emit<AssetConfigured>(v5);
    }

    public fun settled_balance<T0>(arg0: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::balance_value<T0>(arg0, arg1)
    }

    public fun share_authorization(arg0: SpendingAuthorization) {
        0x2::transfer::share_object<SpendingAuthorization>(arg0);
    }

    public fun share_currency_registry(arg0: CurrencyRegistry) {
        0x2::transfer::share_object<CurrencyRegistry>(arg0);
    }

    public fun share_vault(arg0: 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault) {
        0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::share(arg0);
    }

    public fun single_use_mode() : u8 {
        0
    }

    public fun withdraw_to_sender<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::withdraw<T0>(arg0, arg1, arg2, arg3), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

