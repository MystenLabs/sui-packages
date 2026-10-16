module 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        config_version: u64,
        global_paused: bool,
        package_policies: vector<PackagePolicy>,
        domain_pauses: vector<DomainPause>,
        treasury_recipient: address,
    }

    struct PackagePolicy has store {
        package: 0x1::type_name::TypeName,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        paused: bool,
    }

    struct DomainPause has copy, drop, store {
        domain: u8,
        paused: bool,
    }

    struct GlobalConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        config_version: u64,
        treasury_recipient: address,
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
        domain: u8,
        paused: bool,
    }

    struct TreasuryRecipientUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        treasury_recipient: address,
    }

    public fun id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::id<GlobalConfig>(arg0)
    }

    public fun admin_domain() : u8 {
        5
    }

    public fun allow_package_version_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        assert!(arg2 > 0, 3407);
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
        assert!(arg0.config_version == 1, 3400);
    }

    public fun assert_domain_active<T0: drop>(arg0: &GlobalConfig, arg1: u64, arg2: u8) {
        assert_package_active<T0>(arg0, arg1);
        assert_valid_domain(arg2);
        assert!(!domain_paused(arg0, arg2), 3408);
    }

    public fun assert_package_active<T0: drop>(arg0: &GlobalConfig, arg1: u64) {
        assert_package_version<T0>(arg0, arg1);
        assert!(!arg0.global_paused, 3401);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).paused, 3404);
    }

    public fun assert_package_version<T0: drop>(arg0: &GlobalConfig, arg1: u64) {
        assert_root_package_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions, &arg1), 3405);
    }

    fun assert_root_package_version(arg0: &GlobalConfig) {
        assert_config_schema(arg0);
        let v0 = 0x1::type_name::with_original_ids<0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::package_version::PackageMarker>();
        let v1 = 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::package_version::current();
        assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions, &v1), 3405);
    }

    fun assert_valid_domain(arg0: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        };
        assert!(v0, 3409);
    }

    public fun config_version(arg0: &GlobalConfig) : u64 {
        arg0.config_version
    }

    public fun current_config_version() : u64 {
        1
    }

    public fun disallow_package_version_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::vector::borrow_mut<PackagePolicy>(&mut arg0.package_policies, package_index(arg0, &v0));
        assert!(0x2::vec_set::contains<u64>(&v1.allowed_versions, &arg2), 3405);
        assert!(0x2::vec_set::length<u64>(&v1.allowed_versions) > 1, 3406);
        0x2::vec_set::remove<u64>(&mut v1.allowed_versions, &arg2);
        let v2 = PackageVersionUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            package   : v0,
            version   : arg2,
            allowed   : false,
        };
        0x2::event::emit<PackageVersionUpdatedEvent>(v2);
    }

    public fun domain_paused(arg0: &GlobalConfig, arg1: u8) : bool {
        let (v0, v1) = find_domain(arg0, arg1);
        v0 && 0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v1).paused
    }

    fun find_domain(arg0: &GlobalConfig, arg1: u8) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<DomainPause>(&arg0.domain_pauses)) {
            if (0x1::vector::borrow<DomainPause>(&arg0.domain_pauses, v0).domain == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
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

    public fun global_paused(arg0: &GlobalConfig) : bool {
        arg0.global_paused
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GlobalConfig>(new_config(arg0));
    }

    fun new_config(arg0: &mut 0x2::tx_context::TxContext) : GlobalConfig {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::package_version::current());
        let v1 = PackagePolicy{
            package          : 0x1::type_name::with_original_ids<0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::package_version::PackageMarker>(),
            allowed_versions : v0,
            paused           : false,
        };
        let v2 = 0x1::vector::empty<PackagePolicy>();
        0x1::vector::push_back<PackagePolicy>(&mut v2, v1);
        let v3 = GlobalConfig{
            id                 : 0x2::object::new(arg0),
            config_version     : 1,
            global_paused      : false,
            package_policies   : v2,
            domain_pauses      : 0x1::vector::empty<DomainPause>(),
            treasury_recipient : 0x2::tx_context::sender(arg0),
        };
        let v4 = GlobalConfigCreatedEvent{
            config_id          : 0x2::object::id<GlobalConfig>(&v3),
            config_version     : 1,
            treasury_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<GlobalConfigCreatedEvent>(v4);
        v3
    }

    public fun orderbook_domain() : u8 {
        6
    }

    public fun package_allowed_versions<T0: drop>(arg0: &GlobalConfig) : vector<u64> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::into_keys<u64>(0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, package_index(arg0, &v0)).allowed_versions)
    }

    fun package_index(arg0: &GlobalConfig, arg1: &0x1::type_name::TypeName) : u64 {
        let (v0, v1) = find_package(arg0, arg1);
        assert!(v0, 3402);
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

    public fun register_package_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: u64) {
        assert_root_package_version(arg0);
        assert!(arg2 > 0, 3407);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = find_package(arg0, &v0);
        if (v1) {
            assert!(0x2::vec_set::contains<u64>(&0x1::vector::borrow<PackagePolicy>(&arg0.package_policies, v2).allowed_versions, &arg2), 3403);
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

    public fun router_domain() : u8 {
        3
    }

    public fun scoreboard_domain() : u8 {
        2
    }

    public fun set_domain_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: u8, arg3: bool) {
        assert_root_package_version(arg0);
        assert_valid_domain(arg2);
        let (v0, v1) = find_domain(arg0, arg2);
        if (v0) {
            if (arg3) {
                0x1::vector::borrow_mut<DomainPause>(&mut arg0.domain_pauses, v1).paused = true;
            } else {
                0x1::vector::swap_remove<DomainPause>(&mut arg0.domain_pauses, v1);
            };
        } else if (arg3) {
            let v2 = DomainPause{
                domain : arg2,
                paused : true,
            };
            0x1::vector::push_back<DomainPause>(&mut arg0.domain_pauses, v2);
        };
        let v3 = DomainPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            domain    : arg2,
            paused    : arg3,
        };
        0x2::event::emit<DomainPauseUpdatedEvent>(v3);
    }

    public fun set_global_pause_by_admin(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: bool) {
        assert_root_package_version(arg0);
        arg0.global_paused = arg2;
        let v0 = GlobalPauseUpdatedEvent{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<GlobalPauseUpdatedEvent>(v0);
    }

    public fun set_package_pause_by_admin<T0: drop>(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: bool) {
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

    public fun set_treasury_recipient_by_admin(arg0: &mut GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: address) {
        assert_root_package_version(arg0);
        assert!(arg2 != @0x0, 3410);
        arg0.treasury_recipient = arg2;
        let v0 = TreasuryRecipientUpdatedEvent{
            config_id          : 0x2::object::id<GlobalConfig>(arg0),
            treasury_recipient : arg2,
        };
        0x2::event::emit<TreasuryRecipientUpdatedEvent>(v0);
    }

    public fun system_domain() : u8 {
        1
    }

    public fun token_domain() : u8 {
        4
    }

    public fun treasury_recipient(arg0: &GlobalConfig) : address {
        arg0.treasury_recipient
    }

    // decompiled from Move bytecode v7
}

