module 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::gusd {
    struct GUSD has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminManager has store, key {
        id: 0x2::object::UID,
        access_manager: 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::AccessManager,
        deny_cap: 0x2::coin::DenyCapV2<GUSD>,
        paused: bool,
        blacklisted: 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::Set<address>,
    }

    struct PAUSE_ROLE has copy, drop, store {
        dummy_field: bool,
    }

    struct BLACKLIST_ROLE has copy, drop, store {
        dummy_field: bool,
    }

    struct UNBLACKLIST_ROLE has copy, drop, store {
        dummy_field: bool,
    }

    struct GrantRoleEvent has copy, drop, store {
        role: 0x1::type_name::TypeName,
        account: address,
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RevokeRoleEvent has copy, drop, store {
        role: 0x1::type_name::TypeName,
        account: address,
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PauseEvent has copy, drop, store {
        sender: address,
    }

    struct UnpauseEvent has copy, drop, store {
        sender: address,
    }

    struct BlacklistEvent has copy, drop, store {
        sender: address,
        account: address,
    }

    struct UnblacklistEvent has copy, drop, store {
        sender: address,
        account: address,
    }

    entry fun grant_role<T0>(arg0: &mut AdminManager, arg1: &AdminCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg1);
        verify_role_defined<T0>();
        let v0 = 0x1::option::none<0x2::object::ID>();
        if (!arg3) {
            0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::grant_role<T0>(&mut arg0.access_manager, arg2, arg4);
        } else {
            let v1 = 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::generate_role_cap<T0>(arg2, arg4);
            v0 = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap>(&v1));
            0x2::transfer::public_transfer<0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap>(v1, arg2);
        };
        let v2 = GrantRoleEvent{
            role    : 0x1::type_name::get<T0>(),
            account : arg2,
            cap_id  : v0,
        };
        0x2::event::emit<GrantRoleEvent>(v2);
    }

    entry fun revoke_role<T0>(arg0: &mut AdminManager, arg1: &AdminCap, arg2: address) {
        verify_admin(arg1);
        verify_role_defined<T0>();
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::revoke_role<T0>(&mut arg0.access_manager, arg2);
        let v0 = RevokeRoleEvent{
            role    : 0x1::type_name::get<T0>(),
            account : arg2,
            cap_id  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<RevokeRoleEvent>(v0);
    }

    entry fun revoke_role_cap<T0>(arg0: &mut AdminManager, arg1: &AdminCap, arg2: 0x2::object::ID) {
        verify_admin(arg1);
        verify_role_defined<T0>();
        let v0 = 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::revoke_role_cap(&mut arg0.access_manager, arg2);
        assert!(v0 != @0x0, 4);
        let v1 = RevokeRoleEvent{
            role    : 0x1::type_name::get<T0>(),
            account : v0,
            cap_id  : 0x1::option::some<0x2::object::ID>(arg2),
        };
        0x2::event::emit<RevokeRoleEvent>(v1);
    }

    fun verify_role<T0>(arg0: &AdminManager, arg1: address) {
        assert!(0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::verify_role<T0>(&arg0.access_manager, arg1), 2);
    }

    fun verify_role_cap<T0>(arg0: &AdminManager, arg1: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg2: address) {
        assert!(0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::verify_role_cap<T0>(&arg0.access_manager, arg1, arg2), 2);
    }

    entry fun blacklist(arg0: &mut AdminManager, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        verify_role<BLACKLIST_ROLE>(arg0, v0);
        0x2::coin::deny_list_v2_add<GUSD>(arg1, &mut arg0.deny_cap, arg2, arg3);
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::insert<address>(&mut arg0.blacklisted, arg2);
        let v1 = BlacklistEvent{
            sender  : v0,
            account : arg2,
        };
        0x2::event::emit<BlacklistEvent>(v1);
    }

    entry fun blacklist_with_cap(arg0: &mut AdminManager, arg1: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        verify_role_cap<BLACKLIST_ROLE>(arg0, arg1, v0);
        verify_role<BLACKLIST_ROLE>(arg0, v0);
        0x2::coin::deny_list_v2_add<GUSD>(arg2, &mut arg0.deny_cap, arg3, arg4);
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::insert<address>(&mut arg0.blacklisted, arg3);
        let v1 = BlacklistEvent{
            sender  : v0,
            account : arg3,
        };
        0x2::event::emit<BlacklistEvent>(v1);
    }

    entry fun has_role<T0>(arg0: &AdminManager, arg1: address) : bool {
        verify_role_defined<T0>();
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::verify_role<T0>(&arg0.access_manager, arg1)
    }

    entry fun has_role_with_cap<T0>(arg0: &AdminManager, arg1: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg2: address) : bool {
        verify_role_defined<T0>();
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::verify_role_cap<T0>(&arg0.access_manager, arg1, arg2)
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GUSD>(arg0, 6, b"GUSD", b"Gate USD", b"Gate USD", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUSD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v0, 0x2::tx_context::sender(arg1));
        let v3 = AdminManager{
            id             : 0x2::object::new(arg1),
            access_manager : 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::new(arg1),
            deny_cap       : v1,
            paused         : false,
            blacklisted    : 0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::new<address>(arg1),
        };
        0x2::transfer::public_share_object<AdminManager>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    entry fun is_blacklisted(arg0: &AdminManager, arg1: address) : bool {
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::contains<address>(&arg0.blacklisted, arg1)
    }

    entry fun is_paused(arg0: &AdminManager) : bool {
        arg0.paused
    }

    entry fun pause(arg0: &mut AdminManager, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.paused) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg2);
        verify_role<PAUSE_ROLE>(arg0, v0);
        0x2::coin::deny_list_v2_enable_global_pause<GUSD>(arg1, &mut arg0.deny_cap, arg2);
        arg0.paused = true;
        let v1 = PauseEvent{sender: v0};
        0x2::event::emit<PauseEvent>(v1);
    }

    entry fun pause_with_cap(arg0: &mut AdminManager, arg1: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg2: &mut 0x2::deny_list::DenyList, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.paused) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg3);
        verify_role_cap<PAUSE_ROLE>(arg0, arg1, v0);
        0x2::coin::deny_list_v2_enable_global_pause<GUSD>(arg2, &mut arg0.deny_cap, arg3);
        arg0.paused = true;
        let v1 = PauseEvent{sender: v0};
        0x2::event::emit<PauseEvent>(v1);
    }

    entry fun unblacklist(arg0: &mut AdminManager, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        verify_role<UNBLACKLIST_ROLE>(arg0, v0);
        0x2::coin::deny_list_v2_remove<GUSD>(arg1, &mut arg0.deny_cap, arg2, arg3);
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::remove<address>(&mut arg0.blacklisted, arg2);
        let v1 = UnblacklistEvent{
            sender  : v0,
            account : arg2,
        };
        0x2::event::emit<UnblacklistEvent>(v1);
    }

    entry fun unblacklist_with_cap(arg0: &mut AdminManager, arg1: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        verify_role_cap<UNBLACKLIST_ROLE>(arg0, arg1, v0);
        0x2::coin::deny_list_v2_remove<GUSD>(arg2, &mut arg0.deny_cap, arg3, arg4);
        0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::set::remove<address>(&mut arg0.blacklisted, arg3);
        let v1 = UnblacklistEvent{
            sender  : v0,
            account : arg3,
        };
        0x2::event::emit<UnblacklistEvent>(v1);
    }

    entry fun unpause(arg0: &mut AdminManager, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::tx_context::TxContext) {
        if (!arg0.paused) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg2);
        verify_role<PAUSE_ROLE>(arg0, v0);
        0x2::coin::deny_list_v2_disable_global_pause<GUSD>(arg1, &mut arg0.deny_cap, arg2);
        arg0.paused = false;
        let v1 = UnpauseEvent{sender: v0};
        0x2::event::emit<UnpauseEvent>(v1);
    }

    entry fun unpause_with_cap(arg0: &mut AdminManager, arg1: &mut 0x2::deny_list::DenyList, arg2: &0x637977fd87437e043542da4e4179e6aee40debb01d873ae3273d3d40f3fc4339::access_manager::RoleCap, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.paused) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg3);
        verify_role_cap<PAUSE_ROLE>(arg0, arg2, v0);
        0x2::coin::deny_list_v2_disable_global_pause<GUSD>(arg1, &mut arg0.deny_cap, arg3);
        arg0.paused = false;
        let v1 = UnpauseEvent{sender: v0};
        0x2::event::emit<UnpauseEvent>(v1);
    }

    fun verify_admin(arg0: &AdminCap) {
    }

    fun verify_paused(arg0: &AdminManager) {
        assert!(arg0.paused, 3);
    }

    fun verify_role_defined<T0>() {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (v0 == 0x1::type_name::get<PAUSE_ROLE>()) {
            true
        } else if (v0 == 0x1::type_name::get<BLACKLIST_ROLE>()) {
            true
        } else {
            v0 == 0x1::type_name::get<UNBLACKLIST_ROLE>()
        };
        assert!(v1, 1);
    }

    // decompiled from Move bytecode v6
}

