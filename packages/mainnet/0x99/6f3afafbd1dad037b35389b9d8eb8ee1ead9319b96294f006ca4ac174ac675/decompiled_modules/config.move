module 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u8,
        whitelisted_agents: vector<address>,
        policies_registry: 0x2::table::Table<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>,
        policy_key_list: vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>,
        strategies_registry: 0x2::table::Table<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>,
        active_strategies_key_list: vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun active_policy_keys(arg0: &GlobalConfig) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey> {
        &arg0.policy_key_list
    }

    public fun active_strategies(arg0: &GlobalConfig) : &vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey> {
        &arg0.active_strategies_key_list
    }

    public fun add_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        if (!0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_agents, arg1);
        };
    }

    public fun add_policy<T0, T1>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg1);
        assert!(!0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::rule_already_exists());
        0x2::table::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut arg0.policies_registry, v0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2));
        0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(&mut arg0.policy_key_list, v0);
    }

    public fun add_policy_key_to_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::add_policy_key(0x2::table::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg2));
    }

    public fun add_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: vector<0x1::type_name::TypeName>, arg3: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(!0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::rule_already_exists());
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_with_key(v0, arg1, arg2);
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::add_policy_key(&mut v1, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::all_policies_key());
        0x2::table::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.strategies_registry, v0, v1);
        0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v0);
    }

    public fun assert_whitelisted_agent(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::agent_not_whitelisted());
    }

    public fun get_policies_for_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : vector<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy> {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        let v1 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::policy_keys(0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0));
        let v2 = 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v1)) {
            let v4 = *0x1::vector::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(v1, v3);
            if (!0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::is_all_policies_key(&v4)) {
                0x1::vector::push_back<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut v2, *0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v4));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0)
    }

    public(friend) fun has_policy_key(arg0: &GlobalConfig, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey) : bool {
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, arg1)
    }

    public fun has_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            whitelisted_agents         : 0x1::vector::empty<address>(),
            policies_registry          : 0x2::table::new<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(arg0),
            policy_key_list            : 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(),
            strategies_registry        : 0x2::table::new<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(arg0),
            active_strategies_key_list : 0x1::vector::empty<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_strategy_active_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : bool {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        0x1::vector::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.active_strategies_key_list, &v0)
    }

    public fun policy_by_key(arg0: &GlobalConfig, arg1: 0x1::string::String) : &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v0)
    }

    public(friend) fun policy_by_key_ref(arg0: &GlobalConfig, arg1: 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey) : &0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy {
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, arg1), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::borrow<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, arg1)
    }

    public fun remove_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_agents, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelisted_agents, v1);
        };
    }

    public fun remove_policy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut arg0.policies_registry, v0);
        let (v1, v2) = 0x1::vector::index_of<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(&arg0.policy_key_list, &v0);
        if (v1) {
            0x1::vector::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey>(&mut arg0.policy_key_list, v2);
        };
    }

    public fun remove_policy_key_from_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::remove_policy_key(0x2::table::borrow_mut<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg2));
    }

    public fun remove_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&arg0.strategies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        let (v1, v2) = 0x1::vector::index_of<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&arg0.active_strategies_key_list, &v0);
        if (v1) {
            0x1::vector::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v2);
        };
        0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::destroy_strategy(0x2::table::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::StrategyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::strategy::Strategy>(&mut arg0.strategies_registry, v0));
    }

    public fun set_version(arg0: &mut GlobalConfig, arg1: u8, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    public fun update_policy<T0, T1>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &AdminCap) {
        let v0 = 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&arg0.policies_registry, v0), 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::errors::config_rule_not_found());
        0x2::table::remove<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut arg0.policies_registry, v0);
        0x2::table::add<0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::PolicyKey, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::Policy>(&mut arg0.policies_registry, v0, 0x996f3afafbd1dad037b35389b9d8eb8ee1ead9319b96294f006ca4ac174ac675::policy::new(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg2));
    }

    public fun version(arg0: &GlobalConfig) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

