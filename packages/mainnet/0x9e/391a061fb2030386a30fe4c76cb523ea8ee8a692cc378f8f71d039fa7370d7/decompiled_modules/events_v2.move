module 0xc5e95051a7fb49b09c0b545e08c0da16cb19fff9ac9be844b6ee46fdfc487639::events_v2 {
    struct NewStakePositionEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance: u256,
        liquidity: u128,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
    }

    struct NewStakePositionEventV2 has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        balance: u256,
        liquidity: u128,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
    }

    struct UnstakePositionEventV2 has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        balance: u256,
    }

    struct ClaimRewardEventV2 has copy, drop {
        holder_position_id: 0x2::object::ID,
        farm_id: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    public fun emit_claim_reward_event_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = ClaimRewardEventV2{
            holder_position_id : arg0,
            farm_id            : arg1,
            amount             : arg2,
            coin_type          : arg3,
        };
        0x2::event::emit<ClaimRewardEventV2>(v0);
    }

    public fun emit_new_stake_position_event_v2(arg0: 0x2::object::ID, arg1: u256, arg2: u128, arg3: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) {
        let v0 = NewStakePositionEvent{
            farm_id          : arg0,
            balance          : arg1,
            liquidity        : arg2,
            tick_lower_index : arg3,
            tick_upper_index : arg4,
        };
        0x2::event::emit<NewStakePositionEvent>(v0);
    }

    public fun emit_new_stake_position_event_v2_1(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: u128, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg5: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) {
        let v0 = NewStakePositionEventV2{
            holder_position_id : arg0,
            farm_id            : arg1,
            balance            : arg2,
            liquidity          : arg3,
            tick_lower_index   : arg4,
            tick_upper_index   : arg5,
        };
        0x2::event::emit<NewStakePositionEventV2>(v0);
    }

    public fun emit_unstake_position_event_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256) {
        let v0 = UnstakePositionEventV2{
            holder_position_id : arg0,
            farm_id            : arg1,
            balance            : arg2,
        };
        0x2::event::emit<UnstakePositionEventV2>(v0);
    }

    // decompiled from Move bytecode v6
}

