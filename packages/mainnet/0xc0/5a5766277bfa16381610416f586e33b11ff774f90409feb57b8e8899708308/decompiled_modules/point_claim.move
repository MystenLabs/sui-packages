module 0x46c6f7c5176ffe3d6706ed7bee5e31447071f9a5227e29d96179d5e7b5d73ea1::point_claim {
    struct PointClaim has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        scope: u8,
        points: u64,
        remainder: u256,
        precision: u256,
        closed_at_ms: u64,
        referral_state_id: 0x1::option::Option<0x2::object::ID>,
        referral_record_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PointsArchived has copy, drop {
        claim_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        scope: u8,
        points: u64,
        remainder: u256,
        precision: u256,
        closed_at_ms: u64,
    }

    struct PointsClaimed has copy, drop {
        claim_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        owner: address,
        points: u64,
        remainder: u256,
    }

    struct PointClaimDestroyed has copy, drop {
        claim_id: 0x2::object::ID,
        owner: address,
        discarded_remainder: u256,
        precision: u256,
    }

    public(friend) fun destroy_empty(arg0: PointClaim, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.points == 0, 2);
        let PointClaim {
            id                 : v0,
            config_id          : _,
            market_id          : _,
            source_id          : _,
            position_id        : _,
            owner              : v5,
            scope              : _,
            points             : _,
            remainder          : v8,
            precision          : v9,
            closed_at_ms       : _,
            referral_state_id  : _,
            referral_record_id : _,
        } = arg0;
        let v13 = v0;
        let v14 = PointClaimDestroyed{
            claim_id            : 0x2::object::uid_to_inner(&v13),
            owner               : v5,
            discarded_remainder : v8,
            precision           : v9,
        };
        0x2::event::emit<PointClaimDestroyed>(v14);
        0x2::object::delete(v13);
    }

    public(friend) fun archive(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: u8, arg6: u64, arg7: u256, arg8: u256, arg9: u64, arg10: 0x1::option::Option<0x2::object::ID>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0 && arg7 < arg8, 1);
        if (arg6 == 0 && arg7 == 0) {
            return
        };
        let v0 = PointClaim{
            id                 : 0x2::object::new(arg12),
            config_id          : arg0,
            market_id          : arg1,
            source_id          : arg2,
            position_id        : arg3,
            owner              : arg4,
            scope              : arg5,
            points             : arg6,
            remainder          : arg7,
            precision          : arg8,
            closed_at_ms       : arg9,
            referral_state_id  : arg10,
            referral_record_id : arg11,
        };
        let v1 = PointsArchived{
            claim_id     : 0x2::object::id<PointClaim>(&v0),
            config_id    : arg0,
            market_id    : arg1,
            source_id    : arg2,
            position_id  : arg3,
            owner        : arg4,
            scope        : arg5,
            points       : arg6,
            remainder    : arg7,
            precision    : arg8,
            closed_at_ms : arg9,
        };
        0x2::event::emit<PointsArchived>(v1);
        0x2::transfer::transfer<PointClaim>(v0, arg4);
    }

    public fun closed_at_ms(arg0: &PointClaim) : u64 {
        arg0.closed_at_ms
    }

    public fun config_id(arg0: &PointClaim) : 0x2::object::ID {
        arg0.config_id
    }

    public fun market_id(arg0: &PointClaim) : 0x2::object::ID {
        arg0.market_id
    }

    public fun owner(arg0: &PointClaim) : address {
        arg0.owner
    }

    public fun points(arg0: &PointClaim) : u64 {
        arg0.points
    }

    public fun position_id(arg0: &PointClaim) : 0x2::object::ID {
        arg0.position_id
    }

    public fun precision(arg0: &PointClaim) : u256 {
        arg0.precision
    }

    public fun referral_record_id(arg0: &PointClaim) : 0x1::option::Option<0x2::object::ID> {
        arg0.referral_record_id
    }

    public fun referral_state_id(arg0: &PointClaim) : 0x1::option::Option<0x2::object::ID> {
        arg0.referral_state_id
    }

    public fun remainder(arg0: &PointClaim) : u256 {
        arg0.remainder
    }

    public fun scope(arg0: &PointClaim) : u8 {
        arg0.scope
    }

    public fun source_id(arg0: &PointClaim) : 0x2::object::ID {
        arg0.source_id
    }

    public(friend) fun take(arg0: PointClaim, arg1: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let v0 = arg0.points;
        arg0.points = 0;
        let v1 = PointsClaimed{
            claim_id  : 0x2::object::id<PointClaim>(&arg0),
            config_id : arg0.config_id,
            owner     : arg0.owner,
            points    : v0,
            remainder : arg0.remainder,
        };
        0x2::event::emit<PointsClaimed>(v1);
        destroy_empty(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v7
}

