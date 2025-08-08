module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::account {
    struct SmartAccount has key {
        id: 0x2::object::UID,
        portfolio: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::Portfolio,
        active_strategies: vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>,
        strategy_rule_keys: 0x2::table::Table<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>,
        last_rule_consumed: 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>,
    }

    struct AccountOwnerCap has store, key {
        id: 0x2::object::UID,
        account_id: address,
    }

    public fun balance<T0, T1>(arg0: &SmartAccount) : u64 {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        if (0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0)) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::balance<T1>(&arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0))
        } else {
            0
        }
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AccountOwnerCap {
        let v0 = SmartAccount{
            id                 : 0x2::object::new(arg0),
            portfolio          : 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::new(arg0),
            active_strategies  : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(),
            strategy_rule_keys : 0x2::table::new<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(arg0),
            last_rule_consumed : 0x1::option::none<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(),
        };
        let v1 = AccountOwnerCap{
            id         : 0x2::object::new(arg0),
            account_id : 0x2::object::id_address<SmartAccount>(&v0),
        };
        0x2::transfer::share_object<SmartAccount>(v0);
        v1
    }

    public fun activate_all_rules_for_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg3: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        assert_owner(arg0, arg1);
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        assert!(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::has_strategy(arg2, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let v0 = 0x2::table::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategy_rule_keys, arg3);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::clear_rule_keys(v0);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(v0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key());
    }

    public fun active_reward_types(arg0: &SmartAccount) : &vector<0x1::type_name::TypeName> {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::active_reward_types(&arg0.portfolio)
    }

    public fun active_strategies(arg0: &SmartAccount) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        &arg0.active_strategies
    }

    public fun add_rule_to_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg3: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg4: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) {
        assert_owner(arg0, arg1);
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        assert!(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::has_rule_key(arg2, arg4), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_not_found());
        assert!(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::has_rule_key(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::get_strategy(arg2, arg3), arg4), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_not_found());
        let v0 = 0x2::table::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategy_rule_keys, arg3);
        if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::has_rule_key(v0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key())) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::remove_rule_key(v0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key());
        };
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(v0, arg4);
    }

    public fun add_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg3: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        assert_owner(arg0, arg1);
        assert!(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::has_strategy(arg2, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        assert!(!0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::strategy_already_exists());
        0x2::table::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategy_rule_keys, arg3, *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::get_strategy(arg2, arg3));
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategies, arg3);
    }

    fun assert_owner(arg0: &SmartAccount, arg1: &AccountOwnerCap) {
        assert!(arg1.account_id == 0x2::object::id_address<SmartAccount>(arg0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::invalid_owner_cap());
    }

    public fun deposit<T0, T1>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x2::coin::Coin<T1>) {
        assert_owner(arg0, arg1);
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg2);
    }

    public(friend) fun deposit_internal<T0, T1>(arg0: &mut SmartAccount, arg1: 0x2::coin::Coin<T1>) {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg1);
    }

    public fun deposit_object<T0, T1: store + key>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: T1) {
        assert_owner(arg0, arg1);
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit_object<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg2);
    }

    public(friend) fun deposit_object_internal<T0, T1: store + key>(arg0: &mut SmartAccount, arg1: T1) {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit_object<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg1);
    }

    public fun deposit_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x2::balance::Balance<T0>) {
        assert_owner(arg0, arg1);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit_rewards<T0>(&mut arg0.portfolio, arg2);
    }

    public(friend) fun deposit_rewards_internal<T0>(arg0: &mut SmartAccount, arg1: 0x2::balance::Balance<T0>) {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::deposit_rewards<T0>(&mut arg0.portfolio, arg1);
    }

    public fun extract_reward_balance<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_owner(arg0, arg1);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::extract_reward_balance<T0>(&mut arg0.portfolio, arg2)
    }

    public fun find_strategy_key_for_base_asset<T0>(arg0: &SmartAccount) : 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies)) {
            let v1 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies, v0);
            if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::matches_base_asset_type<T0>(&v1)) {
                return 0x1::option::some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>()
    }

    public fun get_strategy(arg0: &SmartAccount, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1)
    }

    public fun has_any_rewards(arg0: &SmartAccount) : bool {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::has_any_rewards(&arg0.portfolio)
    }

    public fun has_asset<T0>(arg0: &SmartAccount) : bool {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0) && 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::has_strategy(&arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0))
    }

    public fun has_rewards<T0>(arg0: &SmartAccount) : bool {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::has_rewards<T0>(&arg0.portfolio)
    }

    public fun has_strategy(arg0: &SmartAccount, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1)
    }

    public fun has_strategy_for_base_asset<T0>(arg0: &SmartAccount) : bool {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0)
    }

    public fun is_strategy_active(arg0: &SmartAccount, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1)
    }

    public(friend) fun last_rule_consumed(arg0: &SmartAccount) : &0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule> {
        &arg0.last_rule_consumed
    }

    public fun portfolio_strategy_keys(arg0: &SmartAccount) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::active_strategy_keys(&arg0.portfolio)
    }

    public fun remove_rule_from_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg3: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) {
        assert_owner(arg0, arg1);
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg2), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let v0 = 0x2::table::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategy_rule_keys, arg2);
        assert!(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::has_rule_key(v0, arg3), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::remove_rule_key(v0, arg3);
        if (0x1::vector::is_empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(v0))) {
            0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(v0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key());
        };
    }

    public fun remove_strategy(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) {
        assert_owner(arg0, arg1);
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg2), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let (v0, v1) = 0x1::vector::index_of<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies, &arg2);
        if (v0) {
            0x1::vector::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategies, v1);
        };
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::destroy_strategy(0x2::table::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategy_rule_keys, arg2));
    }

    public fun reward_balance<T0>(arg0: &SmartAccount) : u64 {
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::reward_balance<T0>(&arg0.portfolio)
    }

    public fun rules_for_strategy(arg0: &SmartAccount, arg1: &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::GlobalConfig, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule> {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg2), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg2));
        let v1 = 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0)) {
            let v3 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0, v2);
            if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::is_all_rules_key(&v3)) {
                let v4 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::active_rule_keys(arg1);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v4)) {
                    0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut v1, *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::rule_by_key(arg1, *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v4, v5)));
                    v5 = v5 + 1;
                };
            } else {
                0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut v1, *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config::rule_by_key(arg1, v3));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun set_last_rule_consumed(arg0: &mut SmartAccount, arg1: 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>) {
        arg0.last_rule_consumed = arg1;
    }

    public fun strategy_rule_keys(arg0: &SmartAccount, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey> {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategy_rule_keys, arg1))
    }

    public fun withdraw<T0, T1>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_owner(arg0, arg1);
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg2, arg3)
    }

    public fun withdraw_all_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg1);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw_all_rewards<T0>(&mut arg0.portfolio, arg2)
    }

    public(friend) fun withdraw_internal<T0, T1>(arg0: &mut SmartAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0), arg1, arg2)
    }

    public fun withdraw_object<T0, T1: store + key>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: &0x2::tx_context::TxContext) : T1 {
        assert_owner(arg0, arg1);
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw_object<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0))
    }

    public(friend) fun withdraw_object_internal<T0, T1: store + key>(arg0: &mut SmartAccount) : T1 {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        assert!(0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw_object<T1>(&mut arg0.portfolio, 0x1::option::destroy_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v0))
    }

    public fun withdraw_rewards<T0>(arg0: &mut SmartAccount, arg1: &AccountOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg1);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::portfolio::withdraw_rewards<T0>(&mut arg0.portfolio, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

