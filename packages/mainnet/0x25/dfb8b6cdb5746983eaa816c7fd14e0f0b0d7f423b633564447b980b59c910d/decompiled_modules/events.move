module 0x25dfb8b6cdb5746983eaa816c7fd14e0f0b0d7f423b633564447b980b59c910d::events {
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

    struct PoolPauseStatusUpdate has copy, drop {
        pool_id: 0x2::object::ID,
        status: bool,
        sequence_number: u128,
    }

    struct RewardsManagerUpdate has copy, drop {
        manager: address,
        is_active: bool,
    }

    struct PoolTickUpdate has copy, drop {
        pool: 0x2::object::ID,
        index: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
    }

    struct ProtocolFeeShareUpdated has copy, drop {
        pool: 0x2::object::ID,
        previous_protocol_fee_share: u64,
        current_protocol_fee_share: u64,
        sequence_number: u128,
    }

    struct ObservationCardinalityUpdated has copy, drop {
        pool: 0x2::object::ID,
        previous_observation_cardinality: u64,
        current_observation_cardinality: u64,
        sequence_number: u128,
    }

    struct PoolManagerUpdate has copy, drop {
        pool_id: 0x2::object::ID,
        new_manager: address,
        sequence_number: u128,
    }

    struct PoolCreationFeeUpdate has copy, drop {
        coin_type: 0x1::string::String,
        previous_fee_amount: u64,
        current_fee_amount: u64,
    }

    struct PoolCreationFeePaid has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::string::String,
        fee_amount: u64,
        total_accrued_fee: u64,
    }

    struct PoolCreationFeeClaimed has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
        destination: address,
        accrued_fee_before: u64,
        accrued_fee_after: u64,
    }

    struct PoolRewardReservesIncreased has copy, drop {
        pool: 0x2::object::ID,
        reward_coin_type: 0x1::string::String,
        amount: u64,
        reserves_before: u64,
        revers_after: u64,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        abort 0
    }

    public(friend) fun emit_flash_swap_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg10: bool, arg11: u128) {
        abort 0
    }

    public(friend) fun emit_liquidity_provided_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg13: u128) {
        abort 0
    }

    public(friend) fun emit_liquidity_removed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg13: u128) {
        abort 0
    }

    public(friend) fun emit_observation_cardinality_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        abort 0
    }

    public(friend) fun emit_pool_created_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: 0x1::string::String, arg9: u128, arg10: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg11: u32, arg12: u64, arg13: u64) {
        abort 0
    }

    public(friend) fun emit_pool_creation_fee_claimed(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: u64, arg4: u64) {
        abort 0
    }

    public(friend) fun emit_pool_creation_fee_paid_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        abort 0
    }

    public(friend) fun emit_pool_creation_fee_update_event(arg0: 0x1::string::String, arg1: u64, arg2: u64) {
        abort 0
    }

    public(friend) fun emit_pool_manager_update_event(arg0: 0x2::object::ID, arg1: address, arg2: u128) {
        abort 0
    }

    public(friend) fun emit_pool_pause_status_update_event(arg0: 0x2::object::ID, arg1: bool, arg2: u128) {
        abort 0
    }

    public(friend) fun emit_position_close_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public(friend) fun emit_position_open_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        abort 0
    }

    public(friend) fun emit_protocol_fee_cap_transfer_event(arg0: address) {
        abort 0
    }

    public(friend) fun emit_protocol_fee_collected(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128) {
        abort 0
    }

    public(friend) fun emit_protocol_fee_share_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        abort 0
    }

    public(friend) fun emit_reward_manager_update_event(arg0: address, arg1: bool) {
        abort 0
    }

    public(friend) fun emit_reward_reserves_increased(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        abort 0
    }

    public(friend) fun emit_supported_version_update_event(arg0: u64, arg1: u64) {
        abort 0
    }

    public(friend) fun emit_swap_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg12: bool, arg13: u128) {
        abort 0
    }

    public(friend) fun emit_tick_update_event(arg0: 0x2::object::ID, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128) {
        abort 0
    }

    public(friend) fun emit_update_pool_reward_emission_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128) {
        abort 0
    }

    public(friend) fun emit_user_fee_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        abort 0
    }

    public(friend) fun emit_user_reward_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u128) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

