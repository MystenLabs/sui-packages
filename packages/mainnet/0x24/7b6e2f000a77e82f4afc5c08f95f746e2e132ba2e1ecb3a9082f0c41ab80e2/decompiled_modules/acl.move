module 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::acl {
    struct PendingSuperAdminTransfer has drop, store {
        recipient: address,
        execute_after_ms: u64,
    }

    struct Authority<phantom T0: drop> has key {
        id: 0x2::object::UID,
        super_admin_cap_id: 0x2::object::ID,
        admins: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        max_admins: u64,
        root_transfer_delay_ms: u64,
        pending_super_admin: 0x1::option::Option<PendingSuperAdminTransfer>,
    }

    struct SuperAdminCap<phantom T0: drop> has key {
        id: 0x2::object::UID,
    }

    struct AdminCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct AdminWitness<phantom T0: drop> has drop {
        pos0: u64,
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        assert!(arg1 > 0, 1);
        assert!(arg2 > 0, 2);
        let (v0, v1) = new_objects<T0>(arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::share_object<Authority<T0>>(v2);
        0x2::transfer::transfer<SuperAdminCap<T0>>(v3, v4);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::authority_created<T0>(0x2::object::uid_to_inner(&v2.id), 0x2::object::uid_to_inner(&v3.id), v4, arg1, arg2);
    }

    public fun accept_super_admin_transfer<T0: drop>(arg0: &mut Authority<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingSuperAdminTransfer>(&arg0.pending_super_admin), 13);
        let v0 = 0x1::option::borrow<PendingSuperAdminTransfer>(&arg0.pending_super_admin);
        assert!(v0.recipient == 0x2::tx_context::sender(arg2), 14);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.execute_after_ms, 15);
        let v1 = v0.recipient;
        let v2 = SuperAdminCap<T0>{id: 0x2::object::new(arg2)};
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x1::option::extract<PendingSuperAdminTransfer>(&mut arg0.pending_super_admin);
        arg0.super_admin_cap_id = v3;
        0x2::transfer::transfer<SuperAdminCap<T0>>(v2, v1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::super_admin_transferred<T0>(0x2::object::uid_to_inner(&arg0.id), arg0.super_admin_cap_id, v3, v1);
    }

    public fun assert_role<T0: drop>(arg0: &AdminWitness<T0>, arg1: u64) {
        assert_valid_role(arg1);
        assert!(has_role(arg0.pos0, arg1), 9);
    }

    fun assert_super_admin<T0: drop>(arg0: &Authority<T0>, arg1: &SuperAdminCap<T0>) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.super_admin_cap_id, 3);
    }

    fun assert_valid_role(arg0: u64) {
        assert!(arg0 != 0 && arg0 & arg0 - 1 == 0, 7);
    }

    public fun begin_super_admin_transfer<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_super_admin<T0>(arg0, arg1);
        assert!(arg2 != @0x0 && arg2 != 0x2::tx_context::sender(arg4), 10);
        if (0x1::option::is_some<PendingSuperAdminTransfer>(&arg0.pending_super_admin)) {
            assert!(0x1::option::borrow<PendingSuperAdminTransfer>(&arg0.pending_super_admin).recipient != arg2, 11);
        };
        let v0 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg3), arg0.root_transfer_delay_ms);
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            let v2 = if (0x1::option::is_some<PendingSuperAdminTransfer>(&arg0.pending_super_admin)) {
                0x1::option::some<PendingSuperAdminTransfer>(0x1::option::extract<PendingSuperAdminTransfer>(&mut arg0.pending_super_admin))
            } else {
                0x1::option::none<PendingSuperAdminTransfer>()
            };
            let v3 = v2;
            let v4 = PendingSuperAdminTransfer{
                recipient        : arg2,
                execute_after_ms : v1,
            };
            arg0.pending_super_admin = 0x1::option::some<PendingSuperAdminTransfer>(v4);
            if (0x1::option::is_some<PendingSuperAdminTransfer>(&v3)) {
                let v5 = 0x1::option::extract<PendingSuperAdminTransfer>(&mut v3);
                0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::super_admin_transfer_cancelled<T0>(0x2::object::uid_to_inner(&arg0.id), v5.recipient, v5.execute_after_ms);
            };
            0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::super_admin_transfer_started<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, v1);
            return
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 12
        };
    }

    public fun cancel_super_admin_transfer<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>) {
        assert_super_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_some<PendingSuperAdminTransfer>(&arg0.pending_super_admin), 13);
        let v0 = 0x1::option::extract<PendingSuperAdminTransfer>(&mut arg0.pending_super_admin);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::super_admin_transfer_cancelled<T0>(0x2::object::uid_to_inner(&arg0.id), v0.recipient, v0.execute_after_ms);
    }

    public fun destroy_admin_cap<T0: drop>(arg0: &mut Authority<T0>, arg1: AdminCap<T0>) {
        let AdminCap { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.admins, &v1);
        let v3 = if (v2) {
            let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.admins, &v1);
            v5
        } else {
            0
        };
        0x2::object::delete(v0);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::admin_destroyed<T0>(0x2::object::uid_to_inner(&arg0.id), v1, v3, v2);
    }

    public fun destroy_retired_super_admin_cap<T0: drop>(arg0: &Authority<T0>, arg1: SuperAdminCap<T0>) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v0 != arg0.super_admin_cap_id, 16);
        let SuperAdminCap { id: v1 } = arg1;
        0x2::object::delete(v1);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::super_admin_cap_destroyed<T0>(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public fun grant_admin<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_super_admin<T0>(arg0, arg1);
        assert!(arg3 != @0x0, 5);
        assert!(0x2::vec_map::length<0x2::object::ID, u64>(&arg0.admins) < arg0.max_admins, 6);
        let v0 = AdminCap<T0>{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.admins, v1, arg2);
        0x2::transfer::public_transfer<AdminCap<T0>>(v0, arg3);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::admin_granted<T0>(0x2::object::uid_to_inner(&arg0.id), v1, arg2, arg3);
    }

    public fun grant_role<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>, arg2: 0x2::object::ID, arg3: u64) {
        assert_super_admin<T0>(arg0, arg1);
        assert_valid_role(arg3);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.admins, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.admins, &arg2);
        let v1 = *v0;
        assert!(!has_role(v1, arg3), 8);
        let v2 = v1 | arg3;
        *v0 = v2;
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::admin_role_granted<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, v1, v2);
    }

    fun has_role(arg0: u64, arg1: u64) : bool {
        arg0 & arg1 != 0
    }

    fun new_objects<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (SuperAdminCap<T0>, Authority<T0>) {
        let v0 = SuperAdminCap<T0>{id: 0x2::object::new(arg2)};
        let v1 = Authority<T0>{
            id                     : 0x2::object::new(arg2),
            super_admin_cap_id     : 0x2::object::uid_to_inner(&v0.id),
            admins                 : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            max_admins             : arg0,
            root_transfer_delay_ms : arg1,
            pending_super_admin    : 0x1::option::none<PendingSuperAdminTransfer>(),
        };
        (v0, v1)
    }

    public fun revoke_admin<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>, arg2: 0x2::object::ID) {
        assert_super_admin<T0>(arg0, arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.admins, &arg2), 4);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, u64>(&mut arg0.admins, &arg2);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::admin_revoked<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, v1);
    }

    public fun revoke_role<T0: drop>(arg0: &mut Authority<T0>, arg1: &SuperAdminCap<T0>, arg2: 0x2::object::ID, arg3: u64) {
        assert_super_admin<T0>(arg0, arg1);
        assert_valid_role(arg3);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.admins, &arg2), 4);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.admins, &arg2);
        let v1 = *v0;
        assert!(has_role(v1, arg3), 9);
        let v2 = v1 & 0x1::u64::bitwise_not(arg3);
        *v0 = v2;
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::admin_role_revoked<T0>(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, v1, v2);
    }

    public fun sign_in<T0: drop>(arg0: &Authority<T0>, arg1: &AdminCap<T0>) : AdminWitness<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.admins, &v0), 4);
        AdminWitness<T0>{pos0: *0x2::vec_map::get<0x2::object::ID, u64>(&arg0.admins, &v0)}
    }

    // decompiled from Move bytecode v7
}

