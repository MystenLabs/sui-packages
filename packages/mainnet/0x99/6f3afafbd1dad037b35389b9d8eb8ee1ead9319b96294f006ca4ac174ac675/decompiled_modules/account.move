module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::account {
    struct SmartAccount has key {
        id: 0x2::object::UID,
        portfolio: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::Portfolio,
        active_strategy_keys: vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>,
        active_strategies: 0x2::table::Table<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>,
        last_policy_consumed: 0x1::option::Option<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>,
    }

    struct AccountOwnerCap has store, key {
        id: 0x2::object::UID,
        account_id: address,
    }

    public fun balance<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : u64 {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::asset_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AccountOwnerCap {
        let v0 = SmartAccount{
            id                   : 0x2::object::new(arg0),
            portfolio            : 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::new(arg0),
            active_strategy_keys : 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(),
            active_strategies    : 0x2::table::new<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(arg0),
            last_policy_consumed : 0x1::option::none<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(),
        };
        let v1 = AccountOwnerCap{
            id         : 0x2::object::new(arg0),
            account_id : 0x2::object::id_address<SmartAccount>(&v0),
        };
        0x2::transfer::share_object<SmartAccount>(v0);
        v1
    }

    public fun activate_all_rules_for_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg3: 0x1::string::String) {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::has_strategy_by_name(arg2, arg3), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let v1 = 0x2::table::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.active_strategies, v0);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::clear_policy_keys(v1);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::add_policy_key(v1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::all_policies_key());
    }

    public fun active_policies_for_strategy(arg0: &SmartAccount, arg1: 0x1::string::String) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey> {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::policy_keys(0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0))
    }

    public fun active_strategy_keys(arg0: &SmartAccount) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey> {
        &arg0.active_strategy_keys
    }

    public fun add_policy_to_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg4);
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::has_policy_key(arg2, v1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::rule_not_found());
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::has_policy_key(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::get_strategy_by_name(arg2, arg3), v1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::rule_not_found());
        let v2 = 0x2::table::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.active_strategies, v0);
        if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::has_policy_key(v2, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::all_policies_key())) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::remove_policy_key(v2, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::all_policies_key());
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::add_policy_key(v2, v1);
    }

    fun assert_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::invalid_owner_cap());
    }

    public(friend) fun assert_strategy_supports_asset_type<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::supports_asset_type<T0>(0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0)), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::invalid_asset_type_for_strategy());
    }

    public fun deposit<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_strategy_supports_asset_type<T0>(arg0, arg3);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::deposit<T0>(&mut arg0.portfolio, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3), arg2, arg4);
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut SmartAccount, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_strategy_supports_asset_type<T0>(arg0, arg2);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::deposit<T0>(&mut arg0.portfolio, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2), arg1, arg3);
    }

    public(friend) fun deposit_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: T0, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::deposit_object<T0>(&mut arg0.portfolio, v0, arg1, arg3);
    }

    public(friend) fun deposit_rewards_internal<T0>(arg0: &mut SmartAccount, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::deposit_rewards<T0>(&mut arg0.portfolio, v0, arg1, arg3);
    }

    public fun disable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1::string::String) {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let (v1, v2) = 0x1::vector::index_of<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.active_strategy_keys, &v0);
        if (v1) {
            0x1::vector::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v2);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::destroy_strategy(0x2::table::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.active_strategies, v0));
    }

    public fun enable_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg3: 0x1::string::String) {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::has_strategy_by_name(arg2, arg3), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        assert!(!0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_already_exists());
        0x2::table::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.active_strategies, v0, *0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::get_strategy_by_name(arg2, arg3));
        0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategy_keys, v0);
    }

    public fun extract_reward_balance<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64, arg3: 0x1::string::String) : 0x2::balance::Balance<T0> {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::extract_reward_balance<T0>(&mut arg0.portfolio, v0, arg2)
    }

    public fun get_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0)
    }

    public fun has_assets_in_strategy(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::has_strategy(&arg0.portfolio, v0)
    }

    public fun has_object_in_strategy<T0: store + key>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::has_object<T0>(&arg0.portfolio, v0)
    }

    public fun has_rewards<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0) && 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::has_rewards<T0>(&arg0.portfolio, v0)
    }

    public fun has_strategy_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1))
    }

    public fun is_strategy_active_by_name(arg0: &SmartAccount, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1))
    }

    public(friend) fun last_policy_consumed(arg0: &SmartAccount) : &0x1::option::Option<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy> {
        &arg0.last_policy_consumed
    }

    public fun policies_for_strategy(arg0: &SmartAccount, arg1: &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::GlobalConfig, arg2: 0x1::string::String) : vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy> {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::policy_keys(0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0));
        let v2 = 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v1)) {
            let v4 = *0x1::vector::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v1, v3);
            if (0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::is_all_policies_key(&v4)) {
                let v5 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::active_policy_keys(arg1);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v5)) {
                    0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut v2, *0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::policy_by_key_ref(arg1, *0x1::vector::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v5, v6)));
                    v6 = v6 + 1;
                };
            } else {
                0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut v2, *0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config::policy_by_key_ref(arg1, v4));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun portfolio_strategy_keys(arg0: &SmartAccount) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey> {
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::active_strategy_keys(&arg0.portfolio)
    }

    public fun remove_policy_from_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg3);
        let v2 = 0x2::table::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.active_strategies, v0);
        assert!(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::has_policy_key(v2, v1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::rule_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::remove_policy_key(v2, v1);
        if (0x1::vector::is_empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::policy_keys(v2))) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::add_policy_key(v2, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::all_policies_key());
        };
    }

    public fun reward_balance<T0>(arg0: &SmartAccount, arg1: 0x1::string::String) : u64 {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        if (0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0)) {
            0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::reward_balance<T0>(&arg0.portfolio, v0)
        } else {
            0
        }
    }

    public(friend) fun set_last_policy_consumed(arg0: &mut SmartAccount, arg1: 0x1::option::Option<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>) {
        arg0.last_policy_consumed = arg1;
    }

    public fun withdraw<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw<T0>(&mut arg0.portfolio, v0, arg2, arg4)
    }

    public fun withdraw_all_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw_all_rewards<T0>(&mut arg0.portfolio, v0, arg3)
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut SmartAccount, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw<T0>(&mut arg0.portfolio, v0, arg1, arg3)
    }

    public fun withdraw_object<T0: store + key>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : T0 {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg2);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw_object<T0>(&mut arg0.portfolio, v0)
    }

    public(friend) fun withdraw_object_internal<T0: store + key>(arg0: &mut SmartAccount, arg1: 0x1::string::String) : T0 {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw_object<T0>(&mut arg0.portfolio, v0)
    }

    public fun withdraw_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg1);
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg3);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.active_strategies, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::strategy_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::portfolio::withdraw_rewards<T0>(&mut arg0.portfolio, v0, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

