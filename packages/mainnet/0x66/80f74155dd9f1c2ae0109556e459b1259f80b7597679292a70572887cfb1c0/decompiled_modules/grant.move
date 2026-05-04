module 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant {
    struct SoulGrant has store, key {
        id: 0x2::object::UID,
        version: u64,
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

    public fun assert_active_with_scope(arg0: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: &SoulGrant, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.soul_id == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0), 2);
        assert!(arg1.grantee == 0x2::tx_context::sender(arg4), 5);
        assert!(arg1.ownership_epoch_snapshot == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0), 3);
        assert!(arg2 != 0, 10);
        if (0x1::option::is_some<u64>(&arg1.expires_at_ms)) {
            assert!(0x2::clock::timestamp_ms(arg3) < *0x1::option::borrow<u64>(&arg1.expires_at_ms), 6);
        };
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_grantee_by_id(arg0, 0x2::object::id<SoulGrant>(arg1));
        assert!(0x1::option::is_some<address>(&v0), 4);
        let v1 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_for_grantee(arg0, 0x1::option::extract<address>(&mut v0));
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grantee(v1) == arg1.grantee, 11);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_scope_mask(v1) == arg1.scope_mask, 11);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_ownership_epoch_snapshot(v1) == arg1.ownership_epoch_snapshot, 11);
        assert!(has_required_scope(arg1.scope_mask, arg2), 7);
    }

    fun assert_future_expiry(arg0: 0x1::option::Option<u64>, arg1: &0x2::clock::Clock) {
        if (0x1::option::is_some<u64>(&arg0)) {
            assert!(*0x1::option::borrow<u64>(&arg0) > 0x2::clock::timestamp_ms(arg1), 6);
        };
    }

    public(friend) fun assert_valid_scope_mask(arg0: u64) {
        assert!(arg0 != 0, 10);
        assert!(arg0 & all_scopes() == arg0, 13);
    }

    fun cleanup_inactive_grant_for_grantee(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: &0x2::clock::Clock) {
        if (!0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_has_grantee_row(arg0, arg1)) {
            return
        };
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_for_grantee(arg0, arg1);
        let v1 = 0x1::option::is_some<u64>(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_expires_at_ms(v0)) && 0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_expires_at_ms(v0));
        if (v1 || 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_ownership_epoch_snapshot(v0) != 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0)) {
            let v2 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::remove_active_grant_for_grantee(arg0, arg1);
            if (v1) {
                let v3 = SoulGrantExpired{
                    grant_id : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grant_id(&v2),
                    soul_id  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
                    grantee  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grantee(&v2),
                };
                0x2::event::emit<SoulGrantExpired>(v3);
            };
        };
    }

    public fun cleanup_inactive_grants(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: vector<address>, arg2: &0x2::clock::Clock) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            cleanup_inactive_grant_for_grantee(arg0, 0x1::vector::pop_back<address>(&mut arg1), arg2);
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun destroy_invalidated_grant(arg0: SoulGrant, arg1: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.soul_id == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg1), 2);
        let v0 = 0x2::object::id<SoulGrant>(&arg0);
        let v1 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_grantee_by_id(arg1, v0);
        let v2 = 0x1::option::is_some<u64>(&arg0.expires_at_ms) && 0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(&arg0.expires_at_ms);
        let v3 = if (arg0.ownership_epoch_snapshot != 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1)) {
            true
        } else if (0x1::option::is_none<address>(&v1)) {
            true
        } else {
            v2
        };
        assert!(v3, 16);
        if (0x1::option::is_some<address>(&v1)) {
            let v4 = 0x1::option::extract<address>(&mut v1);
            let v5 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_for_grantee(arg1, v4);
            if (0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grant_id(v5) == v0 && 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_ownership_epoch_snapshot(v5) != 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg1) || v2) {
                0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::remove_active_grant_for_grantee(arg1, v4);
            };
        };
        let SoulGrant {
            id                       : v6,
            version                  : _,
            soul_id                  : v8,
            grantee                  : v9,
            issued_by                : _,
            ownership_epoch_snapshot : _,
            scope_mask               : _,
            expires_at_ms            : _,
        } = arg0;
        0x2::object::delete(v6);
        let v14 = SoulGrantDestroyed{
            grant_id     : v0,
            soul_id      : v8,
            grantee      : v9,
            destroyed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SoulGrantDestroyed>(v14);
    }

    public fun expires_at_ms(arg0: &SoulGrant) : &0x1::option::Option<u64> {
        &arg0.expires_at_ms
    }

    public fun grant_version(arg0: &SoulGrant) : u64 {
        arg0.version
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

    public(friend) fun invalidate_all_for_owner_rotation(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: address) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::clear_active_grant_count_for_owner_rotation(arg0);
    }

    public fun issue(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : SoulGrant {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1 != @0x0, 1);
        assert!(arg1 != 0x2::tx_context::sender(arg5), 1);
        assert_valid_scope_mask(arg2);
        assert_future_expiry(arg3, arg4);
        cleanup_inactive_grant_for_grantee(arg0, arg1, arg4);
        let v0 = if (0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_contains_grantee(arg0, arg1)) {
            0x1::option::some<0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ActiveGrantSlot>(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::remove_active_grant_for_grantee(arg0, arg1))
        } else {
            assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_count(arg0) < 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::grant_capacity(arg0), 8);
            0x1::option::none<0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ActiveGrantSlot>()
        };
        let v1 = v0;
        let v2 = SoulGrant{
            id                       : 0x2::object::new(arg5),
            version                  : 1,
            soul_id                  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            grantee                  : arg1,
            issued_by                : 0x2::tx_context::sender(arg5),
            ownership_epoch_snapshot : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0),
            scope_mask               : arg2,
            expires_at_ms            : arg3,
        };
        let v3 = 0x2::object::id<SoulGrant>(&v2);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::push_active_grant(arg0, v3, arg1, arg2, arg3, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0));
        if (0x1::option::is_some<0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ActiveGrantSlot>(&v1)) {
            let v4 = 0x1::option::extract<0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ActiveGrantSlot>(&mut v1);
            let v5 = SoulGrantSuperseded{
                old_grant_id  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grant_id(&v4),
                new_grant_id  : v3,
                soul_id       : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
                grantee       : arg1,
                superseded_by : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<SoulGrantSuperseded>(v5);
        };
        let v6 = SoulGrantIssued{
            grant_id      : v3,
            soul_id       : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            issued_by     : 0x2::tx_context::sender(arg5),
            grantee       : arg1,
            scope_mask    : arg2,
            expires_at_ms : arg3,
        };
        0x2::event::emit<SoulGrantIssued>(v6);
        v2
    }

    public fun issue_to_grantee(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SoulGrant>(issue(arg0, arg1, arg2, arg3, arg4, arg5), arg1);
    }

    public fun issued_by(arg0: &SoulGrant) : address {
        arg0.issued_by
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun revoke(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        cleanup_inactive_grant_for_grantee(arg0, arg1, arg2);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_contains_grantee(arg0, arg1), 9);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::remove_active_grant_for_grantee(arg0, arg1);
        let v1 = SoulGrantRevoked{
            grant_id   : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grant_id(&v0),
            soul_id    : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            revoked_by : 0x2::tx_context::sender(arg3),
            grantee    : arg1,
        };
        0x2::event::emit<SoulGrantRevoked>(v1);
    }

    public fun revoke_scope(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SoulGrant {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_valid_scope_mask(arg2);
        cleanup_inactive_grant_for_grantee(arg0, arg1, arg3);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_contains_grantee(arg0, arg1), 9);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::remove_active_grant_for_grantee(arg0, arg1);
        let v1 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_scope_mask(&v0);
        let v2 = v1 ^ v1 & arg2;
        assert!(v2 != 0, 12);
        let v3 = SoulGrant{
            id                       : 0x2::object::new(arg4),
            version                  : 1,
            soul_id                  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            grantee                  : arg1,
            issued_by                : 0x2::tx_context::sender(arg4),
            ownership_epoch_snapshot : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0),
            scope_mask               : v2,
            expires_at_ms            : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_expires_at_ms(&v0),
        };
        let v4 = 0x2::object::id<SoulGrant>(&v3);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::push_active_grant(arg0, v4, arg1, v2, *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_expires_at_ms(&v0), 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::ownership_epoch(arg0));
        let v5 = SoulGrantSuperseded{
            old_grant_id  : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_grant_id(&v0),
            new_grant_id  : v4,
            soul_id       : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            grantee       : arg1,
            superseded_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SoulGrantSuperseded>(v5);
        let v6 = SoulGrantIssued{
            grant_id      : v4,
            soul_id       : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            issued_by     : 0x2::tx_context::sender(arg4),
            grantee       : arg1,
            scope_mask    : v2,
            expires_at_ms : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_slot_expires_at_ms(&v0),
        };
        0x2::event::emit<SoulGrantIssued>(v6);
        v3
    }

    public fun revoke_scope_to_grantee(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SoulGrant>(revoke_scope(arg0, arg1, arg2, arg3, arg4), arg1);
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

    public fun set_grant_capacity(arg0: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1 >= 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::active_grant_count(arg0), 14);
        assert!(arg1 <= 10000, 15);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::set_grant_capacity(arg0, arg1);
        let v0 = GrantCapacityUpdated{
            soul_id      : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg0),
            old_capacity : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::grant_capacity(arg0),
            new_capacity : arg1,
        };
        0x2::event::emit<GrantCapacityUpdated>(v0);
    }

    public fun soul_id(arg0: &SoulGrant) : 0x2::object::ID {
        arg0.soul_id
    }

    // decompiled from Move bytecode v7
}

