module 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        ext_versions: 0x2::vec_map::VecMap<u8, u64>,
        ext_auth_types: 0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName>,
        emergency_acl: 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::Acl,
    }

    struct LLVGlobalAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExtAuthGuard<phantom T0> has drop {
        protocol_id: u8,
    }

    public(friend) fun assert_ext_guard_protocol<T0>(arg0: &ExtAuthGuard<T0>, arg1: u8) {
        assert!(arg0.protocol_id == arg1, 16);
    }

    fun assert_ext_protocol(arg0: u8) {
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_known_protocol(arg0) && !0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_allocation_plan::is_idle_protocol(arg0), 15);
    }

    public fun assert_version(arg0: &LLVGlobal) {
        assert!(arg0.version == 1, 2);
    }

    public fun authorize_ext<T0>(arg0: &LLVGlobal, arg1: u8, arg2: u64, arg3: &T0) : ExtAuthGuard<T0> {
        assert_version(arg0);
        assert_ext_protocol(arg1);
        assert!(0x2::vec_map::contains<u8, u64>(&arg0.ext_versions, &arg1), 10);
        assert!(0x2::vec_map::contains<u8, 0x1::type_name::TypeName>(&arg0.ext_auth_types, &arg1), 10);
        assert!(*0x2::vec_map::get<u8, 0x1::type_name::TypeName>(&arg0.ext_auth_types, &arg1) == 0x1::type_name::with_defining_ids<T0>(), 17);
        assert!(*0x2::vec_map::get<u8, u64>(&arg0.ext_versions, &arg1) == arg2, 11);
        ExtAuthGuard<T0>{protocol_id: arg1}
    }

    public(friend) fun emergency_pause_global(arg0: &mut LLVGlobal, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_emergency_pauser(arg0, v0), 5);
        arg0.paused = true;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_global_paused(true);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_global_emergency_paused(v0);
    }

    public fun ext_version(arg0: &LLVGlobal, arg1: u8) : 0x1::option::Option<u64> {
        assert_version(arg0);
        assert_ext_protocol(arg1);
        if (0x2::vec_map::contains<u8, u64>(&arg0.ext_versions, &arg1)) {
            0x1::option::some<u64>(*0x2::vec_map::get<u8, u64>(&arg0.ext_versions, &arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_emergency_pausers(arg0: &LLVGlobal) : vector<address> {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::members_with_role(&arg0.emergency_acl, 1)
    }

    public(friend) fun grant_emergency_pauser(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg2 != @0x0, 9);
        assert!(!is_emergency_pauser(arg0, arg2), 6);
        assert!(0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::role_count(&arg0.emergency_acl, 1) < 10, 8);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::set_role(&mut arg0.emergency_acl, arg2, 1);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_emergency_pauser_updated(arg2, 0x2::tx_context::sender(arg3), true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LLVGlobal{
            id             : 0x2::object::new(arg0),
            version        : 1,
            paused         : false,
            ext_versions   : 0x2::vec_map::empty<u8, u64>(),
            ext_auth_types : 0x2::vec_map::empty<u8, 0x1::type_name::TypeName>(),
            emergency_acl  : 0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::empty(),
        };
        0x2::transfer::share_object<LLVGlobal>(v0);
        let v1 = LLVGlobalAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LLVGlobalAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_emergency_pauser(arg0: &LLVGlobal, arg1: address) : bool {
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::has_role(&arg0.emergency_acl, arg1, 1)
    }

    public fun is_global_paused(arg0: &LLVGlobal) : bool {
        arg0.paused
    }

    public(friend) fun migrate(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap) {
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_global_migrated(arg0.version, 1);
    }

    public fun migrate_ext_version<T0>(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap, arg2: u8, arg3: u64, arg4: &T0, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_ext_protocol(arg2);
        assert!(arg3 > 0 && arg3 < 18446744073709551615, 13);
        let v0 = if (0x2::vec_map::contains<u8, u64>(&arg0.ext_versions, &arg2)) {
            assert!(0x2::vec_map::contains<u8, 0x1::type_name::TypeName>(&arg0.ext_auth_types, &arg2), 10);
            assert!(*0x2::vec_map::get<u8, 0x1::type_name::TypeName>(&arg0.ext_auth_types, &arg2) == 0x1::type_name::with_defining_ids<T0>(), 17);
            let v1 = *0x2::vec_map::get<u8, u64>(&arg0.ext_versions, &arg2);
            assert!(arg3 > v1, 12);
            *0x2::vec_map::get_mut<u8, u64>(&mut arg0.ext_versions, &arg2) = arg3;
            v1
        } else {
            0x2::vec_map::insert<u8, u64>(&mut arg0.ext_versions, arg2, arg3);
            0x2::vec_map::insert<u8, 0x1::type_name::TypeName>(&mut arg0.ext_auth_types, arg2, 0x1::type_name::with_defining_ids<T0>());
            0
        };
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_ext_version_migrated(arg2, v0, arg3, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun revoke_emergency_pauser(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(is_emergency_pauser(arg0, arg2), 7);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_acl::remove_role(&mut arg0.emergency_acl, arg2);
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_emergency_pauser_updated(arg2, 0x2::tx_context::sender(arg3), false);
    }

    public(friend) fun set_global_paused(arg0: &mut LLVGlobal, arg1: bool, arg2: &LLVGlobalAdminCap) {
        assert_version(arg0);
        arg0.paused = arg1;
        0x1a9ebe18506edf61885c5ad3cd7d1c64160c8e2d9a324a8c66238f9ac68ab52d::llv_events::emit_global_paused(arg1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

