module 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::account {
    struct SmartAccount has key {
        id: 0x2::object::UID,
        portfolio: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::Portfolio,
        active_strategy_keys: vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>,
        active_strategies: 0x2::table::Table<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>,
        balance_sheets: 0x2::table::Table<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>,
        current_adapter: 0x1::string::String,
    }

    struct AccountOwnerCap has store, key {
        id: 0x2::object::UID,
        account_id: address,
    }

    struct PolicyDetails has copy, drop {
        strategy_name: 0x1::string::String,
        policy_keys: vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>,
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
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::asset_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public fun activate_all_rules_for_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::has_strategy_by_name(arg2, arg3), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::config_rule_not_found());
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = 0x2::table::borrow_mut<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&mut arg0.active_strategies, v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::clear_policy_keys(v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::add_policy_key(v1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::all_policies_key());
        emit_strategies_updated_event(arg0, arg1, arg4);
    }

    public fun active_strategy_keys(arg0: &SmartAccount) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public fun add_policy_to_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::new_policy_key(arg4);
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::has_policy_key(arg2, v1), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::rule_not_found());
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::has_policy_key(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::get_strategy_by_name(arg2, arg3), v1), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::rule_not_found());
        let v2 = 0x2::table::borrow_mut<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&mut arg0.active_strategies, v0);
        if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::has_policy_key(v2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::all_policies_key())) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::remove_policy_key(v2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::all_policies_key());
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::add_policy_key(v2, v1);
        emit_strategies_updated_event(arg0, arg1, arg5);
    }

    public(friend) fun assert_account_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::invalid_owner_cap());
    }

    fun assert_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::invalid_owner_cap());
    }

    public(friend) fun assert_strategy_supports_asset_type<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::supports_asset_type<T0>(0x2::table::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0)), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::invalid_asset_type_for_strategy());
    }

    public(friend) fun current_adapter(arg0: &SmartAccount) : &0x1::string::String {
        &arg0.current_adapter
    }

    public fun deposit<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        assert_strategy_supports_asset_type<T0>(arg0, arg4);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::deposit<T0>(&mut arg0.portfolio, arg2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg4), arg3, arg5);
        let v0 = AssetDepositedEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            asset_type     : 0x1::type_name::get<T0>(),
            amount         : 0x2::coin::value<T0>(&arg3),
            strategy_name  : arg4,
        };
        0x2::event::emit<AssetDepositedEvent>(v0);
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        assert_strategy_supports_asset_type<T0>(arg0, arg3);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::deposit<T0>(&mut arg0.portfolio, arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3), arg2, arg4);
    }

    public(friend) fun deposit_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: T0, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::deposit_object<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4);
    }

    public(friend) fun deposit_rewards_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::deposit_rewards<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4);
    }

    public fun disable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let (v1, v2) = 0x1::vector::index_of<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(&arg0.active_strategy_keys, &v0);
        if (v1) {
            0x1::vector::remove<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v2);
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::destroy_strategy(0x2::table::remove<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&mut arg0.active_strategies, v0));
        emit_strategies_updated_event(arg0, arg1, arg4);
    }

    fun emit_strategies_updated_event(arg0: &SmartAccount, arg1: &AccountOwnerCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<PolicyDetails>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(&arg0.active_strategy_keys)) {
            let v2 = 0x1::vector::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(&arg0.active_strategy_keys, v1);
            let v3 = PolicyDetails{
                strategy_name : *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::strategy_name(v2),
                policy_keys   : *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::policy_keys(0x2::table::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, *v2)),
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

    public fun enable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::has_strategy_by_name(arg2, arg3), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::config_rule_not_found());
        assert!(!0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_already_exists());
        0x2::table::add<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&mut arg0.active_strategies, v0, *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::get_strategy_by_name(arg2, arg3));
        0x1::vector::push_back<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v0);
        emit_strategies_updated_event(arg0, arg1, arg4);
    }

    public(friend) fun extract_balance_sheet(arg0: &mut SmartAccount, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        if (!0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&arg0.balance_sheets, v0)) {
            0x2::table::add<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&mut arg0.balance_sheets, v0, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::new(arg2));
        };
        0x2::table::remove<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&mut arg0.balance_sheets, v0)
    }

    public fun extract_reward_balance<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: u64, arg4: 0x1::string::String) : 0x2::balance::Balance<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg4);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::extract_reward_balance<T0>(&mut arg0.portfolio, arg2, v0, arg3)
    }

    public(friend) fun get_balance_sheet(arg0: &SmartAccount, arg1: 0x1::string::String) : &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&arg0.balance_sheets, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0x2::table::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&arg0.balance_sheets, v0)
    }

    public(friend) fun get_balance_sheet_mut(arg0: &mut SmartAccount, arg1: 0x1::string::String) : &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&arg0.balance_sheets, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0x2::table::borrow_mut<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&mut arg0.balance_sheets, v0)
    }

    public fun get_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::config_rule_not_found());
        0x2::table::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0)
    }

    public fun has_assets_in_strategy(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::has_strategy(&arg0.portfolio, v0)
    }

    public fun has_object_in_strategy<T0: store + key>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::has_object<T0>(&arg0.portfolio, v0)
    }

    public fun has_rewards<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0) && 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::has_rewards<T0>(&arg0.portfolio, v0)
    }

    public fun has_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1))
    }

    public fun is_strategy_active_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1))
    }

    public fun mint(arg0: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : AccountOwnerCap {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::activation_fee(arg0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::incorrect_activation_fee_amount());
        if (v0 > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::collect_fee(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v1 = SmartAccount{
            id                   : 0x2::object::new(arg2),
            portfolio            : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::new(arg2),
            active_strategy_keys : 0x1::vector::empty<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey>(),
            active_strategies    : 0x2::table::new<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(arg2),
            balance_sheets       : 0x2::table::new<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(arg2),
            current_adapter      : 0x1::string::utf8(b""),
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

    public fun policies_for_strategy(arg0: &SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String) : vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy> {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::policy_keys(0x2::table::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0));
        let v2 = 0x1::vector::empty<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>(v1)) {
            let v4 = *0x1::vector::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>(v1, v3);
            if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::is_all_policies_key(&v4)) {
                let v5 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::active_policy_keys(arg1);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>(v5)) {
                    0x1::vector::push_back<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(&mut v2, *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::policy_by_key_ref(arg1, *0x1::vector::borrow<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>(v5, v6)));
                    v6 = v6 + 1;
                };
            } else {
                0x1::vector::push_back<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::Policy>(&mut v2, *0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::policy_by_key_ref(arg1, v4));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun portfolio_strategy_keys(arg0: &SmartAccount) : &vector<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::active_strategy_keys(&arg0.portfolio)
    }

    public fun remove_policy_from_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::new_policy_key(arg4);
        let v2 = 0x2::table::borrow_mut<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&mut arg0.active_strategies, v0);
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::has_policy_key(v2, v1), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::rule_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::remove_policy_key(v2, v1);
        if (0x1::vector::is_empty<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::PolicyKey>(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::policy_keys(v2))) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::add_policy_key(v2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::policy::all_policies_key());
        };
        emit_strategies_updated_event(arg0, arg1, arg5);
    }

    public(friend) fun return_balance_sheet(arg0: &mut SmartAccount, arg1: 0x1::string::String, arg2: 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet) {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&arg0.balance_sheets, v0)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::destroy(0x2::table::remove<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&mut arg0.balance_sheets, v0));
        };
        0x2::table::add<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::balance_sheet::BalanceSheet>(&mut arg0.balance_sheets, v0, arg2);
    }

    public fun reward_balance<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : u64 {
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::reward_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public(friend) fun set_current_adapter(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String) {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        arg0.current_adapter = arg2;
    }

    public fun withdraw<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg4);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = AssetWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            asset_type     : 0x1::type_name::get<T0>(),
            amount         : arg3,
            strategy_name  : arg4,
        };
        0x2::event::emit<AssetWithdrawnEvent>(v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw<T0>(&mut arg0.portfolio, arg2, v0, arg3, arg5)
    }

    public fun withdraw_all_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = RewardsWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            amount         : 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::reward_balance<T0>(&arg0.portfolio, v0),
            strategy_name  : arg3,
        };
        0x2::event::emit<RewardsWithdrawnEvent>(v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw_all_rewards<T0>(&mut arg0.portfolio, arg2, v0, arg4)
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw<T0>(&mut arg0.portfolio, arg1, v0, arg2, arg4)
    }

    public fun withdraw_object<T0: store + key>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: 0x1::string::String) : T0 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = ObjectWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            object_type    : 0x1::type_name::get<T0>(),
            strategy_name  : arg3,
        };
        0x2::event::emit<ObjectWithdrawnEvent>(v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw_object<T0>(&mut arg0.portfolio, arg2, v0)
    }

    public(friend) fun withdraw_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg2: 0x1::string::String) : T0 {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw_object<T0>(&mut arg0.portfolio, arg1, v0)
    }

    public fun withdraw_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::GlobalConfig, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::config::assert_version_compatibility(arg2);
        assert_owner(arg0, arg1);
        let v0 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::new_strategy_key(arg4);
        assert!(0x2::table::contains<0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::StrategyKey, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::strategy::Strategy>(&arg0.active_strategies, v0), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::errors::strategy_not_found());
        let v1 = RewardsWithdrawnEvent{
            account_id     : 0x2::object::id_address<SmartAccount>(arg0),
            account_cap_id : 0x2::object::id<AccountOwnerCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            amount         : arg3,
            strategy_name  : arg4,
        };
        0x2::event::emit<RewardsWithdrawnEvent>(v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::portfolio::withdraw_rewards<T0>(&mut arg0.portfolio, arg2, v0, arg3, arg5)
    }

    // decompiled from Move bytecode v6
}

