module 0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_acl {
    struct ACL has key {
        id: 0x2::object::UID,
        super_admin_cap_id: 0x2::object::ID,
        admins: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        pending_super_admin: 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<0x1::option::Option<address>>,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (SuperAdminCap, ACL) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        let v1 = ACL{
            id                  : 0x2::object::new(arg0),
            super_admin_cap_id  : 0x2::object::uid_to_inner(&v0.id),
            admins              : 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            pending_super_admin : no_pending_super_admin(),
        };
        (v0, v1)
    }

    public fun accept_super_admin_transfer(arg0: &mut ACL, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        assert!(0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&arg0.pending_super_admin) == v0, 10);
        assert!(0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::value<0x1::option::Option<address>>(&arg0.pending_super_admin, arg1) == v0, 11);
        let v1 = SuperAdminCap{id: 0x2::object::new(arg2)};
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        arg0.super_admin_cap_id = v2;
        arg0.pending_super_admin = no_pending_super_admin();
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg2));
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::super_admin_transferred(arg0.super_admin_cap_id, v2, 0x2::tx_context::sender(arg2));
    }

    fun assert_super_admin(arg0: &ACL, arg1: &SuperAdminCap) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.super_admin_cap_id, 0);
    }

    public fun begin_super_admin_transfer(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg1);
        assert!(arg2 != @0x0 && arg2 != 0x2::tx_context::sender(arg4), 7);
        let v0 = arg0.pending_super_admin;
        assert!(0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&v0) != 0x1::option::some<address>(arg2), 8);
        let v1 = no_pending_super_admin();
        0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::schedule<0x1::option::Option<address>>(&mut v1, 0x1::option::some<address>(arg2), arg3);
        arg0.pending_super_admin = v1;
        let v2 = 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&v0);
        if (0x1::option::is_some<address>(&v2)) {
            0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::super_admin_transfer_cancelled(0x1::option::destroy_some<address>(0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&v0)), 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled_at_ms<0x1::option::Option<address>>(&v0));
        };
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::super_admin_transfer_started(arg2, 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled_at_ms<0x1::option::Option<address>>(&v1));
    }

    public fun cancel_super_admin_transfer(arg0: &mut ACL, arg1: &SuperAdminCap) {
        assert_super_admin(arg0, arg1);
        let v0 = arg0.pending_super_admin;
        let v1 = 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&v0);
        assert!(0x1::option::is_some<address>(&v1), 9);
        arg0.pending_super_admin = no_pending_super_admin();
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::super_admin_transfer_cancelled(0x1::option::destroy_some<address>(0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled<0x1::option::Option<address>>(&v0)), 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::scheduled_at_ms<0x1::option::Option<address>>(&v0));
    }

    public fun destroy_admin_cap(arg0: &mut ACL, arg1: AdminCap) {
        let AdminCap { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &v1);
        let v3 = if (v2) {
            let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, &v1);
            0x2::vec_set::into_keys<0x1::type_name::TypeName>(v5)
        } else {
            0x1::vector::empty<0x1::type_name::TypeName>()
        };
        0x2::object::delete(v0);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::admin_destroyed(v1, v3, v2);
    }

    public fun destroy_retired_super_admin_cap(arg0: &ACL, arg1: SuperAdminCap) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v0 != arg0.super_admin_cap_id, 12);
        let SuperAdminCap { id: v1 } = arg1;
        0x2::object::delete(v1);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::super_admin_cap_destroyed(v0);
    }

    public fun grant_admin(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg1);
        assert!(arg2 != @0x0, 2);
        assert!(0x2::vec_map::length<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins) < 32, 3);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, v1, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::admin_granted(v1, arg2);
    }

    public fun grant_role<T0>(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &arg2), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, &arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 5);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(v0) < 32, 4);
        0x2::vec_set::insert<0x1::type_name::TypeName>(v0, v1);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::admin_role_granted(arg2, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<ACL>(v1);
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun no_pending_super_admin() : 0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::Timelocked<0x1::option::Option<address>> {
        0x1749b76a3ae065dedfe847578b07826fa83d1e18ff485d9e4f9647f3698e104d::blast_fun_timelock::new<0x1::option::Option<address>>(0x1::option::none<address>(), 604800000)
    }

    public fun revoke_admin(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &arg2), 1);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, &arg2);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::admin_revoked(arg2, 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v1));
    }

    public fun revoke_role<T0>(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &arg2), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, &arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 6);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v0, &v1);
        0xdebad36861e0f1390eeb549fd100b1783a3331e88f4785cec703387494e6b612::blast_admin_events::admin_role_revoked(arg2, v1);
    }

    public fun sign_in<T0>(arg0: &ACL, arg1: &AdminCap) : AdminWitness<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &v0), 1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, &v0), &v1), 6);
        AdminWitness<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

