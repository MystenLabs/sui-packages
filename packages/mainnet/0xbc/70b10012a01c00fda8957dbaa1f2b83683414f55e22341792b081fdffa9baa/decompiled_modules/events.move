module 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::events {
    struct AdminCapTransferred has copy, drop {
        owner: address,
    }

    struct ProtocolFeeCapTransferred has copy, drop {
        owner: address,
    }

    struct PoolCreated has copy, drop {
        id: 0x2::object::ID,
        coin_a: 0x1::string::String,
        coin_a_symbol: 0x1::string::String,
        coin_a_decimals: u8,
        coin_a_url: 0x1::string::String,
        coin_b: 0x1::string::String,
        coin_b_symbol: 0x1::string::String,
        coin_b_decimals: u8,
        coin_b_url: 0x1::string::String,
        current_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_spacing: u32,
        fee_rate: u64,
        protocol_fee_share: u64,
    }

    struct PositionOpened has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct PositionClosed has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct AssetSwap has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        pool_coin_a_amount: u64,
        pool_coin_b_amount: u64,
        fee: u64,
        before_liquidity: u128,
        after_liquidity: u128,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        exceeded: bool,
        sequence_number: u128,
    }

    struct FlashSwap has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        before_liquidity: u128,
        after_liquidity: u128,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        exceeded: bool,
        sequence_number: u128,
    }

    struct ProtocolFeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        destination: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        pool_coin_a_amount: u64,
        pool_coin_b_amount: u64,
        sequence_number: u128,
    }

    struct UserFeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        pool_coin_a_amount: u64,
        pool_coin_b_amount: u64,
        sequence_number: u128,
    }

    struct UserRewardCollected has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::string::String,
        reward_symbol: 0x1::string::String,
        reward_decimals: u8,
        reward_amount: u64,
        sequence_number: u128,
    }

    struct LiquidityProvided has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        pool_coin_a_amount: u64,
        pool_coin_b_amount: u64,
        liquidity: u128,
        before_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sequence_number: u128,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_a_amount: u64,
        coin_b_amount: u64,
        pool_coin_a_amount: u64,
        pool_coin_b_amount: u64,
        liquidity: u128,
        before_liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sequence_number: u128,
    }

    struct UpdatePoolRewardEmissionEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_coin_symbol: 0x1::string::String,
        reward_coin_type: 0x1::string::String,
        reward_coin_decimals: u8,
        total_reward: u64,
        ended_at_seconds: u64,
        last_update_time: u64,
        reward_per_seconds: u128,
        sequence_number: u128,
    }

    struct SupportedVersionUpdate has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct TickUpdate has copy, drop {
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{owner: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_flash_swap_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg10: bool, arg11: u128) {
        let v0 = FlashSwap{
            pool_id           : arg0,
            a2b               : arg1,
            amount_in         : arg2,
            amount_out        : arg3,
            fee               : arg4,
            before_liquidity  : arg5,
            after_liquidity   : arg6,
            before_sqrt_price : arg7,
            after_sqrt_price  : arg8,
            current_tick      : arg9,
            exceeded          : arg10,
            sequence_number   : arg11,
        };
        0x2::event::emit<FlashSwap>(v0);
    }

    public(friend) fun emit_liquidity_provided_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg13: u128) {
        let v0 = LiquidityProvided{
            pool_id            : arg0,
            position_id        : arg1,
            coin_a_amount      : arg2,
            coin_b_amount      : arg3,
            pool_coin_a_amount : arg4,
            pool_coin_b_amount : arg5,
            liquidity          : arg6,
            before_liquidity   : arg7,
            after_liquidity    : arg8,
            current_sqrt_price : arg9,
            current_tick_index : arg10,
            lower_tick         : arg11,
            upper_tick         : arg12,
            sequence_number    : arg13,
        };
        0x2::event::emit<LiquidityProvided>(v0);
    }

    public(friend) fun emit_liquidity_removed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg13: u128) {
        let v0 = LiquidityRemoved{
            pool_id            : arg0,
            position_id        : arg1,
            coin_a_amount      : arg2,
            coin_b_amount      : arg3,
            pool_coin_a_amount : arg4,
            pool_coin_b_amount : arg5,
            liquidity          : arg6,
            before_liquidity   : arg7,
            after_liquidity    : arg8,
            current_sqrt_price : arg9,
            current_tick_index : arg10,
            lower_tick         : arg11,
            upper_tick         : arg12,
            sequence_number    : arg13,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public(friend) fun emit_pool_created_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: 0x1::string::String, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: u32, arg12: u64, arg13: u64) {
        let v0 = PoolCreated{
            id                 : arg0,
            coin_a             : arg1,
            coin_a_symbol      : arg2,
            coin_a_decimals    : arg3,
            coin_a_url         : arg4,
            coin_b             : arg5,
            coin_b_symbol      : arg6,
            coin_b_decimals    : arg7,
            coin_b_url         : arg8,
            current_sqrt_price : arg9,
            current_tick_index : arg10,
            tick_spacing       : arg11,
            fee_rate           : arg12,
            protocol_fee_share : arg13,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_position_close_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = PositionClosed{
            pool_id     : arg0,
            position_id : arg1,
            tick_lower  : arg2,
            tick_upper  : arg3,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_open_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = PositionOpened{
            pool_id     : arg0,
            position_id : arg1,
            tick_lower  : arg2,
            tick_upper  : arg3,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_protocol_fee_cap_transfer_event(arg0: address) {
        let v0 = ProtocolFeeCapTransferred{owner: arg0};
        0x2::event::emit<ProtocolFeeCapTransferred>(v0);
    }

    public(friend) fun emit_protocol_fee_collected(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128) {
        let v0 = ProtocolFeeCollected{
            pool_id            : arg0,
            sender             : arg1,
            destination        : arg2,
            coin_a_amount      : arg3,
            coin_b_amount      : arg4,
            pool_coin_a_amount : arg5,
            pool_coin_b_amount : arg6,
            sequence_number    : arg7,
        };
        0x2::event::emit<ProtocolFeeCollected>(v0);
    }

    public(friend) fun emit_supported_version_update_event(arg0: u64, arg1: u64) {
        let v0 = SupportedVersionUpdate{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<SupportedVersionUpdate>(v0);
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: bool, arg13: u128) {
        let v0 = AssetSwap{
            pool_id            : arg0,
            a2b                : arg1,
            amount_in          : arg2,
            amount_out         : arg3,
            pool_coin_a_amount : arg4,
            pool_coin_b_amount : arg5,
            fee                : arg6,
            before_liquidity   : arg7,
            after_liquidity    : arg8,
            before_sqrt_price  : arg9,
            after_sqrt_price   : arg10,
            current_tick       : arg11,
            exceeded           : arg12,
            sequence_number    : arg13,
        };
        0x2::event::emit<AssetSwap>(v0);
    }

    public(friend) fun emit_tick_update_event(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u128, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128) {
        let v0 = TickUpdate{
            index           : arg0,
            liquidity_gross : arg1,
            liquidity_net   : arg2,
        };
        0x2::event::emit<TickUpdate>(v0);
    }

    public(friend) fun emit_update_pool_reward_emission_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128) {
        let v0 = UpdatePoolRewardEmissionEvent{
            pool_id              : arg0,
            reward_coin_symbol   : arg1,
            reward_coin_type     : arg2,
            reward_coin_decimals : arg3,
            total_reward         : arg4,
            ended_at_seconds     : arg5,
            last_update_time     : arg6,
            reward_per_seconds   : arg7,
            sequence_number      : arg8,
        };
        0x2::event::emit<UpdatePoolRewardEmissionEvent>(v0);
    }

    public(friend) fun emit_user_fee_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = UserFeeCollected{
            pool_id            : arg0,
            position_id        : arg1,
            coin_a_amount      : arg2,
            coin_b_amount      : arg3,
            pool_coin_a_amount : arg4,
            pool_coin_b_amount : arg5,
            sequence_number    : arg6,
        };
        0x2::event::emit<UserFeeCollected>(v0);
    }

    public(friend) fun emit_user_reward_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u128) {
        let v0 = UserRewardCollected{
            pool_id         : arg0,
            position_id     : arg1,
            reward_type     : arg2,
            reward_symbol   : arg3,
            reward_decimals : arg4,
            reward_amount   : arg5,
            sequence_number : arg6,
        };
        0x2::event::emit<UserRewardCollected>(v0);
    }

    // decompiled from Move bytecode v6
}

