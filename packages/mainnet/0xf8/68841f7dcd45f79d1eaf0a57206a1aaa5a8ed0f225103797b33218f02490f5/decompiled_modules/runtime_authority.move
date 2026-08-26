module 0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority {
    struct RuntimeAuthority has key {
        id: 0x2::object::UID,
        scheduler_upgrade_cap: 0x1::option::Option<0x2::object::ID>,
        current_runtime: 0x1::option::Option<0x1::type_name::TypeName>,
        current_runtime_package: 0x1::option::Option<0x2::object::ID>,
        paused: bool,
    }

    struct RuntimeAuthorityCap has store, key {
        id: 0x2::object::UID,
        authority_id: 0x2::object::ID,
    }

    struct RuntimePermit<phantom T0> has drop {
        authority_id: 0x2::object::ID,
    }

    struct WorkAdmissionDisabled<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (RuntimeAuthority, RuntimeAuthorityCap) {
        let v0 = RuntimeAuthority{
            id                      : 0x2::object::new(arg0),
            scheduler_upgrade_cap   : 0x1::option::none<0x2::object::ID>(),
            current_runtime         : 0x1::option::none<0x1::type_name::TypeName>(),
            current_runtime_package : 0x1::option::none<0x2::object::ID>(),
            paused                  : false,
        };
        let v1 = RuntimeAuthorityCap{
            id           : 0x2::object::new(arg0),
            authority_id : 0x2::object::id<RuntimeAuthority>(&v0),
        };
        (v0, v1)
    }

    fun assert_authority_cap(arg0: &RuntimeAuthority, arg1: &RuntimeAuthorityCap) {
        assert!(arg1.authority_id == 0x2::object::id<RuntimeAuthority>(arg0), 13906835110646251521);
    }

    fun assert_target_package<T0>(arg0: &0x2::package::UpgradeCap) {
        let v0 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::defining_id<T0>(), 13906835136416579593);
    }

    public fun authorize<T0: drop>(arg0: &RuntimeAuthority, arg1: T0) : RuntimePermit<T0> {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.current_runtime), 13906834848653508613);
        assert!(!arg0.paused, 13906834852949000205);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::contains<0x1::type_name::TypeName>(&arg0.current_runtime, &v0), 13906834865834033167);
        RuntimePermit<T0>{authority_id: 0x2::object::id<RuntimeAuthority>(arg0)}
    }

    public fun bind_runtime<T0: drop>(arg0: &mut RuntimeAuthority, arg1: &RuntimeAuthorityCap, arg2: &0x2::package::UpgradeCap, arg3: T0) {
        assert_authority_cap(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.scheduler_upgrade_cap), 13906834676854685699);
        assert_target_package<T0>(arg2);
        0x1::option::fill<0x2::object::ID>(&mut arg0.scheduler_upgrade_cap, 0x2::object::id<0x2::package::UpgradeCap>(arg2));
        set_runtime<T0>(arg0, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::public_transfer<RuntimeAuthorityCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<RuntimeAuthority>(v0);
    }

    public fun is_paused(arg0: &RuntimeAuthority) : bool {
        arg0.paused
    }

    public fun is_work_admission_disabled<T0>(arg0: &RuntimeAuthority) : bool {
        let v0 = WorkAdmissionDisabled<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<WorkAdmissionDisabled<T0>, bool>(&arg0.id, v0)
    }

    public fun pause(arg0: &mut RuntimeAuthority, arg1: &RuntimeAuthorityCap) {
        assert_authority_cap(arg0, arg1);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.current_runtime), 13906834809998802949);
        arg0.paused = true;
    }

    public fun permit_authority<T0>(arg0: &RuntimePermit<T0>) : 0x2::object::ID {
        arg0.authority_id
    }

    public fun rotate_runtime<T0: drop>(arg0: &mut RuntimeAuthority, arg1: &0x2::package::UpgradeCap, arg2: T0) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.scheduler_upgrade_cap), 13906834745574293509);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.scheduler_upgrade_cap, &v0), 13906834749869391879);
        assert_target_package<T0>(arg1);
        let v1 = 0x2::object::id_from_address(0x1::type_name::defining_id<T0>());
        assert!(!0x1::option::contains<0x2::object::ID>(&arg0.current_runtime_package, &v1), 13906834767049523211);
        set_runtime<T0>(arg0, arg2);
    }

    public fun runtime_package(arg0: &RuntimeAuthority) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_runtime_package
    }

    public fun runtime_type(arg0: &RuntimeAuthority) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.current_runtime
    }

    fun set_runtime<T0: drop>(arg0: &mut RuntimeAuthority, arg1: T0) {
        arg0.current_runtime = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
        arg0.current_runtime_package = 0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::type_name::defining_id<T0>()));
        arg0.paused = false;
    }

    public fun set_work_admission_disabled<T0>(arg0: &mut RuntimeAuthority, arg1: &RuntimeAuthorityCap, arg2: bool) {
        assert_authority_cap(arg0, arg1);
        let v0 = WorkAdmissionDisabled<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::exists_with_type<WorkAdmissionDisabled<T0>, bool>(&arg0.id, v0);
        if (arg2 && !v1) {
            0x2::dynamic_field::add<WorkAdmissionDisabled<T0>, bool>(&mut arg0.id, v0, true);
        } else if (!arg2 && v1) {
            0x2::dynamic_field::remove<WorkAdmissionDisabled<T0>, bool>(&mut arg0.id, v0);
        };
    }

    // decompiled from Move bytecode v7
}

