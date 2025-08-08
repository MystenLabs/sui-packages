module 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u8,
        whitelisted_agents: vector<address>,
        rules_registry: 0x2::table::Table<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>,
        rules_key_list: vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>,
        strategies_registry: 0x2::table::Table<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>,
        active_strategies_key_list: vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun active_rule_keys(arg0: &GlobalConfig) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey> {
        &arg0.rules_key_list
    }

    public fun active_strategies(arg0: &GlobalConfig) : &vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        &arg0.active_strategies_key_list
    }

    public fun add_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        if (!0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.whitelisted_agents, arg1);
        };
    }

    public fun add_rule(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule, arg3: &AdminCap) {
        assert!(!0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_already_exists());
        0x2::table::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut arg0.rules_registry, arg1, arg2);
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut arg0.rules_key_list, arg1);
    }

    public fun add_rule_key_to_strategy(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, arg3: &AdminCap) {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(0x2::table::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategies_registry, arg1), arg2);
    }

    public fun add_strategy(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: 0x1::string::String, arg3: &AdminCap) {
        assert!(!0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_already_exists());
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::new_with_key(arg1, arg2);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(&mut v0, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key());
        0x2::table::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategies_registry, arg1, v0);
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, arg1);
    }

    public fun add_strategy_for_base_asset<T0>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::new_strategy_key<T0>();
        assert!(!0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, v0), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::rule_already_exists());
        let v1 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::new_with_key(v0, arg1);
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::add_rule_key(&mut v1, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::all_rules_key());
        0x2::table::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategies_registry, v0, v1);
        0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v0);
    }

    public fun assert_whitelisted_agent(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::agent_not_whitelisted());
    }

    public fun find_strategy_key_for_base_asset<T0>(arg0: &GlobalConfig) : 0x1::option::Option<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list)) {
            let v1 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list, v0);
            if (0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::matches_base_asset_type<T0>(&v1)) {
                return 0x1::option::some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>()
    }

    public fun get_allowed_adapters_for_asset_through_strategies(arg0: &GlobalConfig, arg1: 0x1::type_name::TypeName) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list)) {
            let v2 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list, v1)));
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v2)) {
                let v4 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v2, v3);
                if (!0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::is_all_rules_key(&v4)) {
                    let v5 = 0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, v4);
                    if (*0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::asset_type(v5) == arg1) {
                        let v6 = *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::adapter_type(v5);
                        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v6)) {
                            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v6);
                        };
                    };
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_allowed_adapters_for_strategy(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : vector<0x1::type_name::TypeName> {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1));
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0)) {
            let v3 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0, v2);
            if (!0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::is_all_rules_key(&v3)) {
                let v4 = *0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::adapter_type(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, v3));
                if (!0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v4)) {
                    0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v4);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_rules_for_strategy(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : vector<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule> {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let v0 = 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::rule_keys(0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1));
        let v1 = 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0)) {
            let v3 = *0x1::vector::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(v0, v2);
            if (!0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::is_all_rules_key(&v3)) {
                0x1::vector::push_back<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut v1, *0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, v3));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_strategy(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1)
    }

    public(friend) fun has_rule_key(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) : bool {
        0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1)
    }

    public fun has_strategy(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1)
    }

    public fun has_strategy_for_base_asset<T0>(arg0: &GlobalConfig) : bool {
        let v0 = find_strategy_key_for_base_asset<T0>(arg0);
        0x1::option::is_some<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            whitelisted_agents         : 0x1::vector::empty<address>(),
            rules_registry             : 0x2::table::new<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(arg0),
            rules_key_list             : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(),
            strategies_registry        : 0x2::table::new<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(arg0),
            active_strategies_key_list : 0x1::vector::empty<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_strategy_active(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey) : bool {
        0x1::vector::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list, &arg1)
    }

    public fun remove_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_agents, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelisted_agents, v1);
        };
    }

    public fun remove_rule(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, arg2: &AdminCap) {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x2::table::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut arg0.rules_registry, arg1);
        let (v0, v1) = 0x1::vector::index_of<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&arg0.rules_key_list, &arg1);
        if (v0) {
            0x1::vector::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey>(&mut arg0.rules_key_list, v1);
        };
    }

    public fun remove_rule_key_from_strategy(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, arg3: &AdminCap) {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::remove_rule_key(0x2::table::borrow_mut<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategies_registry, arg1), arg2);
    }

    public fun remove_strategy(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, arg2: &AdminCap) {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&arg0.strategies_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        let (v0, v1) = 0x1::vector::index_of<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&arg0.active_strategies_key_list, &arg1);
        if (v0) {
            0x1::vector::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v1);
        };
        0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::destroy_strategy(0x2::table::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::StrategyKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::strategy::Strategy>(&mut arg0.strategies_registry, arg1));
    }

    public fun rule_by_key(arg0: &GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey) : &0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x2::table::borrow<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1)
    }

    public fun set_version(arg0: &mut GlobalConfig, arg1: u8, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    public fun update_rule(arg0: &mut GlobalConfig, arg1: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, arg2: 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule, arg3: &AdminCap) {
        assert!(0x2::table::contains<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&arg0.rules_registry, arg1), 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::errors::config_rule_not_found());
        0x2::table::remove<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut arg0.rules_registry, arg1);
        0x2::table::add<0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::RuleKey, 0x1d1c128f63952a03886b375b3e27c97e3ae51d508a5ae98a4356699da621c0b2::rule::Rule>(&mut arg0.rules_registry, arg1, arg2);
    }

    public fun version(arg0: &GlobalConfig) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

