module 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events {
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

    struct EmissionCapsUpdated has copy, drop {
        max_emission_delta_per_window: u64,
        max_duration_extension_per_window: u64,
        emission_window_seconds: u64,
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

    struct GuardianInitialized has copy, drop {
        guardian: address,
        cap_id: 0x2::object::ID,
    }

    struct GuardianRotated has copy, drop {
        old_guardian: address,
        new_guardian: address,
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct ProtocolPaused has copy, drop {
        guardian: address,
        timestamp_ms: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        guardian: address,
        timestamp_ms: u64,
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

    struct PoolIconUrlUpdate has copy, drop {
        pool_id: 0x2::object::ID,
        icon_url: 0x1::string::String,
        sequence_number: u128,
    }

    struct FarmCreated has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::string::String,
        reward_coin_symbol: 0x1::string::String,
        reward_coin_decimals: u8,
        total_reward: u64,
        start_time: u64,
        ended_at_seconds: u64,
        reward_per_second: u128,
        refund_address: address,
    }

    struct FarmPositionStaked has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
        owner: address,
        liquidity: u128,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct FarmRewardsHarvested has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
        owner: address,
        reward_coin_type: 0x1::string::String,
        amount: u64,
    }

    struct FarmRewardsToppedUp has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::string::String,
        reward_coin_symbol: 0x1::string::String,
        reward_coin_decimals: u8,
        amount: u64,
        total_reward: u64,
        ended_at_seconds: u64,
        last_update_time: u64,
        reward_per_second: u128,
    }

    struct FarmPauseStatusUpdated has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        paused: bool,
        manager: address,
        timestamp_seconds: u64,
    }

    struct FarmRewardsRefunded has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::string::String,
        refund_address: address,
        amount: u64,
    }

    struct FarmPositionUnstaked has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        staked_position_id: 0x2::object::ID,
        owner: address,
        reward_amount: u64,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{owner: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_emission_caps_updated_event(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = EmissionCapsUpdated{
            max_emission_delta_per_window     : arg0,
            max_duration_extension_per_window : arg1,
            emission_window_seconds           : arg2,
        };
        0x2::event::emit<EmissionCapsUpdated>(v0);
    }

    public(friend) fun emit_farm_created_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: address) {
        let v0 = FarmCreated{
            farm_id              : arg0,
            pool_id              : arg1,
            reward_coin_type     : arg2,
            reward_coin_symbol   : arg3,
            reward_coin_decimals : arg4,
            total_reward         : arg5,
            start_time           : arg6,
            ended_at_seconds     : arg7,
            reward_per_second    : arg8,
            refund_address       : arg9,
        };
        0x2::event::emit<FarmCreated>(v0);
    }

    public(friend) fun emit_farm_pause_status_updated_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: address, arg4: u64) {
        let v0 = FarmPauseStatusUpdated{
            farm_id           : arg0,
            pool_id           : arg1,
            paused            : arg2,
            manager           : arg3,
            timestamp_seconds : arg4,
        };
        0x2::event::emit<FarmPauseStatusUpdated>(v0);
    }

    public(friend) fun emit_farm_position_staked_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: u128, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = FarmPositionStaked{
            farm_id            : arg0,
            pool_id            : arg1,
            position_id        : arg2,
            staked_position_id : arg3,
            owner              : arg4,
            liquidity          : arg5,
            lower_tick         : arg6,
            upper_tick         : arg7,
        };
        0x2::event::emit<FarmPositionStaked>(v0);
    }

    public(friend) fun emit_farm_position_unstaked_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: u64) {
        let v0 = FarmPositionUnstaked{
            farm_id            : arg0,
            pool_id            : arg1,
            position_id        : arg2,
            staked_position_id : arg3,
            owner              : arg4,
            reward_amount      : arg5,
        };
        0x2::event::emit<FarmPositionUnstaked>(v0);
    }

    public(friend) fun emit_farm_rewards_harvested_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x1::string::String, arg6: u64) {
        let v0 = FarmRewardsHarvested{
            farm_id            : arg0,
            pool_id            : arg1,
            position_id        : arg2,
            staked_position_id : arg3,
            owner              : arg4,
            reward_coin_type   : arg5,
            amount             : arg6,
        };
        0x2::event::emit<FarmRewardsHarvested>(v0);
    }

    public(friend) fun emit_farm_rewards_refunded_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address, arg4: u64) {
        let v0 = FarmRewardsRefunded{
            farm_id          : arg0,
            pool_id          : arg1,
            reward_coin_type : arg2,
            refund_address   : arg3,
            amount           : arg4,
        };
        0x2::event::emit<FarmRewardsRefunded>(v0);
    }

    public(friend) fun emit_farm_rewards_topped_up_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128) {
        let v0 = FarmRewardsToppedUp{
            farm_id              : arg0,
            pool_id              : arg1,
            reward_coin_type     : arg2,
            reward_coin_symbol   : arg3,
            reward_coin_decimals : arg4,
            amount               : arg5,
            total_reward         : arg6,
            ended_at_seconds     : arg7,
            last_update_time     : arg8,
            reward_per_second    : arg9,
        };
        0x2::event::emit<FarmRewardsToppedUp>(v0);
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

    public(friend) fun emit_guardian_initialized_event(arg0: address, arg1: 0x2::object::ID) {
        let v0 = GuardianInitialized{
            guardian : arg0,
            cap_id   : arg1,
        };
        0x2::event::emit<GuardianInitialized>(v0);
    }

    public(friend) fun emit_guardian_rotated_event(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = GuardianRotated{
            old_guardian : arg0,
            new_guardian : arg1,
            old_cap_id   : arg2,
            new_cap_id   : arg3,
        };
        0x2::event::emit<GuardianRotated>(v0);
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

    public(friend) fun emit_observation_cardinality_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = ObservationCardinalityUpdated{
            pool                             : arg0,
            previous_observation_cardinality : arg1,
            current_observation_cardinality  : arg2,
            sequence_number                  : arg3,
        };
        0x2::event::emit<ObservationCardinalityUpdated>(v0);
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

    public(friend) fun emit_pool_creation_fee_claimed(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: u64, arg4: u64) {
        let v0 = PoolCreationFeeClaimed{
            coin_type          : arg0,
            amount             : arg1,
            destination        : arg2,
            accrued_fee_before : arg3,
            accrued_fee_after  : arg4,
        };
        0x2::event::emit<PoolCreationFeeClaimed>(v0);
    }

    public(friend) fun emit_pool_creation_fee_paid_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        let v0 = PoolCreationFeePaid{
            pool              : arg0,
            creator           : arg1,
            coin_type         : arg2,
            fee_amount        : arg3,
            total_accrued_fee : arg4,
        };
        0x2::event::emit<PoolCreationFeePaid>(v0);
    }

    public(friend) fun emit_pool_creation_fee_update_event(arg0: 0x1::string::String, arg1: u64, arg2: u64) {
        let v0 = PoolCreationFeeUpdate{
            coin_type           : arg0,
            previous_fee_amount : arg1,
            current_fee_amount  : arg2,
        };
        0x2::event::emit<PoolCreationFeeUpdate>(v0);
    }

    public(friend) fun emit_pool_icon_url_update_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u128) {
        let v0 = PoolIconUrlUpdate{
            pool_id         : arg0,
            icon_url        : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<PoolIconUrlUpdate>(v0);
    }

    public(friend) fun emit_pool_manager_update_event(arg0: 0x2::object::ID, arg1: address, arg2: u128) {
        let v0 = PoolManagerUpdate{
            pool_id         : arg0,
            new_manager     : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<PoolManagerUpdate>(v0);
    }

    public(friend) fun emit_pool_pause_status_update_event(arg0: 0x2::object::ID, arg1: bool, arg2: u128) {
        let v0 = PoolPauseStatusUpdate{
            pool_id         : arg0,
            status          : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<PoolPauseStatusUpdate>(v0);
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

    public(friend) fun emit_protocol_fee_share_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = ProtocolFeeShareUpdated{
            pool                        : arg0,
            previous_protocol_fee_share : arg1,
            current_protocol_fee_share  : arg2,
            sequence_number             : arg3,
        };
        0x2::event::emit<ProtocolFeeShareUpdated>(v0);
    }

    public(friend) fun emit_protocol_paused_event(arg0: address, arg1: u64) {
        let v0 = ProtocolPaused{
            guardian     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public(friend) fun emit_protocol_unpaused_event(arg0: address, arg1: u64) {
        let v0 = ProtocolUnpaused{
            guardian     : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public(friend) fun emit_reward_manager_update_event(arg0: address, arg1: bool) {
        let v0 = RewardsManagerUpdate{
            manager   : arg0,
            is_active : arg1,
        };
        0x2::event::emit<RewardsManagerUpdate>(v0);
    }

    public(friend) fun emit_reward_reserves_increased(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PoolRewardReservesIncreased{
            pool             : arg0,
            reward_coin_type : arg1,
            amount           : arg2,
            reserves_before  : arg3,
            revers_after     : arg4,
        };
        0x2::event::emit<PoolRewardReservesIncreased>(v0);
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

    public(friend) fun emit_tick_update_event(arg0: 0x2::object::ID, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128) {
        let v0 = PoolTickUpdate{
            pool            : arg0,
            index           : arg1,
            liquidity_gross : arg2,
            liquidity_net   : arg3,
        };
        0x2::event::emit<PoolTickUpdate>(v0);
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

    // decompiled from Move bytecode v7
}

