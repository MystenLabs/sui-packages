module 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        config_version: u64,
        global_paused: bool,
        package_policies: vector<PackagePolicy>,
        domain_pauses: vector<DomainPause>,
    }

    struct PackagePolicy has store {
        package: 0x1::type_name::TypeName,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        paused: bool,
    }

    struct DomainPause has copy, drop, store {
        domain: vector<u8>,
        target: 0x2::object::ID,
        has_target: bool,
        paused: bool,
    }

    struct GlobalConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        config_version: u64,
    }

    struct PackageRegisteredEvent has copy, drop {
        config_id: 0x2::object::ID,
        package: 0x1::type_name::TypeName,
        initial_version: u64,
    }

    struct PackageVersionUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        package: 0x1::type_name::TypeName,
        version: u64,
        allowed: bool,
    }

    struct PackagePauseUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        package: 0x1::type_name::TypeName,
        paused: bool,
    }

    struct GlobalPauseUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct DomainPauseUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        domain: vector<u8>,
        target: 0x1::option::Option<0x2::object::ID>,
        paused: bool,
    }

    public fun id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<GlobalConfig>(arg0)
    }

    public fun allow_package_version_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        assert!(arg2 > 0, 3307);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::vector::borrow_mut<PackagePolicy>(&mut arg0.package_policies, package_index(arg0, &v0));
        if (!0x2::vec_set::contains<u64>(&v1.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v1.allowed_versions, arg2);
        };
        let v2 = PackageVersionUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            package   : v0,
            version   : arg2,
            allowed   : true,
        };
        0x2::event::emit<PackageVersionUpdatedEvent>(v2);
    }

    fun assert_config_schema(arg0: &GlobalConfig) {
        assert!(arg0.config_version == 1, 3300);
    }

    public fun assert_domain_active<T0: drop>(arg0: &GlobalConfig, arg1: u64, arg2: vector<u8>, arg3: u64) {
        assert_package_active<T0>(arg0, arg1);
        assert!(!domain_paused(arg0, arg2), arg3);
    }

    public fun assert_package_active<T0: drop>(arg0: &GlobalConfig, arg1: u64) {
        assert_package_version<T0>(arg0, arg1);
        assert!(!arg0.global_paused, 3301);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).paused, 3304);
    }

    public fun assert_package_version<T0: drop>(arg0: &GlobalConfig, arg1: u64) {
        assert_root_package_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions, &arg1), 3305);
    }

    fun assert_root_package_version(arg0: &GlobalConfig) {
        assert_config_schema(arg0);
        let v0 = 0x1::type_name::with_original_ids<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::package_version::PackageMarker>();
        let v1 = 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::package_version::current();
        assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions, &v1), 3305);
    }

    public fun assert_target_active<T0: drop>(arg0: &GlobalConfig, arg1: u64, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: u64) {
        assert_package_active<T0>(arg0, arg1);
        assert!(!paused(arg0, arg2, arg3), arg4);
    }

    public fun config_version(arg0: &GlobalConfig) : u64 {
        arg0.config_version
    }

    public fun current_config_version() : u64 {
        1
    }

    public fun disallow_package_version_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::vector::borrow_mut<PackagePolicy>(&mut arg0.package_policies, package_index(arg0, &v0));
        assert!(0x2::vec_set::contains<u64>(&v1.allowed_versions, &arg2), 3305);
        assert!(0x2::vec_set::length<u64>(&v1.allowed_versions) > 1, 3306);
        0x2::vec_set::remove<u64>(&mut v1.allowed_versions, &arg2);
        let v2 = PackageVersionUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            package   : v0,
            version   : arg2,
            allowed   : false,
        };
        0x2::event::emit<PackageVersionUpdatedEvent>(v2);
    }

    public fun domain_paused(arg0: &GlobalConfig, arg1: vector<u8>) : bool {
        let (v0, v1) = find_pause(arg0, &arg1, none_id(), false);
        v0 && 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v1).paused
    }

    fun find_package(arg0: &GlobalConfig, arg1: &0x1::type_name::TypeName) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PackagePolicy>(&arg0.package_policies)) {
            if (&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, v0).package == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun find_pause(arg0: &GlobalConfig, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: bool) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPause>(&arg0.domain_pauses)) {
            let v1 = 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v0);
            let v2 = if (&v1.domain == arg1) {
                if (v1.has_target == arg3) {
                    !arg3 || v1.target == arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun global_paused(arg0: &GlobalConfig) : bool {
        arg0.global_paused
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GlobalConfig>(new_config(arg0));
    }

    fun new_config(arg0: &mut 0x2::tx_context::TxContext) : GlobalConfig {
        let v0 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            config_version   : 1,
            global_paused    : false,
            package_policies : 0x1::vector::empty<PackagePolicy>(),
            domain_pauses    : 0x1::vector::empty<DomainPause>(),
        };
        let v1 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v1, 0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::package_version::current());
        let v2 = PackagePolicy{
            package          : 0x1::type_name::with_original_ids<0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::package_version::PackageMarker>(),
            allowed_versions : v1,
            paused           : false,
        };
        0x1::vector::push_back<PackagePolicy>(&mut v0.package_policies, v2);
        let v3 = GlobalConfigCreatedEvent{
            config_id      : 0x2::object::id<GlobalConfig>(&v0),
            config_version : 1,
        };
        0x2::event::emit<GlobalConfigCreatedEvent>(v3);
        v0
    }

    fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun package_allowed_versions<T0: drop>(arg0: &GlobalConfig) : vector<u64> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::into_keys<u64>(0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions)
    }

    fun package_index(arg0: &GlobalConfig, arg1: &0x1::type_name::TypeName) : u64 {
        let (v0, v1) = find_package(arg0, arg1);
        assert!(v0, 3302);
        v1
    }

    public fun package_paused<T0: drop>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = find_package(arg0, &v0);
        v1 && 0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, v2).paused
    }

    public fun package_registered<T0: drop>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, _) = find_package(arg0, &v0);
        v1
    }

    public fun package_version_allowed<T0: drop>(arg0: &GlobalConfig, arg1: u64) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = find_package(arg0, &v0);
        v1 && 0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, v2).allowed_versions, &arg1)
    }

    public fun pause_entry_count(arg0: &GlobalConfig) : u64 {
        0x1::vector::length<DomainPause>(&arg0.domain_pauses)
    }

    public fun paused(arg0: &GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        domain_paused(arg0, arg1) || target_paused(arg0, arg1, arg2)
    }

    public fun register_package_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        assert!(arg2 > 0, 3307);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = find_package(arg0, &v0);
        if (v1) {
            assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, v2).allowed_versions, &arg2), 3303);
            return
        };
        let v3 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v3, arg2);
        let v4 = PackagePolicy{
            package          : v0,
            allowed_versions : v3,
            paused           : false,
        };
        0x1::vector::push_back<PackagePolicy>(&mut arg0.package_policies, v4);
        let v5 = PackageRegisteredEvent{
            config_id       : 0x2::object::id<GlobalConfig>(arg0),
            package         : v0,
            initial_version : arg2,
        };
        0x2::event::emit<PackageRegisteredEvent>(v5);
    }

    public fun set_domain_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: vector<u8>, arg3: bool) {
        assert_root_package_version(arg0);
        set_pause(arg0, arg2, none_id(), false, arg3);
    }

    public fun set_global_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: bool) {
        assert_root_package_version(arg0);
        arg0.global_paused = arg2;
        let v0 = GlobalPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<GlobalPauseUpdatedEvent>(v0);
    }

    public fun set_package_pause_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: bool) {
        assert_root_package_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::vector::borrow_mut<PackagePolicy>(&mut arg0.package_policies, package_index(arg0, &v0)).paused = arg2;
        let v1 = PackagePauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            package   : v0,
            paused    : arg2,
        };
        0x2::event::emit<PackagePauseUpdatedEvent>(v1);
    }

    fun set_pause(arg0: &mut GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: bool, arg4: bool) {
        let (v0, v1) = find_pause(arg0, &arg1, arg2, arg3);
        if (v0) {
            if (arg4) {
                0x1::vector::borrow_mut<DomainPause>(&mut arg0.domain_pauses, v1).paused = true;
            } else {
                0x1::vector::swap_remove<DomainPause>(&mut arg0.domain_pauses, v1);
            };
        } else if (arg4) {
            let v2 = DomainPause{
                domain     : arg1,
                target     : arg2,
                has_target : arg3,
                paused     : arg4,
            };
            0x1::vector::push_back<DomainPause>(&mut arg0.domain_pauses, v2);
        };
        let v3 = if (arg3) {
            0x1::option::some<0x2::object::ID>(arg2)
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v4 = DomainPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            domain    : arg1,
            target    : v3,
            paused    : arg4,
        };
        0x2::event::emit<DomainPauseUpdatedEvent>(v4);
    }

    public fun set_target_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: bool) {
        assert_root_package_version(arg0);
        set_pause(arg0, arg2, arg3, true, arg4);
    }

    public fun target_paused(arg0: &GlobalConfig, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        let (v0, v1) = find_pause(arg0, &arg1, arg2, true);
        v0 && 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v1).paused
    }

    // decompiled from Move bytecode v7
}

