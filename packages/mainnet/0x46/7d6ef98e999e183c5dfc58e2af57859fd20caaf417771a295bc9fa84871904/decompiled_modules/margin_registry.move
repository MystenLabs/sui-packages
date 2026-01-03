module 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_registry {
    struct MARGIN_REGISTRY has drop {
        dummy_field: bool,
    }

    struct MarginRegistry has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct MarginRegistryInner has store {
        registry_id: 0x2::object::ID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        pool_registry: 0x2::table::Table<0x2::object::ID, PoolConfig>,
        margin_pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        margin_managers: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        allowed_maintainers: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_pause_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PoolConfig has copy, drop, store {
        base_margin_pool_id: 0x2::object::ID,
        quote_margin_pool_id: 0x2::object::ID,
        risk_ratios: RiskRatios,
        user_liquidation_reward: u64,
        pool_liquidation_reward: u64,
        enabled: bool,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct RiskRatios has copy, drop, store {
        min_withdraw_risk_ratio: u64,
        min_borrow_risk_ratio: u64,
        liquidation_risk_ratio: u64,
        target_liquidation_risk_ratio: u64,
    }

    struct ConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MarginAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarginPauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct MaintainerCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarginPoolCap has store, key {
        id: 0x2::object::UID,
        margin_pool_id: 0x2::object::ID,
    }

    struct MaintainerCapUpdated has copy, drop {
        maintainer_cap_id: 0x2::object::ID,
        allowed: bool,
        timestamp: u64,
    }

    struct PauseCapUpdated has copy, drop {
        pause_cap_id: 0x2::object::ID,
        allowed: bool,
        timestamp: u64,
    }

    struct DeepbookPoolRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        config: PoolConfig,
        timestamp: u64,
    }

    struct DeepbookPoolUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        enabled: bool,
        timestamp: u64,
    }

    struct DeepbookPoolConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        config: PoolConfig,
        timestamp: u64,
    }

    public fun add_config<T0: drop + store>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: T0) {
        load_inner(arg0);
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey<T0>, T0>(&mut arg0.id, v0, arg2);
    }

    public(friend) fun add_margin_manager(arg0: &mut MarginRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = load_inner_mut(arg0);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&v1.margin_managers, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v1.margin_managers, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v1.margin_managers, v0);
        0x2::vec_set::insert<0x2::object::ID>(v2, arg1);
        assert!(0x2::vec_set::length<0x2::object::ID>(v2) <= 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::max_margin_managers(), 13);
    }

    public fun allowed_maintainers(arg0: &MarginRegistry) : 0x2::vec_set::VecSet<0x2::object::ID> {
        load_inner(arg0).allowed_maintainers
    }

    public fun allowed_pause_caps(arg0: &MarginRegistry) : 0x2::vec_set::VecSet<0x2::object::ID> {
        load_inner(arg0).allowed_pause_caps
    }

    public(friend) fun assert_maintainer_cap_valid(arg0: &MarginRegistry, arg1: &MaintainerCap) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&load_inner(arg0).allowed_maintainers, &v0), 9);
    }

    public fun base_margin_pool_id(arg0: &MarginRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        get_pool_config(arg0, arg1).base_margin_pool_id
    }

    fun calculate_risk_ratios(arg0: u64) : RiskRatios {
        RiskRatios{
            min_withdraw_risk_ratio       : 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling() + 4 * arg0,
            min_borrow_risk_ratio         : 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling() + arg0,
            liquidation_risk_ratio        : 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling() + arg0 / 2,
            target_liquidation_risk_ratio : 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling() + arg0,
        }
    }

    public(friend) fun can_borrow(arg0: &MarginRegistry, arg1: 0x2::object::ID, arg2: u64) : bool {
        arg2 >= get_pool_config(arg0, arg1).risk_ratios.min_borrow_risk_ratio
    }

    public fun can_liquidate(arg0: &MarginRegistry, arg1: 0x2::object::ID, arg2: u64) : bool {
        arg2 < get_pool_config(arg0, arg1).risk_ratios.liquidation_risk_ratio
    }

    public(friend) fun can_withdraw(arg0: &MarginRegistry, arg1: 0x2::object::ID, arg2: u64) : bool {
        arg2 >= get_pool_config(arg0, arg1).risk_ratios.min_withdraw_risk_ratio
    }

    public fun disable_deepbook_pool<T0, T1>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &mut 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::id<T0, T1>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1), 3);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PoolConfig>(&mut v0.pool_registry, v1);
        assert!(v2.enabled == true, 6);
        v2.enabled = false;
        let v3 = DeepbookPoolUpdated{
            pool_id   : v1,
            enabled   : false,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v3);
    }

    public fun disable_version(arg0: &mut MarginRegistry, arg1: u64, arg2: &MarginAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 12);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun disable_version_pause_cap(arg0: &mut MarginRegistry, arg1: u64, arg2: &MarginPauseCap) {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0.allowed_pause_caps, &v1), 14);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 12);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun enable_deepbook_pool<T0, T1>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &mut 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::id<T0, T1>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1), 3);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PoolConfig>(&mut v0.pool_registry, v1);
        assert!(v2.enabled == false, 5);
        v2.enabled = true;
        let v3 = DeepbookPoolUpdated{
            pool_id   : v1,
            enabled   : true,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v3);
    }

    public fun enable_version(arg0: &mut MarginRegistry, arg1: u64, arg2: &MarginAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 11);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg1);
    }

    public(friend) fun get_config<T0: drop + store>(arg0: &MarginRegistry) : &T0 {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey<T0>, T0>(&arg0.id, v0)
    }

    public fun get_deepbook_pool_margin_pool_ids(arg0: &MarginRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID) {
        load_inner(arg0);
        let v0 = get_pool_config(arg0, arg1);
        (v0.base_margin_pool_id, v0.quote_margin_pool_id)
    }

    public fun get_margin_manager_ids(arg0: &MarginRegistry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        let v0 = load_inner(arg0);
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&v0.margin_managers, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&v0.margin_managers, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun get_margin_pool_id<T0>(arg0: &MarginRegistry) : 0x2::object::ID {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&v0.margin_pools, v1), 8);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&v0.margin_pools, v1)
    }

    public fun get_pool_config(arg0: &MarginRegistry, arg1: 0x2::object::ID) : &PoolConfig {
        let v0 = load_inner(arg0);
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, arg1), 3);
        0x2::table::borrow<0x2::object::ID, PoolConfig>(&v0.pool_registry, arg1)
    }

    fun init(arg0: MARGIN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = MarginRegistryInner{
            registry_id         : 0x2::object::uid_to_inner(&v0),
            allowed_versions    : 0x2::vec_set::singleton<u64>(0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::margin_version()),
            pool_registry       : 0x2::table::new<0x2::object::ID, PoolConfig>(arg1),
            margin_pools        : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
            margin_managers     : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
            allowed_maintainers : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_pause_caps  : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v2 = MarginRegistry{
            id    : v0,
            inner : 0x2::versioned::create<MarginRegistryInner>(0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::margin_version(), v1, arg1),
        };
        let v3 = MarginAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MarginRegistry>(v2);
        0x2::transfer::public_transfer<MarginAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun liquidation_risk_ratio(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).risk_ratios.liquidation_risk_ratio
    }

    public(friend) fun load_inner(arg0: &MarginRegistry) : &MarginRegistryInner {
        let v0 = 0x2::versioned::load_value<MarginRegistryInner>(&arg0.inner);
        let v1 = 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::margin_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 10);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut MarginRegistry) : &mut MarginRegistryInner {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        let v1 = 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::margin_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 10);
        v0
    }

    public(friend) fun maintainer_cap_id(arg0: &MaintainerCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun margin_pool_id(arg0: &MarginPoolCap) : 0x2::object::ID {
        arg0.margin_pool_id
    }

    public fun min_borrow_risk_ratio(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).risk_ratios.min_borrow_risk_ratio
    }

    public fun min_withdraw_risk_ratio(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).risk_ratios.min_withdraw_risk_ratio
    }

    public fun mint_maintainer_cap(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : MaintainerCap {
        let v0 = 0x2::object::new(arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner).allowed_maintainers, 0x2::object::uid_to_inner(&v0));
        let v1 = MaintainerCapUpdated{
            maintainer_cap_id : 0x2::object::uid_to_inner(&v0),
            allowed           : true,
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MaintainerCapUpdated>(v1);
        MaintainerCap{id: v0}
    }

    public fun mint_pause_cap(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : MarginPauseCap {
        let v0 = 0x2::object::new(arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner).allowed_pause_caps, 0x2::object::uid_to_inner(&v0));
        let v1 = PauseCapUpdated{
            pause_cap_id : 0x2::object::uid_to_inner(&v0),
            allowed      : true,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseCapUpdated>(v1);
        MarginPauseCap{id: v0}
    }

    public fun new_pool_config<T0, T1>(arg0: &MarginRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : PoolConfig {
        assert!(arg2 < arg1, 1);
        assert!(arg3 < arg2, 1);
        assert!(arg3 < arg4, 1);
        assert!(arg3 >= 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), 1);
        assert!(arg5 <= 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), 1);
        assert!(arg6 <= 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), 1);
        assert!(arg5 + arg6 <= 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), 1);
        assert!(arg4 > 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling() + arg5 + arg6, 1);
        let v0 = RiskRatios{
            min_withdraw_risk_ratio       : arg1,
            min_borrow_risk_ratio         : arg2,
            liquidation_risk_ratio        : arg3,
            target_liquidation_risk_ratio : arg4,
        };
        PoolConfig{
            base_margin_pool_id     : get_margin_pool_id<T0>(arg0),
            quote_margin_pool_id    : get_margin_pool_id<T1>(arg0),
            risk_ratios             : v0,
            user_liquidation_reward : arg5,
            pool_liquidation_reward : arg6,
            enabled                 : false,
            extra_fields            : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public fun new_pool_config_with_leverage<T0, T1>(arg0: &MarginRegistry, arg1: u64) : PoolConfig {
        load_inner(arg0);
        assert!(arg1 > 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::min_leverage(), 1);
        assert!(arg1 <= 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::max_leverage(), 1);
        let v0 = calculate_risk_ratios(0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::math::div(0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), arg1 - 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling()));
        new_pool_config<T0, T1>(arg0, v0.min_withdraw_risk_ratio, v0.min_borrow_risk_ratio, v0.liquidation_risk_ratio, v0.target_liquidation_risk_ratio, 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::default_user_liquidation_reward(), 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_constants::default_pool_liquidation_reward())
    }

    public(friend) fun pool_cap_id(arg0: &MarginPoolCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun pool_enabled<T0, T1>(arg0: &MarginRegistry, arg1: &0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>) : bool {
        let v0 = load_inner(arg0);
        let v1 = 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::id<T0, T1>(arg1);
        0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1) && 0x2::table::borrow<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1).enabled
    }

    public fun pool_liquidation_reward(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).pool_liquidation_reward
    }

    public fun quote_margin_pool_id(arg0: &MarginRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        get_pool_config(arg0, arg1).quote_margin_pool_id
    }

    public fun register_deepbook_pool<T0, T1>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>, arg3: PoolConfig, arg4: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::id<T0, T1>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1), 2);
        0x2::table::add<0x2::object::ID, PoolConfig>(&mut v0.pool_registry, v1, arg3);
        let v2 = DeepbookPoolRegistered{
            pool_id   : v1,
            config    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolRegistered>(v2);
    }

    public(friend) fun register_margin_pool(arg0: &mut MarginRegistry, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: &MaintainerCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert_maintainer_cap_valid(arg0, arg3);
        let v0 = load_inner_mut(arg0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&v0.margin_pools, arg1), 7);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v0.margin_pools, arg1, arg2);
        let v1 = MarginPoolCap{
            id             : 0x2::object::new(arg4),
            margin_pool_id : arg2,
        };
        0x2::transfer::public_transfer<MarginPoolCap>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun remove_config<T0: drop + store>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap) : T0 {
        load_inner(arg0);
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<ConfigKey<T0>, T0>(&mut arg0.id, v0)
    }

    public(friend) fun remove_margin_manager(arg0: &mut MarginRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut load_inner_mut(arg0).margin_managers, 0x2::tx_context::sender(arg2));
        assert!(0x2::vec_set::contains<0x2::object::ID>(v0, &arg1), 15);
        0x2::vec_set::remove<0x2::object::ID>(v0, &arg1);
    }

    public fun revoke_maintainer_cap(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0.allowed_maintainers, &arg2), 9);
        0x2::vec_set::remove<0x2::object::ID>(&mut v0.allowed_maintainers, &arg2);
        let v1 = MaintainerCapUpdated{
            maintainer_cap_id : arg2,
            allowed           : false,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MaintainerCapUpdated>(v1);
    }

    public fun revoke_pause_cap(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) {
        let v0 = 0x2::versioned::load_value_mut<MarginRegistryInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0.allowed_pause_caps, &arg3), 14);
        0x2::vec_set::remove<0x2::object::ID>(&mut v0.allowed_pause_caps, &arg3);
        let v1 = PauseCapUpdated{
            pause_cap_id : arg3,
            allowed      : false,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PauseCapUpdated>(v1);
    }

    public fun target_liquidation_risk_ratio(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).risk_ratios.target_liquidation_risk_ratio
    }

    public fun update_risk_params<T0, T1>(arg0: &mut MarginRegistry, arg1: &MarginAdminCap, arg2: &0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>, arg3: PoolConfig, arg4: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::id<T0, T1>(arg2);
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&v0.pool_registry, v1), 3);
        let v2 = 0x2::table::remove<0x2::object::ID, PoolConfig>(&mut v0.pool_registry, v1);
        assert!(arg3.risk_ratios.liquidation_risk_ratio <= v2.risk_ratios.liquidation_risk_ratio, 1);
        assert!(v2.enabled, 4);
        assert!(arg3.risk_ratios.min_borrow_risk_ratio < arg3.risk_ratios.min_withdraw_risk_ratio, 1);
        assert!(arg3.risk_ratios.liquidation_risk_ratio < arg3.risk_ratios.min_borrow_risk_ratio, 1);
        assert!(arg3.risk_ratios.liquidation_risk_ratio < arg3.risk_ratios.target_liquidation_risk_ratio, 1);
        assert!(arg3.risk_ratios.liquidation_risk_ratio >= 0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::constants::float_scaling(), 1);
        0x2::table::add<0x2::object::ID, PoolConfig>(&mut v0.pool_registry, v1, arg3);
        let v3 = DeepbookPoolConfigUpdated{
            pool_id   : v1,
            config    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolConfigUpdated>(v3);
    }

    public fun user_liquidation_reward(arg0: &MarginRegistry, arg1: 0x2::object::ID) : u64 {
        get_pool_config(arg0, arg1).user_liquidation_reward
    }

    // decompiled from Move bytecode v6
}

