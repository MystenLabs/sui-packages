module 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl {
    struct ACL has key {
        id: 0x2::object::UID,
        super_admin_cap_id: 0x2::object::ID,
        admins: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        super_admin_transfer: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::DelayedAction<SuperAdminTransfer, address>,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuperAdminTransfer has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (SuperAdminCap, ACL) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        let v2 = SuperAdminTransfer{dummy_field: false};
        let v3 = ACL{
            id                   : v1,
            super_admin_cap_id   : 0x2::object::uid_to_inner(&v0.id),
            admins               : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(arg0),
            super_admin_transfer : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::new<SuperAdminTransfer, address>(v2, &v1, 604800000),
        };
        (v0, v3)
    }

    public fun accept_super_admin_transfer(arg0: &mut ACL, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::pending<SuperAdminTransfer, address>(&arg0.super_admin_transfer);
        let v2 = &v1;
        let v3 = if (0x1::option::is_some<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<address>>>(v2)) {
            let v4 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::proposal_value<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<address>>(0x1::option::borrow<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Proposal<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::Change<address>>>(v2));
            0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::action<address>(&v4) == 0x1::option::some<address>(v0)
        } else {
            false
        };
        assert!(v3, 7);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::take_action<SuperAdminTransfer, address>(&mut arg0.super_admin_transfer, arg1);
        let v5 = SuperAdminCap{id: 0x2::object::new(arg2)};
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        arg0.super_admin_cap_id = v6;
        0x2::transfer::transfer<SuperAdminCap>(v5, v0);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::super_admin_transferred(arg0.super_admin_cap_id, v6, v0);
    }

    public fun admin_count(arg0: &ACL) : u64 {
        0x2::table::length<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins)
    }

    public fun admin_roles(arg0: &ACL, arg1: 0x2::object::ID) : vector<0x1::type_name::TypeName> {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg1), 1);
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(*0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg1))
    }

    fun assert_super_admin(arg0: &ACL, arg1: &SuperAdminCap) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.super_admin_cap_id, 0);
    }

    public fun begin_super_admin_transfer(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg1);
        assert!(arg2 != @0x0 && arg2 != 0x2::tx_context::sender(arg4), 6);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::schedule<SuperAdminTransfer, address>(&mut arg0.super_admin_transfer, arg2, arg3);
    }

    public fun cancel_super_admin_transfer(arg0: &mut ACL, arg1: &SuperAdminCap) {
        assert_super_admin(arg0, arg1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::cancel<SuperAdminTransfer, address>(&mut arg0.super_admin_transfer);
    }

    public fun destroy_admin_cap(arg0: &mut ACL, arg1: AdminCap) {
        let AdminCap { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, v1);
        let v3 = if (v2) {
            0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x2::table::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, v1))
        } else {
            0x1::vector::empty<0x1::type_name::TypeName>()
        };
        0x2::object::delete(v0);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::admin_destroyed(v1, v3, v2);
    }

    public fun destroy_retired_super_admin_cap(arg0: &ACL, arg1: SuperAdminCap) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v0 != arg0.super_admin_cap_id, 8);
        let SuperAdminCap { id: v1 } = arg1;
        0x2::object::delete(v1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::super_admin_cap_destroyed(v0);
    }

    public fun grant_admin(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_super_admin(arg0, arg1);
        assert!(arg2 != @0x0, 2);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, v1, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::admin_granted(v1, arg2);
    }

    public fun grant_role<T0>(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 4);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(v0) < 32, 3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(v0, v1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::admin_role_granted(arg2, v1);
    }

    public fun has_role<T0>(arg0: &ACL, arg1: 0x2::object::ID) : bool {
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg1)) {
            let v1 = 0x1::type_name::with_defining_ids<T0>();
            0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg1), &v1)
        } else {
            false
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<ACL>(v1);
        0x2::transfer::transfer<SuperAdminCap>(v0, @0x818d6d7026632f82367a9ca2413a5bb28aeec2a1b8dedca919ef812577b4d0a2);
    }

    public fun is_admin(arg0: &ACL, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg1)
    }

    public fun max_roles_per_admin() : u64 {
        32
    }

    public fun revoke_admin(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg2), 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::admin_revoked(arg2, 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x2::table::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, arg2)));
    }

    public fun revoke_role<T0>(arg0: &mut ACL, arg1: &SuperAdminCap, arg2: 0x2::object::ID) {
        assert_super_admin(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.admins, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1), 5);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v0, &v1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_admin_events::admin_role_revoked(arg2, v1);
    }

    public fun sign_in<T0>(arg0: &ACL, arg1: &AdminCap) : AdminWitness<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, v0), 1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.admins, v0), &v1), 5);
        AdminWitness<T0>{dummy_field: false}
    }

    public fun super_admin_cap_id(arg0: &ACL) : 0x2::object::ID {
        arg0.super_admin_cap_id
    }

    public fun super_admin_transfer(arg0: &ACL) : &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_action::DelayedAction<SuperAdminTransfer, address> {
        &arg0.super_admin_transfer
    }

    public fun super_admin_transfer_delay_ms() : u64 {
        604800000
    }

    // decompiled from Move bytecode v7
}

