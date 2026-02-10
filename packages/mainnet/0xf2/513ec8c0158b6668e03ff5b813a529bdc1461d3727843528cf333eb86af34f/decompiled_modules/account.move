module 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::account {
    struct SmartAccount has key {
        id: 0x2::object::UID,
        portfolio: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::Portfolio,
        active_strategy_keys: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>,
        active_strategies: 0x2::table::Table<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>,
    }

    struct AccountOwnerCap has store, key {
        id: 0x2::object::UID,
        account_id: address,
    }

    struct BalanceSheetDFKey has copy, drop, store {
        strategy_key: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey,
    }

    struct PolicyDetails has copy, drop {
        strategy_name: 0x1::string::String,
        policy_keys: vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>,
    }

    struct AccountCreatedEvent has copy, drop {
        smart_acc_id: address,
        owner_cap_id: 0x2::object::ID,
        minter_address: address,
    }

    struct StrategiesUpdatedEvent has copy, drop {
        account_id: address,
        account_cap_id: 0x2::object::ID,
        policy_details: vector<PolicyDetails>,
        timestamp: u64,
    }

    struct AssetDepositedEvent has copy, drop {
        account_id: address,
        account_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        strategy_name: 0x1::string::String,
    }

    struct AssetWithdrawnEvent has copy, drop {
        account_id: address,
        account_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        strategy_name: 0x1::string::String,
    }

    struct ObjectWithdrawnEvent has copy, drop {
        account_id: address,
        account_cap_id: 0x2::object::ID,
        object_type: 0x1::type_name::TypeName,
        strategy_name: 0x1::string::String,
    }

    struct RewardsWithdrawnEvent has copy, drop {
        account_id: address,
        account_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        strategy_name: 0x1::string::String,
    }

    public fun balance<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : u64 {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::asset_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public fun activate_all_rules_for_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::has_strategy_by_name(arg2, arg3), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::config_rule_not_found());
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = 0x2::table::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&mut arg0.active_strategies, v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::clear_policy_keys(v1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::add_policy_key(v1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::all_policies_key());
        emit_strategies_updated_event(arg0, arg1, arg4);
    }

    public fun active_strategy_keys(arg0: &SmartAccount) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public fun add_policy_to_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::new_policy_key(arg4);
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::has_policy_key(arg2, v1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::rule_not_found());
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::has_policy_key(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::get_strategy_by_name(arg2, arg3), v1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::rule_not_found());
        let v2 = 0x2::table::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&mut arg0.active_strategies, v0);
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::has_policy_key(v2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::all_policies_key())) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::remove_policy_key(v2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::all_policies_key());
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::add_policy_key(v2, v1);
        emit_strategies_updated_event(arg0, arg1, arg5);
    }

    public(friend) fun assert_account_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_owner_cap());
    }

    fun assert_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_owner_cap());
    }

    public(friend) fun assert_strategy_supports_asset_type<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::supports_asset_type<T0>(0x2::table::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0)), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_asset_type_for_strategy());
    }

    public fun borrow_balance_sheet<T0: store>(arg0: &SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : &T0 {
        let v0 = BalanceSheetDFKey{strategy_key: arg1};
        0x2::dynamic_field::borrow<BalanceSheetDFKey, T0>(&arg0.id, v0)
    }

    fun create_balance_sheet(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy, arg2: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::sheet_type(arg1) == 0x1::type_name::with_defining_ids<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::invalid_sheet_type_for_strategy());
        return_balance_sheet<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg0, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::new(arg3));
    }

    public fun deposit<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        assert_strategy_supports_asset_type<T0>(arg0, arg4);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::deposit<T0>(&mut arg0.portfolio, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg4), arg3, arg5);
        let v0 = AssetDepositedEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            asset_type     : 0x1::type_name::with_defining_ids<T0>(),
            amount         : 0x2::coin::value<T0>(&arg3),
            strategy_name  : arg4,
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::deposit<T0>(&mut arg0.portfolio, arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3), arg2, arg4);
    }

    public(friend) fun deposit_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: T0, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::deposit_object<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4);
    }

    public(friend) fun deposit_rewards_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::deposit_rewards<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4);
    }

    fun destroy_balance_sheets(arg0: &mut SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) {
        if (has_balance_sheet<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg0, arg1)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::destroy(extract_balance_sheet<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg0, arg1));
        };
    }

    public fun disable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let (v1, v2) = 0x1::vector::index_of<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.active_strategy_keys, &v0);
        if (v1) {
            0x1::vector::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v2);
        };
        let v3 = 0x2::table::remove<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&mut arg0.active_strategies, v0);
        destroy_balance_sheets(arg0, v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::destroy_strategy(v3);
        emit_strategies_updated_event(arg0, arg1, arg4);
    }

    fun emit_strategies_updated_event(arg0: &SmartAccount, arg1: &AccountOwnerCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<PolicyDetails>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.active_strategy_keys)) {
            let v2 = 0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&arg0.active_strategy_keys, v1);
            let v3 = PolicyDetails{
                strategy_name : *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::strategy_name(v2),
                policy_keys   : *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::policy_keys(0x2::table::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, *v2)),
            };
            0x1::vector::push_back<PolicyDetails>(&mut v0, v3);
            v1 = v1 + 1;
        };
        let v4 = StrategiesUpdatedEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            policy_details : v0,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StrategiesUpdatedEvent>(v4);
    }

    public fun enable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::has_strategy_by_name(arg2, arg3), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::config_rule_not_found());
        if (!0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0)) {
            let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::get_strategy_by_name(arg2, arg3);
            let v2 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_with_key(v0, arg3, *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::base_asset_types(v1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::sheet_type(v1));
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::add_policy_key(&mut v2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::all_policies_key());
            0x2::table::add<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&mut arg0.active_strategies, v0, v2);
            0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v0);
            create_balance_sheet(arg0, v1, v0, arg5);
            emit_strategies_updated_event(arg0, arg1, arg4);
        };
    }

    public(friend) fun extract_balance_sheet<T0: store>(arg0: &mut SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : T0 {
        let v0 = BalanceSheetDFKey{strategy_key: arg1};
        0x2::dynamic_field::remove<BalanceSheetDFKey, T0>(&mut arg0.id, v0)
    }

    public fun get_lending_sheet_info(arg0: &SmartAccount, arg1: 0x1::string::String) : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheetInfo {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        assert!(has_balance_sheet<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg0, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::balance_sheet_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::get_info(borrow_balance_sheet<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg0, v0), arg1)
    }

    public fun get_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::config_rule_not_found());
        0x2::table::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0)
    }

    public fun has_assets_in_strategy(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::has_strategy(&arg0.portfolio, v0)
    }

    public fun has_balance_sheet<T0: store>(arg0: &SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey) : bool {
        let v0 = BalanceSheetDFKey{strategy_key: arg1};
        0x2::dynamic_field::exists_with_type<BalanceSheetDFKey, T0>(&arg0.id, v0)
    }

    public fun has_object_in_strategy<T0: store + key>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::has_object<T0>(&arg0.portfolio, v0)
    }

    public fun has_rewards<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::has_rewards<T0>(&arg0.portfolio, v0)
    }

    public fun has_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1))
    }

    public fun mint(arg0: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : AccountOwnerCap {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::activation_fee(arg0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::incorrect_activation_fee_amount());
        if (v0 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::collect_fee(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v1 = SmartAccount{
            id                   : 0x2::object::new(arg2),
            portfolio            : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::new(arg2),
            active_strategy_keys : 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey>(),
            active_strategies    : 0x2::table::new<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(arg2),
        };
        let v2 = 0x2::object::id_address<SmartAccount>(&v1);
        let v3 = AccountOwnerCap{
            id         : 0x2::object::new(arg2),
            account_id : v2,
        };
        let v4 = AccountCreatedEvent{
            smart_acc_id   : v2,
            owner_cap_id   : 0x2::object::id<AccountOwnerCap>(&v3),
            minter_address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AccountCreatedEvent>(v4);
        0x2::transfer::share_object<SmartAccount>(v1);
        v3
    }

    public fun policies_for_strategy(arg0: &SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::string::String) : vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy> {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::policy_keys(0x2::table::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0));
        let v2 = 0x1::vector::empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v1)) {
            let v4 = *0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v1, v3);
            if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::is_all_policies_key(&v4)) {
                let v5 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::policy_keys(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::get_strategy_by_name(arg1, arg2));
                let v6 = 0;
                while (v6 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v5)) {
                    let v7 = *0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v5, v6);
                    if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::is_all_policies_key(&v7)) {
                        0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(&mut v2, *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::policy_by_key_ref(arg1, v7));
                    };
                    v6 = v6 + 1;
                };
            } else {
                0x1::vector::push_back<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::Policy>(&mut v2, *0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::policy_by_key_ref(arg1, v4));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun portfolio_strategy_keys(arg0: &SmartAccount) : &vector<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::active_strategy_keys(&arg0.portfolio)
    }

    public fun remove_policy_from_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::new_policy_key(arg4);
        let v2 = 0x2::table::borrow_mut<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&mut arg0.active_strategies, v0);
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::has_policy_key(v2, v1), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::rule_not_found());
        if (0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::is_all_policies_key(&v1)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::remove_policy_key(v2, v1);
            let v3 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::policy_keys(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::get_strategy_by_name(arg2, arg3));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v3)) {
                let v5 = *0x1::vector::borrow<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(v3, v4);
                if (!0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::is_all_policies_key(&v5)) {
                    0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::add_policy_key(v2, v5);
                };
                v4 = v4 + 1;
            };
        } else {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::remove_policy_key(v2, v1);
        };
        if (0x1::vector::is_empty<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::PolicyKey>(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::policy_keys(v2))) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::add_policy_key(v2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::policy::all_policies_key());
        };
        emit_strategies_updated_event(arg0, arg1, arg5);
    }

    public(friend) fun return_balance_sheet<T0: store>(arg0: &mut SmartAccount, arg1: 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, arg2: T0) {
        let v0 = BalanceSheetDFKey{strategy_key: arg1};
        0x2::dynamic_field::add<BalanceSheetDFKey, T0>(&mut arg0.id, v0, arg2);
    }

    public fun reward_balance<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : u64 {
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::reward_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public fun withdraw<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg4);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = AssetWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            asset_type     : 0x1::type_name::with_defining_ids<T0>(),
            amount         : arg3,
            strategy_name  : arg4,
        };
        0x2::event::emit<AssetWithdrawnEvent>(v1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::withdraw<T0>(&mut arg0.portfolio, arg2, v0, arg3, arg5)
    }

    public fun withdraw_all_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = RewardsWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            reward_type    : 0x1::type_name::with_defining_ids<T0>(),
            amount         : 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::reward_balance<T0>(&arg0.portfolio, v0),
            strategy_name  : arg3,
        };
        0x2::event::emit<RewardsWithdrawnEvent>(v1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::withdraw_all_rewards<T0>(&mut arg0.portfolio, arg2, v0, arg4)
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::withdraw<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4)
    }

    public fun withdraw_object<T0: store + key>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg3: 0x1::string::String) : T0 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        let v1 = ObjectWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            object_type    : 0x1::type_name::with_defining_ids<T0>(),
            strategy_name  : arg3,
        };
        0x2::event::emit<ObjectWithdrawnEvent>(v1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::withdraw_object<T0>(&mut arg0.portfolio, arg2, v0)
    }

    public(friend) fun withdraw_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: &0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::GlobalConfig, arg2: 0x1::string::String) : T0 {
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::config::assert_version_compatibility(arg1);
        let v0 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::StrategyKey, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::strategy::Strategy>(&arg0.active_strategies, v0), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::errors::strategy_not_found());
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::portfolio::withdraw_object<T0>(&mut arg0.portfolio, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

