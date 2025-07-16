module 0xc5e95051a7fb49b09c0b545e08c0da16cb19fff9ac9be844b6ee46fdfc487639::events_v1 {
    struct NewStakePositionEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance: u256,
    }

    struct UnstakePositionEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance: u256,
    }

    struct ClaimRewardEvent has copy, drop {
        farm_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct DistributeRewardEvent has copy, drop {
        farm_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct NewRewardPoolCreatedEvent has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    public fun emit_claim_reward_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::ascii::String) {
        let v0 = ClaimRewardEvent{
            farm_id   : arg0,
            amount    : arg1,
            coin_type : arg2,
        };
        0x2::event::emit<ClaimRewardEvent>(v0);
    }

    public fun emit_distribute_reward_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::ascii::String) {
        let v0 = DistributeRewardEvent{
            farm_id   : arg0,
            amount    : arg1,
            coin_type : arg2,
        };
        0x2::event::emit<DistributeRewardEvent>(v0);
    }

    public fun emit_new_reward_pool_created_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String) {
        let v0 = NewRewardPoolCreatedEvent{
            farm_id   : arg0,
            pool_id   : arg1,
            coin_type : arg2,
        };
        0x2::event::emit<NewRewardPoolCreatedEvent>(v0);
    }

    public fun emit_new_stake_position_event(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = NewStakePositionEvent{
            farm_id : arg0,
            balance : arg1,
        };
        0x2::event::emit<NewStakePositionEvent>(v0);
    }

    public fun emit_unstake_position_event(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = UnstakePositionEvent{
            farm_id : arg0,
            balance : arg1,
        };
        0x2::event::emit<UnstakePositionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

