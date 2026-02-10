module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket {
    struct AuthorizedTransferTicket<T0: store> {
        assets: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore,
        balance_sheet: T0,
        account_id: 0x2::object::ID,
        policies: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>,
        strategy_name: 0x1::string::String,
        is_agent: bool,
        perf_fee: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetStore,
        perf_fee_val: u64,
        base_asset_types: vector<0x1::type_name::TypeName>,
    }

    public fun asset_balance<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : u64 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::asset_balance<T1>(&arg0.assets, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_asset_key<T1>())
    }

    public fun has_any_assets<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_assets(&arg0.assets)
    }

    public fun has_any_rewards<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_rewards(&arg0.assets)
    }

    public fun reward_balance<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : u64 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::reward_balance<T1>(&arg0.assets, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_reward_key<T1>())
    }

    public fun withdraw_object<T0: store, T1: store + key, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: &T2) : T1 {
        verify_adapter_access<T0, T2>(arg0, arg1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_object<T1>(&mut arg0.assets)
    }

    public fun withdraw_reward<T0: store, T1, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: u64, arg2: &T2, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_reward<T1>(&mut arg0.assets, arg1, arg3)
    }

    public fun add_coin<T0: store, T1, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &T2) {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit<T1>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_coin_internal<T0: store, T1>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: 0x2::coin::Coin<T1>) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit<T1>(&mut arg0.assets, arg1);
    }

    public fun add_object<T0: store, T1: store + key, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: T1, arg2: &T2) {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_object<T1>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_object_internal<T0: store, T1: store + key>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: T1) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_object<T1>(&mut arg0.assets, arg1);
    }

    public fun add_reward<T0: store, T1, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &T2) {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_reward_balance<T1>(&mut arg0.assets, arg1);
    }

    public(friend) fun add_reward_internal<T0: store, T1>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: 0x2::balance::Balance<T1>) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit_reward_balance<T1>(&mut arg0.assets, arg1);
    }

    public(friend) fun assert_belongs_to_account<T0: store, T1: key>(arg0: &AuthorizedTransferTicket<T0>, arg1: &T1) {
        assert!(arg0.account_id == 0x2::object::id<T1>(arg1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_account());
    }

    public fun assert_supports_asset_type<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) {
        assert!(supports_asset_type<T0, T1>(arg0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_asset_type_for_strategy());
    }

    public fun burn<T0: store>(arg0: AuthorizedTransferTicket<T0>) : T0 {
        let AuthorizedTransferTicket {
            assets           : v0,
            balance_sheet    : v1,
            account_id       : _,
            policies         : _,
            strategy_name    : _,
            is_agent         : _,
            perf_fee         : v6,
            perf_fee_val     : _,
            base_asset_types : _,
        } = arg0;
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::destroy(v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::destroy(v6);
        v1
    }

    public fun calculate_lending_yield_earnings<T0: store>(arg0: &AuthorizedTransferTicket<T0>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        if (arg1 > arg2) {
            let v3 = arg1 - arg2;
            let v4 = calculate_performance_fee<T0>(arg0, v3);
            (v3, v4, v3 - v4)
        } else {
            (0, 0, 0)
        }
    }

    public fun calculate_performance_fee<T0: store>(arg0: &AuthorizedTransferTicket<T0>, arg1: u64) : u64 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::math::safe_mul_div(arg1, arg0.perf_fee_val, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::constants::basis_points_divisor())
    }

    public fun collect_performance_fee<T0: store, T1, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &T2) {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::deposit<T1>(&mut arg0.perf_fee, arg1);
    }

    public fun get_account_id<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun get_asset_keys<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::AssetKey> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::active_asset_keys(&arg0.assets)
    }

    public fun get_base_asset_types<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.base_asset_types
    }

    public fun get_policies<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy> {
        &arg0.policies
    }

    public fun get_reward_keys<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::RewardKey> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::active_reward_keys(&arg0.assets)
    }

    public fun get_strategy_name<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : 0x1::string::String {
        arg0.strategy_name
    }

    public fun has_any_perf_fees<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_any_assets(&arg0.perf_fee)
    }

    public fun has_asset_type<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::has_asset_key(&arg0.assets, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_asset_key<T1>())
    }

    public fun has_reward_type<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::reward_exists(&arg0.assets, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_reward_key<T1>())
    }

    public fun is_agent_ticket<T0: store>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        arg0.is_agent
    }

    public(friend) fun issue<T0: store>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: T0, arg3: bool, arg4: u64, arg5: vector<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) : AuthorizedTransferTicket<T0> {
        AuthorizedTransferTicket<T0>{
            assets           : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::new(arg6),
            balance_sheet    : arg2,
            account_id       : arg0,
            policies         : 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(),
            strategy_name    : arg1,
            is_agent         : arg3,
            perf_fee         : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::new(arg6),
            perf_fee_val     : arg4,
            base_asset_types : arg5,
        }
    }

    public fun lending_get_total_deposited<T0>(arg0: &AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg1: &T0) : u64 {
        verify_adapter_access<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg0, arg1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::adapter_total_deposited<T0>(&arg0.balance_sheet)
    }

    public fun lending_record_deposit<T0>(arg0: &mut AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg1: u64, arg2: &T0) {
        verify_adapter_access<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::record_deposit_internal<T0>(&mut arg0.balance_sheet, arg1);
    }

    public fun lending_reset_deposits<T0>(arg0: &mut AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg1: &T0) {
        verify_adapter_access<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg0, arg1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::reset_adapter_deposits_internal<T0>(&mut arg0.balance_sheet);
    }

    public fun lending_set_adapter_name<T0>(arg0: &mut AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg1: 0x1::string::String, arg2: &T0) {
        verify_adapter_access<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::set_current_adapter_internal(&mut arg0.balance_sheet, arg1);
    }

    public fun perf_fee_asset_balance<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : u64 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::asset_balance<T1>(&arg0.perf_fee, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::create_asset_key<T1>())
    }

    public(friend) fun set_policies<T0: store>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        arg0.policies = arg2;
    }

    public fun supports_asset_type<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.base_asset_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.base_asset_types, v0) == 0x1::type_name::with_defining_ids<T1>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun verify_adapter_access<T0: store, T1>(arg0: &AuthorizedTransferTicket<T0>, arg1: &T1) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(&arg0.policies) && !v0) {
            if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::is_adapter_type_allowed(0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(&arg0.policies, v1), 0x1::type_name::with_defining_ids<T1>())) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::adapter_not_whitelisted());
    }

    public fun withdraw_coin<T0: store, T1, T2>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: u64, arg2: &T2, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        verify_adapter_access<T0, T2>(arg0, arg2);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw<T1>(&mut arg0.assets, arg1, arg3)
    }

    public(friend) fun withdraw_coin_internal<T0: store, T1>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw<T1>(&mut arg0.assets, arg1, arg2)
    }

    public(friend) fun withdraw_object_internal<T0: store, T1: store + key>(arg0: &mut AuthorizedTransferTicket<T0>) : T1 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_object<T1>(&mut arg0.assets)
    }

    public(friend) fun withdraw_performance_fee<T0: store, T1>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw<T1>(&mut arg0.perf_fee, arg1, arg2)
    }

    public(friend) fun withdraw_reward_internal<T0: store, T1>(arg0: &mut AuthorizedTransferTicket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::asset_store::withdraw_reward<T1>(&mut arg0.assets, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

