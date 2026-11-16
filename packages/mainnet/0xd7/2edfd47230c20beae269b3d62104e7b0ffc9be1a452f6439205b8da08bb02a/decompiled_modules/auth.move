module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth {
    struct AdminProposerRole has drop, store {
        dummy_field: bool,
    }

    struct AuthProposerRole has drop, store {
        dummy_field: bool,
    }

    struct AdminCancellerRole has drop, store {
        dummy_field: bool,
    }

    struct AuthCancellerRole has drop, store {
        dummy_field: bool,
    }

    struct ExecutorRole has drop, store {
        dummy_field: bool,
    }

    struct TimelockAdminRole has drop, store {
        dummy_field: bool,
    }

    struct GuardianRole has drop, store {
        dummy_field: bool,
    }

    struct MigrateRole has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct PendingGuardianRemoval has copy, drop, store {
        pos0: address,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    struct Auth has key {
        id: 0x2::object::UID,
        roles: 0x2::bag::Bag,
        holder_counts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        roles_finalized: bool,
        setup_complete: bool,
    }

    public(friend) fun add_pending_guardian_removal(arg0: &mut Auth, arg1: address) {
        if (!has_pending_guardian_removal(arg0, arg1)) {
            let v0 = PendingGuardianRemoval{pos0: arg1};
            0x2::dynamic_field::add<PendingGuardianRemoval, bool>(&mut arg0.id, v0, true);
        };
    }

    fun assert_has_holder<T0>(arg0: &Auth) {
        assert!(holder_count<T0>(arg0) > 0, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::role_without_holder());
    }

    public(friend) fun assert_has_role<T0>(arg0: &Auth, arg1: address) {
        assert!(has_role<T0>(arg0, arg1), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::unauthorized());
    }

    public(friend) fun assert_is_role<T0>() {
        assert!(is_role<T0>(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::invalid_role());
    }

    public(friend) fun assert_roles_finalized(arg0: &Auth) {
        assert!(arg0.roles_finalized, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::roles_not_finalized());
    }

    public(friend) fun assert_roles_not_finalized(arg0: &Auth) {
        assert!(!arg0.roles_finalized, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::roles_finalized());
    }

    public(friend) fun complete_setup(arg0: &mut Auth, arg1: SetupCap) {
        assert_roles_finalized(arg0);
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        arg0.setup_complete = true;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_setup_complete();
    }

    public(friend) fun finalize_roles(arg0: &mut Auth) {
        assert_roles_not_finalized(arg0);
        assert_has_holder<AdminProposerRole>(arg0);
        assert_has_holder<AuthProposerRole>(arg0);
        assert_has_holder<AdminCancellerRole>(arg0);
        assert_has_holder<AuthCancellerRole>(arg0);
        assert_has_holder<ExecutorRole>(arg0);
        assert_has_holder<TimelockAdminRole>(arg0);
        assert_has_holder<GuardianRole>(arg0);
        assert_has_holder<MigrateRole>(arg0);
        arg0.roles_finalized = true;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_roles_finalized();
    }

    public(friend) fun grant_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        assert!(arg1 != @0x0, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::address_zero_not_allowed());
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(!0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::role_already_assigned());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (v1 == 0x1::type_name::with_defining_ids<AdminProposerRole>()) {
            let v2 = RoleKey<T0>{owner: arg1};
            let v3 = AdminProposerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AdminProposerRole>(&mut arg0.roles, v2, v3);
        } else if (v1 == 0x1::type_name::with_defining_ids<AuthProposerRole>()) {
            let v4 = RoleKey<T0>{owner: arg1};
            let v5 = AuthProposerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AuthProposerRole>(&mut arg0.roles, v4, v5);
        } else if (v1 == 0x1::type_name::with_defining_ids<AdminCancellerRole>()) {
            let v6 = RoleKey<T0>{owner: arg1};
            let v7 = AdminCancellerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AdminCancellerRole>(&mut arg0.roles, v6, v7);
        } else if (v1 == 0x1::type_name::with_defining_ids<AuthCancellerRole>()) {
            let v8 = RoleKey<T0>{owner: arg1};
            let v9 = AuthCancellerRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, AuthCancellerRole>(&mut arg0.roles, v8, v9);
        } else if (v1 == 0x1::type_name::with_defining_ids<ExecutorRole>()) {
            let v10 = RoleKey<T0>{owner: arg1};
            let v11 = ExecutorRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, ExecutorRole>(&mut arg0.roles, v10, v11);
        } else if (v1 == 0x1::type_name::with_defining_ids<TimelockAdminRole>()) {
            let v12 = RoleKey<T0>{owner: arg1};
            let v13 = TimelockAdminRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, TimelockAdminRole>(&mut arg0.roles, v12, v13);
        } else if (v1 == 0x1::type_name::with_defining_ids<GuardianRole>()) {
            let v14 = RoleKey<T0>{owner: arg1};
            let v15 = GuardianRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, GuardianRole>(&mut arg0.roles, v14, v15);
        } else {
            assert!(v1 == 0x1::type_name::with_defining_ids<MigrateRole>(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::invalid_role());
            let v16 = RoleKey<T0>{owner: arg1};
            let v17 = MigrateRole{dummy_field: false};
            0x2::bag::add<RoleKey<T0>, MigrateRole>(&mut arg0.roles, v16, v17);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.holder_counts, &v1)) {
            let v18 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.holder_counts, &v1);
            *v18 = *v18 + 1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.holder_counts, v1, 1);
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_role_granted(v1, arg1);
    }

    public fun has_pending_guardian_removal(arg0: &Auth, arg1: address) : bool {
        let v0 = PendingGuardianRemoval{pos0: arg1};
        0x2::dynamic_field::exists<PendingGuardianRemoval>(&arg0.id, v0)
    }

    public fun has_role<T0>(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0)
    }

    public fun holder_count<T0>(arg0: &Auth) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.holder_counts, &v0)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.holder_counts, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Auth{
            id              : 0x2::object::new(arg0),
            roles           : 0x2::bag::new(arg0),
            holder_counts   : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            roles_finalized : false,
            setup_complete  : false,
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = &mut v0;
        grant_role<AdminProposerRole>(v2, v1);
        let v3 = &mut v0;
        grant_role<AuthProposerRole>(v3, v1);
        let v4 = &mut v0;
        grant_role<AdminCancellerRole>(v4, v1);
        let v5 = &mut v0;
        grant_role<AuthCancellerRole>(v5, v1);
        let v6 = &mut v0;
        grant_role<ExecutorRole>(v6, v1);
        let v7 = &mut v0;
        grant_role<TimelockAdminRole>(v7, v1);
        let v8 = &mut v0;
        grant_role<GuardianRole>(v8, v1);
        let v9 = &mut v0;
        grant_role<MigrateRole>(v9, v1);
        0x2::transfer::share_object<Auth>(v0);
        let v10 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v10, v1);
    }

    public fun is_role<T0>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<AdminProposerRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<AuthProposerRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<AdminCancellerRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<AuthCancellerRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<ExecutorRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<TimelockAdminRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<GuardianRole>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::with_defining_ids<MigrateRole>());
        0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v0)
    }

    fun remove_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        let v0 = RoleKey<T0>{owner: arg1};
        assert!(0x2::bag::contains<RoleKey<T0>>(&arg0.roles, v0), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::role_not_assigned());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.holder_counts, &v1);
        *v2 = *v2 - 1;
        let v3 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut arg0.roles, v3);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_role_revoked(v1, arg1);
    }

    public(friend) fun revoke_guardian_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        remove_role<T0>(arg0, arg1);
    }

    public(friend) fun revoke_role<T0: drop + store>(arg0: &mut Auth, arg1: address) {
        assert!(holder_count<T0>(arg0) > 1 || 0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<GuardianRole>(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::last_holder_not_removable());
        remove_role<T0>(arg0, arg1);
    }

    public fun roles_finalized(arg0: &Auth) : bool {
        arg0.roles_finalized
    }

    public fun setup_complete(arg0: &Auth) : bool {
        arg0.setup_complete
    }

    public(friend) fun take_pending_guardian_removal(arg0: &mut Auth, arg1: address) {
        assert!(has_pending_guardian_removal(arg0, arg1), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::no_pending_guardian_removal());
        let v0 = PendingGuardianRemoval{pos0: arg1};
        0x2::dynamic_field::remove<PendingGuardianRemoval, bool>(&mut arg0.id, v0);
    }

    // decompiled from Move bytecode v7
}

