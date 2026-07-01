module 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::farm {
    struct FarmStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FarmRewardVaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct StakedPositionKey has copy, drop, store {
        position_id: 0x2::object::ID,
    }

    struct FarmState has store {
        pool_id: 0x2::object::ID,
        reward_infos: vector<FarmRewardInfo>,
        active_liquidity: u128,
        min_claim_amount: u64,
        paused: bool,
        ticks: 0x2::table::Table<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>,
    }

    struct FarmRewardInfo has copy, drop, store {
        reward_coin_type: 0x1::string::String,
        reward_coin_symbol: 0x1::string::String,
        reward_coin_decimals: u8,
        start_time: u64,
        ended_at_seconds: u64,
        last_update_time: u64,
        total_reward: u64,
        total_reward_allocated: u64,
        total_reward_claimed: u64,
        reward_per_second: u128,
        reward_growth_global: u128,
    }

    struct FarmTick has store {
        liquidity_gross: u128,
        liquidity_net: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128,
        reward_growths_outside: vector<u128>,
    }

    struct StakedPosition has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
        reward_growth_inside_checkpoints: vector<u128>,
        rewards_owed: vector<u64>,
    }

    public(friend) fun active_liquidity(arg0: &0x2::object::UID) : u128 {
        let v0 = FarmStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FarmStateKey>(arg0, v0)) {
            return 0
        };
        let v1 = FarmStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<FarmStateKey, FarmState>(arg0, v1).active_liquidity
    }

    fun assert_all_rewards_harvested(arg0: &StakedPosition) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.rewards_owed)) {
            assert!(*0x1::vector::borrow<u64>(&arg0.rewards_owed, v0) == 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::can_not_claim_zero_reward());
            v0 = v0 + 1;
        };
    }

    fun borrow_mut_state(arg0: &mut 0x2::object::UID) : &mut FarmState {
        let v0 = FarmStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FarmStateKey, FarmState>(arg0, v0)
    }

    fun checkpoint_position(arg0: &mut FarmState, arg1: &mut StakedPosition, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u64) {
        assert!(arg1.pool_id == arg0.pool_id, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        update_rewards(arg0, arg3);
        ensure_receipt_reward_infos(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            let v1 = reward_growth_inside(arg0, v0, arg1.lower_tick, arg1.upper_tick, arg2);
            let v2 = 0x1::vector::borrow_mut<u128>(&mut arg1.reward_growth_inside_checkpoints, v0);
            let v3 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(arg1.liquidity, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(v1, *v2), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::q64());
            let v4 = 0x1::vector::borrow_mut<u64>(&mut arg1.rewards_owed, v0);
            assert!(v3 <= (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::max_u64() as u128) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u64::add_check(*v4, (v3 as u64)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::update_rewards_info_check_failed());
            *v4 = *v4 + (v3 as u64);
            *v2 = v1;
            v0 = v0 + 1;
        };
    }

    public(friend) fun create_farm<T0>(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg11)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        assert!(arg4 > 0 && 0x2::coin::value<T0>(&arg3) == arg4, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_amount_and_provided_balance_do_not_match());
        assert!(arg8 > 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_timestamp());
        let v0 = FarmRewardVaultKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<FarmRewardVaultKey<T0>>(arg1, v0), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found());
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::enforce_emission_delta_cap(arg0, arg10, arg4);
        let v1 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg10);
        assert!(arg7 >= v1, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_timestamp());
        let v2 = FarmStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FarmStateKey>(arg1, v2)) {
            let v3 = FarmStateKey{dummy_field: false};
            let v4 = FarmState{
                pool_id          : arg2,
                reward_infos     : 0x1::vector::empty<FarmRewardInfo>(),
                active_liquidity : 0,
                min_claim_amount : arg9,
                paused           : false,
                ticks            : 0x2::table::new<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(arg11),
            };
            0x2::dynamic_field::add<FarmStateKey, FarmState>(arg1, v3, v4);
        };
        let v5 = FarmRewardVaultKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<FarmRewardVaultKey<T0>, 0x2::balance::Balance<T0>>(arg1, v5, 0x2::coin::into_balance<T0>(arg3));
        let v6 = arg7 + arg8;
        let v7 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor((arg4 as u128), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::q64(), (arg8 as u128));
        let v8 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>();
        let v9 = borrow_mut_state(arg1);
        update_rewards(v9, v1);
        assert!(!is_reward_present(v9, v8), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found());
        let v10 = FarmRewardInfo{
            reward_coin_type       : v8,
            reward_coin_symbol     : arg5,
            reward_coin_decimals   : arg6,
            start_time             : arg7,
            ended_at_seconds       : v6,
            last_update_time       : arg7,
            total_reward           : arg4,
            total_reward_allocated : 0,
            total_reward_claimed   : 0,
            reward_per_second      : v7,
            reward_growth_global   : 0,
        };
        0x1::vector::push_back<FarmRewardInfo>(&mut v9.reward_infos, v10);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_created_event(arg2, arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>(), arg5, arg6, arg4, arg7, v6, v7, 0x2::tx_context::sender(arg11));
    }

    public(friend) fun cross_tick_if_initialized(arg0: &mut 0x2::object::UID, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool, arg3: u64) {
        let v0 = FarmStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FarmStateKey>(arg0, v0)) {
            return
        };
        let v1 = borrow_mut_state(arg0);
        if (!0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&v1.ticks, arg1)) {
            update_rewards(v1, arg3);
            return
        };
        update_rewards(v1, arg3);
        let v2 = reward_growth_globals(v1);
        let v3 = 0x1::vector::length<FarmRewardInfo>(&v1.reward_infos);
        let v4 = 0x2::table::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&mut v1.ticks, arg1);
        ensure_tick_reward_growths(v4, v3);
        let v5 = 0;
        while (v5 < v3) {
            let v6 = 0x1::vector::borrow_mut<u128>(&mut v4.reward_growths_outside, v5);
            *v6 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(*0x1::vector::borrow<u128>(&v2, v5), *v6);
            v5 = v5 + 1;
        };
        let v7 = if (arg2) {
            0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i128H::neg(v4.liquidity_net)
        } else {
            v4.liquidity_net
        };
        v1.active_liquidity = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::add_delta(v1.active_liquidity, v7);
    }

    fun empty_u64_vector(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    fun ensure_receipt_reward_infos(arg0: &FarmState, arg1: &mut StakedPosition) {
        let v0 = 0x1::vector::length<u128>(&arg1.reward_growth_inside_checkpoints);
        while (v0 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            0x1::vector::push_back<u128>(&mut arg1.reward_growth_inside_checkpoints, 0);
            0x1::vector::push_back<u64>(&mut arg1.rewards_owed, 0);
            v0 = v0 + 1;
        };
    }

    fun ensure_tick_reward_growths(arg0: &mut FarmTick, arg1: u64) {
        while (0x1::vector::length<u128>(&arg0.reward_growths_outside) < arg1) {
            0x1::vector::push_back<u128>(&mut arg0.reward_growths_outside, 0);
        };
    }

    fun find_reward_info_index(arg0: &FarmState, arg1: 0x1::string::String) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<FarmRewardInfo>(&arg0.reward_infos, v0).reward_coin_type == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found()
    }

    public(friend) fun harvest<T0>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: &mut StakedPosition, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg3.owner, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        let v0 = borrow_mut_state(arg1);
        assert!(v0.pool_id == arg2 && arg3.pool_id == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        checkpoint_position(v0, arg3, arg4, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg5));
        let v1 = find_reward_info_index(v0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>());
        let v2 = *0x1::vector::borrow<u64>(&arg3.rewards_owed, v1);
        if (v2 == 0) {
            return 0x2::balance::zero<T0>()
        };
        assert!(v2 >= v0.min_claim_amount, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::can_not_claim_zero_reward());
        *0x1::vector::borrow_mut<u64>(&mut arg3.rewards_owed, v1) = 0;
        let v3 = 0x1::vector::borrow_mut<FarmRewardInfo>(&mut v0.reward_infos, v1);
        v3.total_reward_claimed = v3.total_reward_claimed + v2;
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_rewards_harvested_event(arg2, arg2, arg3.position_id, 0x2::object::id<StakedPosition>(arg3), arg3.owner, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>(), v2);
        let v4 = FarmRewardVaultKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FarmRewardVaultKey<T0>, 0x2::balance::Balance<T0>>(arg1, v4), v2)
    }

    public(friend) fun has_staked_position(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : bool {
        let v0 = StakedPositionKey{position_id: arg1};
        0x2::dynamic_object_field::exists_with_type<StakedPositionKey, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position>(arg0, v0)
    }

    fun is_inside(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i32H::gte(arg0, arg1) && 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i32H::lt(arg0, arg2)
    }

    fun is_reward_present(arg0: &FarmState, arg1: 0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<FarmRewardInfo>(&arg0.reward_infos, v0).reward_coin_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun owner(arg0: &StakedPosition) : address {
        arg0.owner
    }

    public(friend) fun pending_rewards<T0>(arg0: &0x2::object::UID, arg1: &StakedPosition, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u64) : u64 {
        let v0 = FarmStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<FarmStateKey>(arg0, v0)) {
            return 0
        };
        let v1 = FarmStateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<FarmStateKey, FarmState>(arg0, v1);
        let v3 = find_reward_info_index(v2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>());
        let v4 = if (0x1::vector::length<u128>(&arg1.reward_growth_inside_checkpoints) <= v3) {
            0
        } else {
            *0x1::vector::borrow<u128>(&arg1.reward_growth_inside_checkpoints, v3)
        };
        let v5 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(arg1.liquidity, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(reward_growth_inside_at_index(v2, v3, arg1.lower_tick, arg1.upper_tick, arg2, simulated_reward_growth_global(v2, v3, arg3)), v4), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::q64());
        let v6 = if (0x1::vector::length<u64>(&arg1.rewards_owed) <= v3) {
            0
        } else {
            *0x1::vector::borrow<u64>(&arg1.rewards_owed, v3)
        };
        assert!(v5 <= (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::max_u64() as u128) && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u64::add_check(v6, (v5 as u64)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::update_rewards_info_check_failed());
        v6 + (v5 as u64)
    }

    public fun position_id(arg0: &StakedPosition) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun refund_unallocated_rewards<T0>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg5)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        let v0 = FarmRewardVaultKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FarmRewardVaultKey<T0>>(arg1, v0), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found());
        let v1 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg4);
        let v2 = borrow_mut_state(arg1);
        assert!(v2.pool_id == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        update_rewards(v2, v1);
        let v3 = 0x1::vector::borrow_mut<FarmRewardInfo>(&mut v2.reward_infos, find_reward_info_index(v2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>()));
        assert!(v1 >= v3.ended_at_seconds, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_timestamp());
        let v4 = v3.total_reward - v3.total_reward_allocated;
        v3.total_reward = v3.total_reward - v4;
        let v5 = if (v4 > 0) {
            let v6 = FarmRewardVaultKey<T0>{dummy_field: false};
            0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FarmRewardVaultKey<T0>, 0x2::balance::Balance<T0>>(arg1, v6), v4)
        } else {
            0x2::balance::zero<T0>()
        };
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_rewards_refunded_event(arg2, arg2, v3.reward_coin_type, arg3, v4);
        v5
    }

    fun reward_growth_globals(arg0: &FarmState) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            0x1::vector::push_back<u128>(&mut v0, 0x1::vector::borrow<FarmRewardInfo>(&arg0.reward_infos, v1).reward_growth_global);
            v1 = v1 + 1;
        };
        v0
    }

    fun reward_growth_inside(arg0: &FarmState, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        reward_growth_inside_at_index(arg0, arg1, arg2, arg3, arg4, 0x1::vector::borrow<FarmRewardInfo>(&arg0.reward_infos, arg1).reward_growth_global)
    }

    fun reward_growth_inside_at_index(arg0: &FarmState, arg1: u64, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: u128) : u128 {
        let v0 = if (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i32H::gte(arg4, arg2)) {
            reward_growth_outside_or_zero(arg0, arg2, arg1)
        } else {
            0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, reward_growth_outside_or_zero(arg0, arg2, arg1))
        };
        let v1 = if (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i32H::lt(arg4, arg3)) {
            reward_growth_outside_or_zero(arg0, arg3, arg1)
        } else {
            0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, reward_growth_outside_or_zero(arg0, arg3, arg1))
        };
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_sub(arg5, v0), v1)
    }

    fun reward_growth_outside_or_zero(arg0: &FarmState, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u64) : u128 {
        if (!0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&arg0.ticks, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&arg0.ticks, arg1);
        if (0x1::vector::length<u128>(&v0.reward_growths_outside) <= arg2) {
            return 0
        };
        *0x1::vector::borrow<u128>(&v0.reward_growths_outside, arg2)
    }

    fun reward_growths_inside(arg0: &FarmState, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            0x1::vector::push_back<u128>(&mut v0, reward_growth_inside(arg0, v1, arg1, arg2, arg3));
            v1 = v1 + 1;
        };
        v0
    }

    fun simulated_reward_growth_global(arg0: &FarmState, arg1: u64, arg2: u64) : u128 {
        let v0 = 0x1::vector::borrow<FarmRewardInfo>(&arg0.reward_infos, arg1);
        if (arg2 <= v0.last_update_time || arg0.active_liquidity == 0) {
            return v0.reward_growth_global
        };
        let v1 = 0x1::u64::min(arg2, v0.ended_at_seconds);
        if (v1 <= v0.last_update_time) {
            return v0.reward_growth_global
        };
        0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_add(v0.reward_growth_global, ((0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::full_mul(((v1 - v0.last_update_time) as u128), v0.reward_per_second) / (arg0.active_liquidity as u256)) as u128))
    }

    public(friend) fun stake_position(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : StakedPosition {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::pool_id(&arg3) == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::position_does_not_belong_to_pool());
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::liquidity(&arg3) > 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::insufficient_liquidity());
        let v0 = 0x2::object::id<0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position>(&arg3);
        let v1 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::lower_tick(&arg3);
        let v2 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::upper_tick(&arg3);
        let v3 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::liquidity(&arg3);
        let v4 = borrow_mut_state(arg1);
        assert!(!v4.paused, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::pool_is_paused());
        assert!(0x1::vector::length<FarmRewardInfo>(&v4.reward_infos) > 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found());
        update_rewards(v4, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg5));
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(v3);
        update_tick(v4, v1, arg4, v5, false);
        update_tick(v4, v2, arg4, v5, true);
        if (is_inside(arg4, v1, v2)) {
            v4.active_liquidity = v4.active_liquidity + v3;
        };
        let v6 = reward_growths_inside(v4, v1, v2, arg4);
        let v7 = StakedPositionKey{position_id: v0};
        0x2::dynamic_object_field::add<StakedPositionKey, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position>(arg1, v7, arg3);
        let v8 = StakedPosition{
            id                               : 0x2::object::new(arg6),
            pool_id                          : arg2,
            position_id                      : v0,
            owner                            : 0x2::tx_context::sender(arg6),
            lower_tick                       : v1,
            upper_tick                       : v2,
            liquidity                        : v3,
            reward_growth_inside_checkpoints : v6,
            rewards_owed                     : empty_u64_vector(0x1::vector::length<u128>(&v6)),
        };
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_position_staked_event(arg2, arg2, v0, 0x2::object::id<StakedPosition>(&v8), v8.owner, v3, v1, v2);
        v8
    }

    public(friend) fun top_up_rewards<T0>(arg0: &mut 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg7)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        assert!(arg5 > 0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_timestamp());
        assert!(arg4 > 0 && 0x2::coin::value<T0>(&arg3) == arg4, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_amount_and_provided_balance_do_not_match());
        let v0 = FarmRewardVaultKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FarmRewardVaultKey<T0>>(arg1, v0), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::reward_index_not_found());
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::enforce_emission_delta_cap(arg0, arg6, arg4);
        let v1 = borrow_mut_state(arg1);
        assert!(v1.pool_id == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        update_rewards(v1, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg6));
        let v2 = 0x1::vector::borrow_mut<FarmRewardInfo>(&mut v1.reward_infos, find_reward_info_index(v1, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>()));
        let v3 = v2.ended_at_seconds + arg5;
        assert!(v3 > v2.last_update_time, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_last_update_time());
        v2.total_reward = v2.total_reward + arg4;
        v2.ended_at_seconds = v3;
        v2.reward_per_second = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::mul_div_floor(((v2.total_reward - v2.total_reward_allocated) as u128), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::q64(), ((v2.ended_at_seconds - v2.last_update_time) as u128));
        let v4 = FarmRewardVaultKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FarmRewardVaultKey<T0>, 0x2::balance::Balance<T0>>(arg1, v4), 0x2::coin::into_balance<T0>(arg3));
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_rewards_topped_up_event(arg2, arg2, v2.reward_coin_type, v2.reward_coin_symbol, v2.reward_coin_decimals, arg4, v2.total_reward, v2.ended_at_seconds, v2.last_update_time, v2.reward_per_second);
    }

    public(friend) fun transfer_staked_position(arg0: StakedPosition, arg1: address) {
        0x2::transfer::transfer<StakedPosition>(arg0, arg1);
    }

    public(friend) fun unstake_position<T0>(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: StakedPosition, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position, 0x2::balance::Balance<T0>) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg3.owner, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        let v0 = borrow_mut_state(arg1);
        assert!(v0.pool_id == arg2 && arg3.pool_id == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        let v1 = &mut arg3;
        checkpoint_position(v0, v1, arg4, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg5));
        let v2 = find_reward_info_index(v0, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::get_type_string<T0>());
        let v3 = *0x1::vector::borrow<u64>(&arg3.rewards_owed, v2);
        *0x1::vector::borrow_mut<u64>(&mut arg3.rewards_owed, v2) = 0;
        assert_all_rewards_harvested(&arg3);
        if (v3 > 0) {
            let v4 = 0x1::vector::borrow_mut<FarmRewardInfo>(&mut v0.reward_infos, v2);
            v4.total_reward_claimed = v4.total_reward_claimed + v3;
        };
        let v5 = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i128H::neg(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::from(arg3.liquidity));
        update_tick(v0, arg3.lower_tick, arg4, v5, false);
        update_tick(v0, arg3.upper_tick, arg4, v5, true);
        if (is_inside(arg4, arg3.lower_tick, arg3.upper_tick)) {
            v0.active_liquidity = v0.active_liquidity - arg3.liquidity;
        };
        let v6 = if (v3 > 0) {
            let v7 = FarmRewardVaultKey<T0>{dummy_field: false};
            0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FarmRewardVaultKey<T0>, 0x2::balance::Balance<T0>>(arg1, v7), v3)
        } else {
            0x2::balance::zero<T0>()
        };
        let v8 = StakedPositionKey{position_id: arg3.position_id};
        let StakedPosition {
            id                               : v9,
            pool_id                          : v10,
            position_id                      : v11,
            owner                            : v12,
            lower_tick                       : _,
            upper_tick                       : _,
            liquidity                        : _,
            reward_growth_inside_checkpoints : _,
            rewards_owed                     : _,
        } = arg3;
        0x2::object::delete(v9);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_position_unstaked_event(v10, v10, v11, 0x2::object::id<StakedPosition>(&arg3), v12, v3);
        (0x2::dynamic_object_field::remove<StakedPositionKey, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::position::Position>(arg1, v8), v6)
    }

    public(friend) fun update_pause_status(arg0: &0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::GlobalConfig, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_version(arg0);
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::guardian::assert_not_paused(arg0);
        assert!(0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg5)), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::not_authorized());
        let v0 = borrow_mut_state(arg1);
        assert!(v0.pool_id == arg2, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::invalid_pool());
        assert!(v0.paused != arg3, 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::errors::same_value_provided());
        v0.paused = arg3;
        0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::events::emit_farm_pause_status_updated_event(arg2, arg2, arg3, 0x2::tx_context::sender(arg5), 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::timestamp_seconds(arg4));
    }

    fun update_rewards(arg0: &mut FarmState, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos)) {
            let v1 = 0x1::vector::borrow_mut<FarmRewardInfo>(&mut arg0.reward_infos, v0);
            if (arg1 > v1.last_update_time) {
                let v2 = 0x1::u64::min(arg1, v1.ended_at_seconds);
                if (arg0.active_liquidity != 0 && v2 > v1.last_update_time) {
                    let v3 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::full_math_u128::full_mul(((v2 - v1.last_update_time) as u128), v1.reward_per_second);
                    v1.reward_growth_global = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::math_u128::wrapping_add(v1.reward_growth_global, ((v3 / (arg0.active_liquidity as u256)) as u128));
                    v1.total_reward_allocated = v1.total_reward_allocated + ((v3 / (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::constants::q64() as u256)) as u64);
                };
                v1.last_update_time = arg1;
            };
            v0 = v0 + 1;
        };
    }

    fun update_tick(arg0: &mut FarmState, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::I128, arg4: bool) {
        let v0 = reward_growth_globals(arg0);
        if (!0x2::table::contains<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&arg0.ticks, arg1)) {
            let v1 = 0x1::vector::empty<u128>();
            let v2 = 0;
            while (v2 < 0x1::vector::length<u128>(&v0)) {
                let v3 = if (0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i32H::lte(arg1, arg2)) {
                    *0x1::vector::borrow<u128>(&v0, v2)
                } else {
                    0
                };
                0x1::vector::push_back<u128>(&mut v1, v3);
                v2 = v2 + 1;
            };
            let v4 = FarmTick{
                liquidity_gross        : 0,
                liquidity_net          : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::zero(),
                reward_growths_outside : v1,
            };
            0x2::table::add<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&mut arg0.ticks, arg1, v4);
        };
        let v5 = 0x2::table::borrow_mut<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, FarmTick>(&mut arg0.ticks, arg1);
        ensure_tick_reward_growths(v5, 0x1::vector::length<FarmRewardInfo>(&arg0.reward_infos));
        v5.liquidity_gross = 0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::utils::add_delta(v5.liquidity_gross, arg3);
        let v6 = if (arg4) {
            0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i128H::sub(v5.liquidity_net, arg3)
        } else {
            0xc1addd090f6b0f9abef380e0b2b924e81cdfbfa00eb03fdb5c0d97ab29509953::i128H::add(v5.liquidity_net, arg3)
        };
        v5.liquidity_net = v6;
    }

    // decompiled from Move bytecode v7
}

