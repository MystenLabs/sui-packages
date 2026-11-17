module 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_adapter_registry {
    struct AdapterRegistry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        adapter_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        witnesses: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct AdapterRegisteredEvent has copy, drop {
        adapter_id: 0x2::object::ID,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun adapter_count(arg0: &AdapterRegistry) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.adapter_ids)
    }

    public fun adapter_for_witness(arg0: &AdapterRegistry, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<0x2::object::ID> {
        0x2::vec_map::try_get<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.witnesses, &arg1)
    }

    public fun allowed_versions(arg0: &AdapterRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public fun disable_version(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut AdapterRegistry, arg2: u64) {
        assert!(arg2 != 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 4);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<AdapterRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut AdapterRegistry, arg2: u64) {
        assert!(arg2 <= 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version() + 1, 3);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<AdapterRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdapterRegistry{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version()),
            adapter_ids      : 0x2::vec_set::empty<0x2::object::ID>(),
            witnesses        : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<AdapterRegistry>(v0);
    }

    public fun is_registered(arg0: &AdapterRegistry, arg1: &0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.adapter_ids, arg1)
    }

    public fun register_adapter(arg0: &0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap, arg1: &mut AdapterRegistry, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg1.adapter_ids, &arg2), 1);
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.witnesses, &arg3), 2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.adapter_ids, arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.witnesses, arg3, arg2);
        let v0 = AdapterRegisteredEvent{adapter_id: arg2};
        0x2::event::emit<AdapterRegisteredEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

