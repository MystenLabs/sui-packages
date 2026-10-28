module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share {
    struct OutcomeShare has store, key {
        id: 0x2::object::UID,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        outcome: u8,
        amount: u64,
    }

    public fun id(arg0: &OutcomeShare) : 0x2::object::ID {
        0x2::object::id<OutcomeShare>(arg0)
    }

    public fun amount(arg0: &OutcomeShare) : u64 {
        arg0.amount
    }

    public fun assert_compatible(arg0: &OutcomeShare, arg1: &OutcomeShare) {
        assert!(arg0.market_id == arg1.market_id, 100);
        assert!(arg0.market_object_id == arg1.market_object_id, 100);
        assert!(arg0.outcome == arg1.outcome, 101);
    }

    public(friend) fun burn(arg0: OutcomeShare) : (u64, 0x2::object::ID, u8, u64) {
        let OutcomeShare {
            id               : v0,
            market_id        : v1,
            market_object_id : v2,
            outcome          : v3,
            amount           : v4,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4)
    }

    public(friend) fun burn_expected(arg0: OutcomeShare, arg1: u64, arg2: 0x2::object::ID, arg3: u8) : u64 {
        let (v0, v1, v2, v3) = burn(arg0);
        assert!(v0 == arg1, 100);
        assert!(v1 == arg2, 100);
        assert!(v2 == arg3, 101);
        v3
    }

    public fun join(arg0: &mut OutcomeShare, arg1: OutcomeShare) {
        assert_compatible(arg0, &arg1);
        let OutcomeShare {
            id               : v0,
            market_id        : _,
            market_object_id : _,
            outcome          : _,
            amount           : v4,
        } = arg1;
        0x2::object::delete(v0);
        arg0.amount = arg0.amount + v4;
    }

    public fun market_id(arg0: &OutcomeShare) : u64 {
        arg0.market_id
    }

    public fun market_object_id(arg0: &OutcomeShare) : 0x2::object::ID {
        arg0.market_object_id
    }

    public(friend) fun mint(arg0: u64, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : OutcomeShare {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg2);
        assert!(arg3 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        OutcomeShare{
            id               : 0x2::object::new(arg4),
            market_id        : arg0,
            market_object_id : arg1,
            outcome          : arg2,
            amount           : arg3,
        }
    }

    public fun outcome(arg0: &OutcomeShare) : u8 {
        arg0.outcome
    }

    public fun split(arg0: &mut OutcomeShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : OutcomeShare {
        assert!(arg1 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(arg0.amount >= arg1, 102);
        arg0.amount = arg0.amount - arg1;
        OutcomeShare{
            id               : 0x2::object::new(arg2),
            market_id        : arg0.market_id,
            market_object_id : arg0.market_object_id,
            outcome          : arg0.outcome,
            amount           : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

