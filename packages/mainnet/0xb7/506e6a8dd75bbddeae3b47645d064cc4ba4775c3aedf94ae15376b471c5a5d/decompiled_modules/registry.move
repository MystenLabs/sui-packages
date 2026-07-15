module 0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::registry {
    struct AdapterRegistry has key {
        id: 0x2::object::UID,
        approved: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AdapterInfo>,
    }

    struct AdapterInfo has copy, drop, store {
        version: u64,
        enabled: bool,
    }

    struct AdapterApproved has copy, drop {
        adapter: 0x1::type_name::TypeName,
        version: u64,
    }

    struct AdapterRevoked has copy, drop {
        adapter: 0x1::type_name::TypeName,
    }

    public fun approve<T0: drop>(arg0: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::admin::AdminCap, arg1: &mut AdapterRegistry, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, AdapterInfo>(&arg1.approved, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, AdapterInfo>(&mut arg1.approved, &v0);
            v1.version = arg2;
            v1.enabled = true;
        } else {
            let v2 = AdapterInfo{
                version : arg2,
                enabled : true,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, AdapterInfo>(&mut arg1.approved, v0, v2);
        };
        let v3 = AdapterApproved{
            adapter : v0,
            version : arg2,
        };
        0x2::event::emit<AdapterApproved>(v3);
    }

    public fun assert_approved<T0: drop>(arg0: &AdapterRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, AdapterInfo>(&arg0.approved, &v0), 0);
        assert!(0x2::vec_map::get<0x1::type_name::TypeName, AdapterInfo>(&arg0.approved, &v0).enabled, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdapterRegistry{
            id       : 0x2::object::new(arg0),
            approved : 0x2::vec_map::empty<0x1::type_name::TypeName, AdapterInfo>(),
        };
        0x2::transfer::share_object<AdapterRegistry>(v0);
    }

    public fun revoke<T0: drop>(arg0: &0xb7506e6a8dd75bbddeae3b47645d064cc4ba4775c3aedf94ae15376b471c5a5d::admin::AdminCap, arg1: &mut AdapterRegistry) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, AdapterInfo>(&arg1.approved, &v0)) {
            0x2::vec_map::get_mut<0x1::type_name::TypeName, AdapterInfo>(&mut arg1.approved, &v0).enabled = false;
            let v1 = AdapterRevoked{adapter: v0};
            0x2::event::emit<AdapterRevoked>(v1);
        };
    }

    public fun version_of<T0: drop>(arg0: &AdapterRegistry) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::get<0x1::type_name::TypeName, AdapterInfo>(&arg0.approved, &v0).version
    }

    // decompiled from Move bytecode v7
}

