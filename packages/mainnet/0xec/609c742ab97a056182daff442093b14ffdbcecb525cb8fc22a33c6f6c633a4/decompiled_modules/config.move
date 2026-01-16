module 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u8,
        whitelisted_agents: vector<address>,
        policies_registry: 0x2::table::Table<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>,
        policy_key_list: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>,
        strategies_registry: 0x2::table::Table<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>,
        active_strategies_key_list: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>,
        activation_fee_val: u64,
        fee_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        performance_fee_rates: 0x2::table::Table<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>,
        performance_fee_store: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::AssetStore,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConfigPoliciesUpdatedEvent has copy, drop {
        total_policies: u64,
        active_policy_keys: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>,
    }

    struct ConfigAgentsUpdatedEvent has copy, drop {
        total_whitelisted_agents: u64,
        whitelisted_agents: vector<address>,
    }

    struct ConfigStrategiesUpdatedEvent has copy, drop {
        total_active_strategies: u64,
        active_strategy_keys: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>,
    }

    struct ConfigStrategyPoliciesUpdatedEvent has copy, drop {
        strategy_key: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey,
        strategy_name: 0x1::string::String,
        policy_keys: vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>,
        total_policies: u64,
    }

    struct ConfigVersionUpdatedEvent has copy, drop {
        old_version: u8,
        new_version: u8,
    }

    struct ConfigActivationFeeUpdatedEvent has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct CollectedFeesWithdrawnEvent has copy, drop {
        amount: u64,
        remaining_treasury_balance: u64,
        recipient: address,
    }

    struct ConfigPerformanceFeeUpdatedEvent has copy, drop {
        strategy_key: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey,
        strategy_name: 0x1::string::String,
        old_rate: u64,
        new_rate: u64,
    }

    struct ConfigPerformanceFeesWithdrawnEvent has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        remaining_balance: u64,
        recipient: address,
    }

    public fun activation_fee(arg0: &GlobalConfig) : u64 {
        arg0.activation_fee_val
    }

    public fun active_policy_keys(arg0: &GlobalConfig) : &vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey> {
        &arg0.policy_key_list
    }

    public fun active_strategies(arg0: &GlobalConfig) : &vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey> {
        &arg0.active_strategies_key_list
    }

    public fun add_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        assert!(!0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::agent_already_whitelisted());
        0x1::vector::push_back<address>(&mut arg0.whitelisted_agents, arg1);
        let v0 = ConfigAgentsUpdatedEvent{
            total_whitelisted_agents : 0x1::vector::length<address>(&arg0.whitelisted_agents),
            whitelisted_agents       : arg0.whitelisted_agents,
        };
        0x2::event::emit<ConfigAgentsUpdatedEvent>(v0);
    }

    public fun add_policy<T0, T1>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg1);
        assert!(!0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::rule_already_exists());
        0x2::table::add<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&mut arg0.policies_registry, v0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>()));
        0x1::vector::push_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut arg0.policy_key_list, v0);
        let v1 = ConfigPoliciesUpdatedEvent{
            total_policies     : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_key_list),
            active_policy_keys : arg0.policy_key_list,
        };
        0x2::event::emit<ConfigPoliciesUpdatedEvent>(v1);
    }

    public fun add_policy_key_to_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg2);
        assert!(has_policy_key(arg0, v1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::rule_not_found());
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::add_policy_key(0x2::table::borrow_mut<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&mut arg0.strategies_registry, v0), v1);
        let v2 = 0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0);
        let v3 = ConfigStrategyPoliciesUpdatedEvent{
            strategy_key   : v0,
            strategy_name  : arg1,
            policy_keys    : *0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::policy_keys(v2),
            total_policies : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::policy_keys(v2)),
        };
        0x2::event::emit<ConfigStrategyPoliciesUpdatedEvent>(v3);
    }

    public fun add_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: vector<0x1::type_name::TypeName>, arg3: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(!0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::strategy_already_exists());
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_with_key(v0, arg1, arg2);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::add_policy_key(&mut v1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::all_policies_key());
        0x2::table::add<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&mut arg0.strategies_registry, v0, v1);
        0x1::vector::push_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v0);
        0x2::table::add<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&mut arg0.performance_fee_rates, v0, 1000);
        let v2 = ConfigStrategiesUpdatedEvent{
            total_active_strategies : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(&arg0.active_strategies_key_list),
            active_strategy_keys    : arg0.active_strategies_key_list,
        };
        0x2::event::emit<ConfigStrategiesUpdatedEvent>(v2);
    }

    public fun assert_version_compatibility(arg0: &GlobalConfig) {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::version::assert_version_compatibility(arg0.version);
    }

    public fun assert_whitelisted_agent(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::agent_not_whitelisted());
    }

    public fun calculate_performance_fee(arg0: &GlobalConfig, arg1: 0x1::string::String, arg2: u64) : u64 {
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::math::safe_mul_div(arg2, performance_fee_rate(arg0, arg1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::constants::basis_points_divisor())
    }

    public(friend) fun collect_fee(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version_compatibility(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun collect_performance_fee<T0>(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<T0>) {
        assert_version_compatibility(arg0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::deposit<T0>(&mut arg0.performance_fee_store, arg1);
    }

    public fun fee_treasury_balance(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_treasury)
    }

    public fun get_policies_for_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : vector<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy> {
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::policy_keys(0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0));
        let v2 = 0x1::vector::empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(v1)) {
            let v4 = *0x1::vector::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(v1, v3);
            if (!0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::is_all_policies_key(&v4)) {
                0x1::vector::push_back<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&mut v2, *0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v4));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy {
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0)
    }

    public fun get_whitelisted_agents(arg0: &GlobalConfig) : &vector<address> {
        &arg0.whitelisted_agents
    }

    public(friend) fun has_policy_key(arg0: &GlobalConfig, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey) : bool {
        0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, arg1)
    }

    public fun has_strategy_by_name(arg0: &GlobalConfig, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            whitelisted_agents         : 0x1::vector::empty<address>(),
            policies_registry          : 0x2::table::new<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(arg0),
            policy_key_list            : 0x1::vector::empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(),
            strategies_registry        : 0x2::table::new<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(arg0),
            active_strategies_key_list : 0x1::vector::empty<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(),
            activation_fee_val         : 0,
            fee_treasury               : 0x2::balance::zero<0x2::sui::SUI>(),
            performance_fee_rates      : 0x2::table::new<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(arg0),
            performance_fee_store      : 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::new(arg0),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_agent_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1)
    }

    public fun performance_fee_rate(arg0: &GlobalConfig, arg1: 0x1::string::String) : u64 {
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        *0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0)
    }

    public fun policy_by_key(arg0: &GlobalConfig, arg1: 0x1::string::String) : &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy {
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v0)
    }

    public(friend) fun policy_by_key_ref(arg0: &GlobalConfig, arg1: 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey) : &0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy {
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, arg1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, arg1)
    }

    public fun remove_agent(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        assert!(0x1::vector::contains<address>(&arg0.whitelisted_agents, &arg1), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::agent_not_whitelisted());
        let (_, v1) = 0x1::vector::index_of<address>(&arg0.whitelisted_agents, &arg1);
        0x1::vector::remove<address>(&mut arg0.whitelisted_agents, v1);
        let v2 = ConfigAgentsUpdatedEvent{
            total_whitelisted_agents : 0x1::vector::length<address>(&arg0.whitelisted_agents),
            whitelisted_agents       : arg0.whitelisted_agents,
        };
        0x2::event::emit<ConfigAgentsUpdatedEvent>(v2);
    }

    public fun remove_policy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0x2::table::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&mut arg0.policies_registry, v0);
        let (v1, v2) = 0x1::vector::index_of<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_key_list, &v0);
        if (v1) {
            0x1::vector::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&mut arg0.policy_key_list, v2);
        };
        let v3 = ConfigPoliciesUpdatedEvent{
            total_policies     : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_key_list),
            active_policy_keys : arg0.policy_key_list,
        };
        0x2::event::emit<ConfigPoliciesUpdatedEvent>(v3);
    }

    public fun remove_policy_key_from_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::remove_policy_key(0x2::table::borrow_mut<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&mut arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg2));
        let v1 = 0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0);
        let v2 = ConfigStrategyPoliciesUpdatedEvent{
            strategy_key   : v0,
            strategy_name  : arg1,
            policy_keys    : *0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::policy_keys(v1),
            total_policies : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::policy_keys(v1)),
        };
        0x2::event::emit<ConfigStrategyPoliciesUpdatedEvent>(v2);
    }

    public fun remove_strategy(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        let (v1, v2) = 0x1::vector::index_of<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(&arg0.active_strategies_key_list, &v0);
        if (v1) {
            0x1::vector::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(&mut arg0.active_strategies_key_list, v2);
        };
        if (0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0)) {
            0x2::table::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&mut arg0.performance_fee_rates, v0);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::destroy_strategy(0x2::table::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&mut arg0.strategies_registry, v0));
        let v3 = ConfigStrategiesUpdatedEvent{
            total_active_strategies : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey>(&arg0.active_strategies_key_list),
            active_strategy_keys    : arg0.active_strategies_key_list,
        };
        0x2::event::emit<ConfigStrategiesUpdatedEvent>(v3);
    }

    public fun set_activation_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        arg0.activation_fee_val = arg1;
        let v0 = ConfigActivationFeeUpdatedEvent{
            old_fee : arg0.activation_fee_val,
            new_fee : arg1,
        };
        0x2::event::emit<ConfigActivationFeeUpdatedEvent>(v0);
    }

    public fun set_performance_fee_rate(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: &AdminCap) {
        assert_version_compatibility(arg0);
        assert!(arg2 <= 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::constants::basis_points_divisor(), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::invalid_fee_rate());
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::new_strategy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::Strategy>(&arg0.strategies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        let v1 = if (0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0)) {
            *0x2::table::borrow<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0)
        } else {
            0
        };
        if (0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&arg0.performance_fee_rates, v0)) {
            *0x2::table::borrow_mut<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&mut arg0.performance_fee_rates, v0) = arg2;
        } else {
            0x2::table::add<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::strategy::StrategyKey, u64>(&mut arg0.performance_fee_rates, v0, arg2);
        };
        let v2 = ConfigPerformanceFeeUpdatedEvent{
            strategy_key  : v0,
            strategy_name : arg1,
            old_rate      : v1,
            new_rate      : arg2,
        };
        0x2::event::emit<ConfigPerformanceFeeUpdatedEvent>(v2);
    }

    public fun set_version(arg0: &mut GlobalConfig, arg1: u8, arg2: &AdminCap) {
        arg0.version = arg1;
        let v0 = ConfigVersionUpdatedEvent{
            old_version : arg0.version,
            new_version : arg1,
        };
        0x2::event::emit<ConfigVersionUpdatedEvent>(v0);
    }

    public fun update_policy<T0, T1>(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &AdminCap) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new_policy_key(arg1);
        assert!(0x2::table::contains<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&arg0.policies_registry, v0), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::errors::config_rule_not_found());
        0x2::table::remove<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&mut arg0.policies_registry, v0);
        0x2::table::add<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::Policy>(&mut arg0.policies_registry, v0, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::new(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>()));
        let v1 = ConfigPoliciesUpdatedEvent{
            total_policies     : 0x1::vector::length<0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::policy::PolicyKey>(&arg0.policy_key_list),
            active_policy_keys : arg0.policy_key_list,
        };
        0x2::event::emit<ConfigPoliciesUpdatedEvent>(v1);
    }

    public fun version(arg0: &GlobalConfig) : u8 {
        arg0.version
    }

    public fun withdraw_fees(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_compatibility(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee_treasury), arg2), 0x2::tx_context::sender(arg2));
        let v0 = CollectedFeesWithdrawnEvent{
            amount                     : 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_treasury),
            remaining_treasury_balance : 0,
            recipient                  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CollectedFeesWithdrawnEvent>(v0);
    }

    public fun withdraw_performance_fees<T0>(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_compatibility(arg0);
        let v0 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::asset_balance<T0>(&arg0.performance_fee_store, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::create_asset_key<T0>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::asset_store::withdraw<T0>(&mut arg0.performance_fee_store, v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = ConfigPerformanceFeesWithdrawnEvent{
            asset_type        : 0x1::type_name::with_defining_ids<T0>(),
            amount            : v0,
            remaining_balance : 0,
            recipient         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ConfigPerformanceFeesWithdrawnEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

