module 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::nami_strategy_registry {
    struct NAMI_STRATEGY_REGISTRY has drop {
        dummy_field: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        strategy_ids: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct StrategyRegisteredEvent has copy, drop {
        strategy_id: 0x2::object::ID,
    }

    struct StrategyDeregisteredEvent has copy, drop {
        strategy_id: 0x2::object::ID,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun allowed_versions(arg0: &StrategyRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public(friend) fun deregister_strategy(arg0: &mut StrategyRegistry, arg1: 0x2::object::ID) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version::assert_version(&arg0.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.strategy_ids, arg1), 2);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.strategy_ids, arg1);
        let v0 = StrategyDeregisteredEvent{strategy_id: arg1};
        0x2::event::emit<StrategyDeregisteredEvent>(v0);
    }

    public fun disable_version(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut StrategyRegistry, arg2: u64) {
        assert!(arg2 != 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 4);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<StrategyRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut StrategyRegistry, arg2: u64) {
        assert!(arg2 <= 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version::current_version() + 1, 3);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<StrategyRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    fun init(arg0: NAMI_STRATEGY_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NAMI_STRATEGY_REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        share_registry(arg1);
    }

    public fun is_registered(arg0: &StrategyRegistry, arg1: &0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.strategy_ids, *arg1)
    }

    public(friend) fun register_strategy(arg0: &mut StrategyRegistry, arg1: 0x2::object::ID) {
        0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version::assert_version(&arg0.allowed_versions);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.strategy_ids, arg1), 1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.strategy_ids, arg1, true);
        let v0 = StrategyRegisteredEvent{strategy_id: arg1};
        0x2::event::emit<StrategyRegisteredEvent>(v0);
    }

    fun share_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyRegistry{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version::current_version()),
            strategy_ids     : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<StrategyRegistry>(v0);
    }

    public fun strategy_count(arg0: &StrategyRegistry) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.strategy_ids)
    }

    // decompiled from Move bytecode v7
}

