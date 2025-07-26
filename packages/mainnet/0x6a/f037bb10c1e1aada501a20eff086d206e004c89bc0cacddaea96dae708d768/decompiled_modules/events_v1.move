module 0x6af037bb10c1e1aada501a20eff086d206e004c89bc0cacddaea96dae708d768::events_v1 {
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

    struct NewStakePositionEvent has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        balance: u256,
        liquidity: u128,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
    }

    struct UnstakePositionEvent has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        balance: u256,
        liquidity: u128,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
    }

    struct ClaimRewardEvent has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    public fun emit_claim_reward_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = ClaimRewardEvent{
            holder_position_id : arg0,
            farm_id            : arg1,
            amount             : arg2,
            coin_type          : arg3,
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

    public fun emit_new_stake_position_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: u128, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) {
        let v0 = NewStakePositionEvent{
            holder_position_id : arg0,
            farm_id            : arg1,
            balance            : arg2,
            liquidity          : arg3,
            tick_lower_index   : arg4,
            tick_upper_index   : arg5,
        };
        0x2::event::emit<NewStakePositionEvent>(v0);
    }

    public fun emit_unstake_position_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: u128, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) {
        let v0 = UnstakePositionEvent{
            holder_position_id : arg0,
            farm_id            : arg1,
            balance            : arg2,
            liquidity          : arg3,
            tick_lower_index   : arg4,
            tick_upper_index   : arg5,
        };
        0x2::event::emit<UnstakePositionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

