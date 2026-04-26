module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant {
    struct SoulGrant has store, key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        grantee: address,
        issued_by: address,
        ownership_epoch_snapshot: u64,
        scope_mask: u64,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct SoulGrantIssued has copy, drop {
        grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        issued_by: address,
        grantee: address,
        scope_mask: u64,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct SoulGrantRevoked has copy, drop {
        grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        revoked_by: address,
        grantee: address,
    }

    struct SoulGrantSuperseded has copy, drop {
        old_grant_id: 0x2::object::ID,
        new_grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        grantee: address,
        superseded_by: address,
    }

    struct SoulGrantExpired has copy, drop {
        grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        grantee: address,
    }

    struct SoulGrantInvalidated has copy, drop {
        grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        grantee: address,
        invalidated_by: address,
        new_owner: address,
    }

    struct GrantCapacityUpdated has copy, drop {
        soul_id: 0x2::object::ID,
        old_capacity: u64,
        new_capacity: u64,
    }

    struct SoulGrantDestroyed has copy, drop {
        grant_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        grantee: address,
        destroyed_by: address,
    }

    public(friend) fun all_scopes() : u64 {
        1 | 2 | 4 | 8
    }

    public fun assert_active_with_scope(arg0: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: &SoulGrant, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0), 2);
        assert!(arg1.grantee == 0x2::tx_context::sender(arg4), 5);
        assert!(arg1.ownership_epoch_snapshot == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg0), 3);
        assert!(arg2 != 0, 10);
        if (0x1::option::is_some<u64>(&arg1.expires_at_ms)) {
            assert!(0x2::clock::timestamp_ms(arg3) <= *0x1::option::borrow<u64>(&arg1.expires_at_ms), 6);
        };
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_index_by_id(arg0, 0x2::object::id<SoulGrant>(arg1));
        assert!(0x1::option::is_some<u64>(&v0), 4);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_at(arg0, 0x1::option::extract<u64>(&mut v0));
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grantee(v1) == arg1.grantee, 11);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_scope_mask(v1) == arg1.scope_mask, 11);
        assert!(has_required_scope(arg1.scope_mask, arg2), 7);
    }

    public(friend) fun assert_valid_scope_mask(arg0: u64) {
        assert!(arg0 != 0, 10);
        assert!(arg0 & all_scopes() == arg0, 13);
    }

    public fun cleanup_expired(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: &0x2::clock::Clock) {
        cleanup_expired_impl(arg0, arg1);
    }

    fun cleanup_expired_impl(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_count(arg0)) {
            let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_at(arg0, v0);
            if (0x1::option::is_some<u64>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_expires_at_ms(v1)) && 0x2::clock::timestamp_ms(arg1) > *0x1::option::borrow<u64>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_expires_at_ms(v1))) {
                let v2 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::remove_active_grant_at(arg0, v0);
                let v3 = SoulGrantExpired{
                    grant_id : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grant_id(&v2),
                    soul_id  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
                    grantee  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grantee(&v2),
                };
                0x2::event::emit<SoulGrantExpired>(v3);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public fun destroy_invalidated_grant(arg0: SoulGrant, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 2);
        let v0 = 0x2::object::id<SoulGrant>(&arg0);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_index_by_id(arg1, v0);
        let v2 = 0x1::option::is_some<u64>(&arg0.expires_at_ms) && 0x2::clock::timestamp_ms(arg2) > *0x1::option::borrow<u64>(&arg0.expires_at_ms);
        let v3 = if (arg0.ownership_epoch_snapshot != 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg1)) {
            true
        } else if (0x1::option::is_none<u64>(&v1)) {
            true
        } else {
            v2
        };
        assert!(v3, 16);
        let SoulGrant {
            id                       : v4,
            soul_id                  : v5,
            grantee                  : v6,
            issued_by                : _,
            ownership_epoch_snapshot : _,
            scope_mask               : _,
            expires_at_ms            : _,
        } = arg0;
        0x2::object::delete(v4);
        let v11 = SoulGrantDestroyed{
            grant_id     : v0,
            soul_id      : v5,
            grantee      : v6,
            destroyed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SoulGrantDestroyed>(v11);
    }

    public fun expires_at_ms(arg0: &SoulGrant) : &0x1::option::Option<u64> {
        &arg0.expires_at_ms
    }

    public fun grantee(arg0: &SoulGrant) : address {
        arg0.grantee
    }

    fun has_required_scope(arg0: u64, arg1: u64) : bool {
        arg0 & arg1 == arg1
    }

    public fun has_scope(arg0: &SoulGrant, arg1: u64) : bool {
        has_required_scope(arg0.scope_mask, arg1)
    }

    public(friend) fun invalidate_all_for_owner_rotation(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: address, arg2: address) {
        while (0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_count(arg0) > 0) {
            let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::remove_active_grant_at(arg0, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_count(arg0) - 1);
            let v1 = SoulGrantInvalidated{
                grant_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grant_id(&v0),
                soul_id        : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
                grantee        : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grantee(&v0),
                invalidated_by : arg2,
                new_owner      : arg1,
            };
            0x2::event::emit<SoulGrantInvalidated>(v1);
        };
    }

    public fun issue(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : SoulGrant {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1 != @0x0, 1);
        assert!(arg1 != 0x2::tx_context::sender(arg5), 1);
        assert_valid_scope_mask(arg2);
        cleanup_expired_impl(arg0, arg4);
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_index_by_grantee(arg0, arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ActiveGrantSlot>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::remove_active_grant_at(arg0, 0x1::option::extract<u64>(&mut v0)))
        } else {
            assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_count(arg0) < 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::grant_capacity(arg0), 8);
            0x1::option::none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ActiveGrantSlot>()
        };
        let v2 = v1;
        let v3 = SoulGrant{
            id                       : 0x2::object::new(arg5),
            soul_id                  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            grantee                  : arg1,
            issued_by                : 0x2::tx_context::sender(arg5),
            ownership_epoch_snapshot : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg0),
            scope_mask               : arg2,
            expires_at_ms            : arg3,
        };
        let v4 = 0x2::object::id<SoulGrant>(&v3);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::push_active_grant(arg0, v4, arg1, arg2, arg3);
        if (0x1::option::is_some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ActiveGrantSlot>(&v2)) {
            let v5 = 0x1::option::extract<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ActiveGrantSlot>(&mut v2);
            let v6 = SoulGrantSuperseded{
                old_grant_id  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grant_id(&v5),
                new_grant_id  : v4,
                soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
                grantee       : arg1,
                superseded_by : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<SoulGrantSuperseded>(v6);
        };
        let v7 = SoulGrantIssued{
            grant_id      : v4,
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            issued_by     : 0x2::tx_context::sender(arg5),
            grantee       : arg1,
            scope_mask    : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<SoulGrantIssued>(v7);
        v3
    }

    public fun issued_by(arg0: &SoulGrant) : address {
        arg0.issued_by
    }

    public fun revoke(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        cleanup_expired_impl(arg0, arg2);
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_index_by_grantee(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 9);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::remove_active_grant_at(arg0, 0x1::option::extract<u64>(&mut v0));
        let v2 = SoulGrantRevoked{
            grant_id   : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grant_id(&v1),
            soul_id    : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            revoked_by : 0x2::tx_context::sender(arg3),
            grantee    : arg1,
        };
        0x2::event::emit<SoulGrantRevoked>(v2);
    }

    public fun revoke_scope(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SoulGrant {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_valid_scope_mask(arg2);
        cleanup_expired_impl(arg0, arg3);
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_index_by_grantee(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 9);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::remove_active_grant_at(arg0, 0x1::option::extract<u64>(&mut v0));
        let v2 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_scope_mask(&v1);
        let v3 = v2 ^ v2 & arg2;
        assert!(v3 != 0, 12);
        let v4 = SoulGrant{
            id                       : 0x2::object::new(arg4),
            soul_id                  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            grantee                  : arg1,
            issued_by                : 0x2::tx_context::sender(arg4),
            ownership_epoch_snapshot : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::ownership_epoch(arg0),
            scope_mask               : v3,
            expires_at_ms            : *0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_expires_at_ms(&v1),
        };
        let v5 = 0x2::object::id<SoulGrant>(&v4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::push_active_grant(arg0, v5, arg1, v3, *0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_expires_at_ms(&v1));
        let v6 = SoulGrantSuperseded{
            old_grant_id  : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_grant_id(&v1),
            new_grant_id  : v5,
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            grantee       : arg1,
            superseded_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SoulGrantSuperseded>(v6);
        let v7 = SoulGrantIssued{
            grant_id      : v5,
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            issued_by     : 0x2::tx_context::sender(arg4),
            grantee       : arg1,
            scope_mask    : v3,
            expires_at_ms : *0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_slot_expires_at_ms(&v1),
        };
        0x2::event::emit<SoulGrantIssued>(v7);
        v4
    }

    public fun scope_assets() : u64 {
        8
    }

    public fun scope_mask(arg0: &SoulGrant) : u64 {
        arg0.scope_mask
    }

    public fun scope_memory() : u64 {
        2
    }

    public fun scope_seal() : u64 {
        1
    }

    public fun scope_skills() : u64 {
        4
    }

    public fun set_grant_capacity(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        cleanup_expired_impl(arg0, arg2);
        assert!(arg1 >= 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::active_grant_count(arg0), 14);
        assert!(arg1 <= 10000, 15);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::set_grant_capacity(arg0, arg1);
        let v0 = GrantCapacityUpdated{
            soul_id      : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg0),
            old_capacity : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::grant_capacity(arg0),
            new_capacity : arg1,
        };
        0x2::event::emit<GrantCapacityUpdated>(v0);
    }

    public fun soul_id(arg0: &SoulGrant) : 0x2::object::ID {
        arg0.soul_id
    }

    // decompiled from Move bytecode v7
}

