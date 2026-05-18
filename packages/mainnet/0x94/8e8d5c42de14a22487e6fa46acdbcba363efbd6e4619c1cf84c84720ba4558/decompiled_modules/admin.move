module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::admin {
    struct AdminGranted has copy, drop {
        form_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        grantee: address,
        granted_by: address,
    }

    struct AdminRevoked has copy, drop {
        form_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        grantee: address,
        revoked_by: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        grantee: address,
        granted_by: address,
        granted_at: u64,
    }

    public fun form_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.form_id
    }

    entry fun grant_admin(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = AdminCap{
            id         : 0x2::object::new(arg3),
            form_id    : v0,
            grantee    : arg2,
            granted_by : v1,
            granted_at : 0x2::tx_context::epoch(arg3),
        };
        let v3 = AdminGranted{
            form_id      : v0,
            admin_cap_id : 0x2::object::uid_to_inner(&v2.id),
            grantee      : arg2,
            granted_by   : v1,
        };
        0x2::event::emit<AdminGranted>(v3);
        0x2::transfer::public_transfer<AdminCap>(v2, arg2);
    }

    public fun granted_at(arg0: &AdminCap) : u64 {
        arg0.granted_at
    }

    public fun granted_by(arg0: &AdminCap) : address {
        arg0.granted_by
    }

    public fun grantee(arg0: &AdminCap) : address {
        arg0.grantee
    }

    entry fun revoke_admin(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 6);
        let AdminCap {
            id         : v0,
            form_id    : _,
            grantee    : _,
            granted_by : _,
            granted_at : _,
        } = arg1;
        0x2::object::delete(v0);
        let v5 = AdminRevoked{
            form_id      : arg1.form_id,
            admin_cap_id : 0x2::object::uid_to_inner(&arg1.id),
            grantee      : arg1.grantee,
            revoked_by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminRevoked>(v5);
    }

    // decompiled from Move bytecode v6
}

