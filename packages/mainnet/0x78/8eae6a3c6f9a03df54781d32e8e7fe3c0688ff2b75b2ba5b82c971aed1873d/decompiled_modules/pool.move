module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Tick has store, key {
        id: 0x2::object::UID,
        liquidity_gross: u128,
        liquidity_net: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128,
        fee_growth_outside_a: u128,
        fee_growth_outside_b: u128,
        reward_growths_outside: vector<u128>,
        initialized: bool,
    }

    struct PositionRewardInfo has store {
        reward_growth_inside: u128,
        amount_owed: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
        reward_infos: vector<PositionRewardInfo>,
    }

    struct PoolRewardVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<T0>,
    }

    struct PoolRewardInfo has store, key {
        id: 0x2::object::UID,
        vault: address,
        vault_coin_type: 0x1::string::String,
        emissions_per_second: u128,
        growth_global: u128,
        manager: address,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        protocol_fees_a: u64,
        protocol_fees_b: u64,
        sqrt_price: u128,
        tick_current_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_spacing: u32,
        max_liquidity_per_tick: u128,
        fee: u32,
        fee_protocol: u32,
        unlocked: bool,
        fee_growth_global_a: u128,
        fee_growth_global_b: u128,
        liquidity: u128,
        tick_map: 0x2::table::Table<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>,
        deploy_time_ms: u64,
        reward_infos: vector<PoolRewardInfo>,
        reward_last_updated_time_ms: u64,
    }

    struct ComputeSwapState has copy, drop {
        amount_a: u128,
        amount_b: u128,
        amount_specified_remaining: u128,
        amount_calculated: u128,
        sqrt_price: u128,
        tick_current_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        fee_growth_global: u128,
        protocol_fee: u128,
        liquidity: u128,
        fee_amount: u128,
    }

    struct SwapEvent has copy, drop {
        pool: 0x2::object::ID,
        recipient: address,
        amount_a: u64,
        amount_b: u64,
        liquidity: u128,
        tick_current_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_pre_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
        protocol_fee: u64,
        fee_amount: u64,
        a_to_b: bool,
        is_exact_in: bool,
    }

    struct MintEvent has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        amount_a: u64,
        amount_b: u64,
        liquidity_delta: u128,
    }

    struct BurnEvent has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        amount_a: u64,
        amount_b: u64,
        liquidity_delta: u128,
    }

    struct TogglePoolStatusEvent has copy, drop {
        pool: 0x2::object::ID,
        status: bool,
    }

    struct UpdatePoolFeeProtocolEvent has copy, drop {
        pool: 0x2::object::ID,
        fee_protocol: u32,
    }

    struct CollectEvent has copy, drop {
        pool: 0x2::object::ID,
        recipient: address,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        pool: 0x2::object::ID,
        recipient: address,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        recipient: address,
        tick_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        amount: u64,
        vault: 0x2::object::ID,
        reward_index: u64,
    }

    struct InitRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_index: u64,
        reward_vault: address,
        reward_manager: address,
    }

    struct UpdateRewardManagerEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_index: u64,
        reward_manager: address,
    }

    struct UpdateRewardEmissionsEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_index: u64,
        reward_vault: address,
        reward_manager: address,
        reward_emissions_per_second: u128,
    }

    struct AddRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_index: u64,
        reward_vault: address,
        reward_manager: address,
        amount: u64,
    }

    struct RemoveRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_index: u64,
        reward_vault: address,
        reward_manager: address,
        amount: u64,
        recipient: address,
    }

    struct UpgradeEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct MigratePositionEvent has copy, drop {
        pool: 0x2::object::ID,
        old_key: 0x1::string::String,
        new_key: 0x1::string::String,
    }

    struct ModifyTickRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        old_reward: u128,
        new_reward: u128,
    }

    public(friend) fun swap<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: bool, arg3: u128, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        let v0 = compute_swap_result<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, false, arg6, arg7);
        (v0.amount_a, v0.amount_b)
    }

    public(friend) fun add_reward<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut PoolRewardVault<T3>, arg2: u64, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos), 13);
        next_pool_reward_infos<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, arg2);
        assert!(v0.manager == 0x2::tx_context::sender(arg6), 17);
        assert!(v0.vault == 0x2::object::id_address<PoolRewardVault<T3>>(arg1), 14);
        0x2::balance::join<T3>(&mut arg1.coin, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut arg3, arg4, arg6)));
        if (0x2::coin::value<T3>(&arg3) == 0) {
            0x2::coin::destroy_zero<T3>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(arg3, 0x2::tx_context::sender(arg6));
        };
        let v1 = AddRewardEvent{
            pool           : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            reward_index   : arg2,
            reward_vault   : v0.vault,
            reward_manager : v0.manager,
            amount         : arg4,
        };
        0x2::event::emit<AddRewardEvent>(v1);
    }

    public(friend) fun burn<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.unlocked, 8);
        let (v0, v1) = modify_position<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg_from(arg4), arg5, arg6);
        let v2 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v0) as u64);
        let v3 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v1) as u64);
        let v4 = BurnEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            owner            : arg1,
            tick_lower_index : arg2,
            tick_upper_index : arg3,
            amount_a         : v2,
            amount_b         : v3,
            liquidity_delta  : arg4,
        };
        0x2::event::emit<BurnEvent>(v4);
        (v2, v3)
    }

    public fun check_position_exists<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, get_position_key(arg1, arg2, arg3))
    }

    fun check_ticks(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg1), 5);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636)), 5);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636)), 5);
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 6, 23);
    }

    fun clean_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::string::String) {
        let v0 = get_position_mut_by_key<T0, T1, T2>(arg0, arg1);
        let v1 = &mut v0.reward_infos;
        let v2 = 0;
        while (v2 < 3) {
            let v3 = 0x1::vector::borrow_mut<PositionRewardInfo>(v1, v2);
            v3.reward_growth_inside = 0;
            v3.amount_owed = 0;
            v2 = v2 + 1;
        };
        v0.liquidity = 0;
        v0.fee_growth_inside_a = 0;
        v0.fee_growth_inside_b = 0;
        v0.tokens_owed_a = 0;
        v0.tokens_owed_b = 0;
    }

    fun clear_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1);
        v0.liquidity_gross = 0;
        v0.liquidity_net = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero();
        v0.fee_growth_outside_a = 0;
        v0.fee_growth_outside_b = 0;
        v0.initialized = false;
    }

    public(friend) fun collect<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = get_position_mut<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg6), arg2, arg3);
        let v1 = if (arg4 > v0.tokens_owed_a) {
            v0.tokens_owed_a
        } else {
            arg4
        };
        let v2 = if (arg5 > v0.tokens_owed_b) {
            v0.tokens_owed_b
        } else {
            arg5
        };
        if (v1 > 0) {
            v0.tokens_owed_a = v0.tokens_owed_a - v1;
        };
        if (v2 > 0) {
            v0.tokens_owed_b = v0.tokens_owed_b - v2;
        };
        let v3 = CollectEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient        : arg1,
            tick_lower_index : arg2,
            tick_upper_index : arg3,
            amount_a         : v1,
            amount_b         : v2,
        };
        0x2::event::emit<CollectEvent>(v3);
        (v1, v2)
    }

    public(friend) fun collect_protocol_fee<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 > arg0.protocol_fees_a) {
            arg0.protocol_fees_a
        } else {
            arg1
        };
        let v1 = if (arg2 > arg0.protocol_fees_b) {
            arg0.protocol_fees_b
        } else {
            arg2
        };
        if (v0 > 0) {
            arg0.protocol_fees_a = arg0.protocol_fees_a - v0;
        };
        if (v1 > 0) {
            arg0.protocol_fees_b = arg0.protocol_fees_b - v1;
        };
        transfer_out<T0, T1, T2>(arg0, v0, v1, arg3, arg4);
        let v2 = CollectProtocolFeeEvent{
            pool      : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient : arg3,
            amount_a  : v0,
            amount_b  : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
    }

    public(friend) fun collect_reward<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut PoolRewardVault<T3>, arg2: address, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, arg6).vault == 0x2::object::id_address<PoolRewardVault<T3>>(arg1), 14);
        let v0 = get_position_mut<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg7), arg3, arg4);
        assert!(arg6 < 0x1::vector::length<PositionRewardInfo>(&v0.reward_infos), 13);
        let v1 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut v0.reward_infos, arg6);
        let v2 = if (arg5 > v1.amount_owed) {
            v1.amount_owed
        } else {
            arg5
        };
        if (v2 > 0) {
            v1.amount_owed = v1.amount_owed - v2;
        };
        assert!(v2 <= 0x2::balance::value<T3>(&arg1.coin), 18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut arg1.coin, v2), arg7), arg2);
        let v3 = CollectRewardEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient        : arg2,
            tick_lower_index : arg3,
            tick_upper_index : arg4,
            amount           : v2,
            vault            : 0x2::object::id<PoolRewardVault<T3>>(arg1),
            reward_index     : arg6,
        };
        0x2::event::emit<CollectRewardEvent>(v3);
        v2
    }

    public(friend) fun collect_reward_v2<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut PoolRewardVault<T3>, arg2: address, arg3: address, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, arg7).vault == 0x2::object::id_address<PoolRewardVault<T3>>(arg1), 14);
        let v0 = get_position_mut<T0, T1, T2>(arg0, arg3, arg4, arg5);
        assert!(arg7 < 0x1::vector::length<PositionRewardInfo>(&v0.reward_infos), 13);
        let v1 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut v0.reward_infos, arg7);
        let v2 = if (arg6 > v1.amount_owed) {
            v1.amount_owed
        } else {
            arg6
        };
        if (v2 > 0) {
            v1.amount_owed = v1.amount_owed - v2;
        };
        assert!(v2 <= 0x2::balance::value<T3>(&arg1.coin), 18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut arg1.coin, v2), arg8), arg2);
        let v3 = CollectRewardEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient        : arg2,
            tick_lower_index : arg4,
            tick_upper_index : arg5,
            amount           : v2,
            vault            : 0x2::object::id<PoolRewardVault<T3>>(arg1),
            reward_index     : arg7,
        };
        0x2::event::emit<CollectRewardEvent>(v3);
        v2
    }

    public(friend) fun collect_v2<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: address, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = get_position_mut<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let v1 = if (arg5 > v0.tokens_owed_a) {
            v0.tokens_owed_a
        } else {
            arg5
        };
        let v2 = if (arg6 > v0.tokens_owed_b) {
            v0.tokens_owed_b
        } else {
            arg6
        };
        if (v1 > 0) {
            v0.tokens_owed_a = v0.tokens_owed_a - v1;
        };
        if (v2 > 0) {
            v0.tokens_owed_b = v0.tokens_owed_b - v2;
        };
        let v3 = CollectEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient        : arg1,
            tick_lower_index : arg3,
            tick_upper_index : arg4,
            amount_a         : v1,
            amount_b         : v2,
        };
        0x2::event::emit<CollectEvent>(v3);
        (v1, v2)
    }

    public(friend) fun compute_swap_result<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: bool, arg3: u128, arg4: bool, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ComputeSwapState {
        assert!(arg0.unlocked, 8);
        assert!(arg3 != 0, 7);
        if (arg5 < 4295048016 || arg5 > 79226673515401279992447579055) {
            abort 19
        };
        if (arg2 && arg5 > arg0.sqrt_price || !arg2 && arg5 < arg0.sqrt_price) {
            abort 20
        };
        let v0 = next_pool_reward_infos<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg7));
        let v1 = arg0.tick_current_index;
        let v2 = if (arg2) {
            arg0.fee_growth_global_a
        } else {
            arg0.fee_growth_global_b
        };
        let v3 = ComputeSwapState{
            amount_a                   : 0,
            amount_b                   : 0,
            amount_specified_remaining : arg3,
            amount_calculated          : 0,
            sqrt_price                 : arg0.sqrt_price,
            tick_current_index         : arg0.tick_current_index,
            fee_growth_global          : v2,
            protocol_fee               : 0,
            liquidity                  : arg0.liquidity,
            fee_amount                 : 0,
        };
        while (v3.amount_specified_remaining > 0 && v3.sqrt_price != arg5) {
            let (v4, v5) = next_initialized_tick_within_one_word<T0, T1, T2>(arg0, v3.tick_current_index, arg2);
            let v6 = v4;
            if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636))) {
                v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(443636);
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636))) {
                v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(443636);
            };
            let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v6);
            let v8 = if (arg2 && v7 < arg5 || v7 > arg5) {
                arg5
            } else {
                v7
            };
            let (v9, v10, v11, v12) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(v3.sqrt_price, v8, v3.liquidity, v3.amount_specified_remaining, arg4, arg0.fee);
            let v13 = v12;
            v3.sqrt_price = v9;
            if (arg4) {
                v3.amount_specified_remaining = v3.amount_specified_remaining - v10 - v12;
                v3.amount_calculated = v3.amount_calculated + v11;
            } else {
                v3.amount_specified_remaining = v3.amount_specified_remaining - v11;
                v3.amount_calculated = v3.amount_calculated + v10 + v12;
            };
            v3.fee_amount = v3.fee_amount + v12;
            if (arg0.fee_protocol > 0) {
                let v14 = v12 * (arg0.fee_protocol as u128) / 1000000;
                v13 = v12 - v14;
                v3.protocol_fee = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_add(v3.protocol_fee, v14);
            };
            if (v3.liquidity > 0) {
                v3.fee_growth_global = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_add(v3.fee_growth_global, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(v13, 18446744073709551616, v3.liquidity));
            };
            if (v3.sqrt_price == v7) {
                if (v5) {
                    let v15 = if (arg2) {
                        v3.fee_growth_global
                    } else {
                        arg0.fee_growth_global_a
                    };
                    let v16 = if (arg2) {
                        arg0.fee_growth_global_b
                    } else {
                        v3.fee_growth_global
                    };
                    let v17 = cross_tick<T0, T1, T2>(arg0, v6, v15, v16, &v0, arg6, arg8);
                    let v18 = v17;
                    if (arg2) {
                        v18 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg(v17);
                    };
                    v3.liquidity = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v3.liquidity, v18);
                };
                let v19 = if (arg2) {
                    0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1))
                } else {
                    v6
                };
                v3.tick_current_index = v19;
                continue
            };
            if (v3.sqrt_price != v3.sqrt_price) {
                v3.tick_current_index = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::tick_index_from_sqrt_price(v3.sqrt_price);
            };
        };
        if (!arg6) {
            if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(v3.tick_current_index, arg0.tick_current_index)) {
                arg0.sqrt_price = v3.sqrt_price;
                arg0.tick_current_index = v3.tick_current_index;
            } else {
                arg0.sqrt_price = v3.sqrt_price;
            };
            if (arg0.liquidity != v3.liquidity) {
                arg0.liquidity = v3.liquidity;
            };
            if (arg2) {
                arg0.fee_growth_global_a = v3.fee_growth_global;
                if (v3.protocol_fee > 0) {
                    arg0.protocol_fees_a = arg0.protocol_fees_a + (v3.protocol_fee as u64);
                };
            } else {
                arg0.fee_growth_global_b = v3.fee_growth_global;
                if (v3.protocol_fee > 0) {
                    arg0.protocol_fees_b = arg0.protocol_fees_b + (v3.protocol_fee as u64);
                };
            };
        };
        let (v20, v21) = if (arg2 == arg4) {
            (arg3 - v3.amount_specified_remaining, v3.amount_calculated)
        } else {
            (v3.amount_calculated, arg3 - v3.amount_specified_remaining)
        };
        v3.amount_a = v20;
        v3.amount_b = v21;
        let v22 = SwapEvent{
            pool               : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            recipient          : arg1,
            amount_a           : (v3.amount_a as u64),
            amount_b           : (v3.amount_b as u64),
            liquidity          : v3.liquidity,
            tick_current_index : v3.tick_current_index,
            tick_pre_index     : v1,
            sqrt_price         : v3.sqrt_price,
            protocol_fee       : (v3.protocol_fee as u64),
            fee_amount         : (v3.fee_amount as u64),
            a_to_b             : arg2,
            is_exact_in        : arg4,
        };
        0x2::event::emit<SwapEvent>(v22);
        v3
    }

    fun cross_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: u128, arg3: u128, arg4: &vector<u128>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128 {
        let v0 = if (!0x2::dynamic_field::exists_<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg0.id, arg1)) {
            init_tick<T0, T1, T2>(arg0, arg1, arg6)
        } else {
            0x2::dynamic_field::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1)
        };
        if (!arg5) {
            v0.fee_growth_outside_a = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg2, v0.fee_growth_outside_a);
            v0.fee_growth_outside_b = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg3, v0.fee_growth_outside_b);
            let v1 = 0;
            while (v1 < 0x1::vector::length<u128>(arg4)) {
                let v2 = 0x1::vector::borrow_mut<u128>(&mut v0.reward_growths_outside, v1);
                *v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(*0x1::vector::borrow<u128>(arg4, v1), *v2);
                v1 = v1 + 1;
            };
        };
        v0.liquidity_net
    }

    public(friend) fun deploy_pool<T0, T1, T2>(arg0: u32, arg1: u32, arg2: u128, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2> {
        Pool<T0, T1, T2>{
            id                          : 0x2::object::new(arg5),
            coin_a                      : 0x2::balance::zero<T0>(),
            coin_b                      : 0x2::balance::zero<T1>(),
            protocol_fees_a             : 0,
            protocol_fees_b             : 0,
            sqrt_price                  : arg2,
            tick_current_index          : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::tick_index_from_sqrt_price(arg2),
            tick_spacing                : arg1,
            max_liquidity_per_tick      : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::max_liquidity_per_tick(arg1),
            fee                         : arg0,
            fee_protocol                : arg3,
            unlocked                    : true,
            fee_growth_global_a         : 0,
            fee_growth_global_b         : 0,
            liquidity                   : 0,
            tick_map                    : 0x2::table::new<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>(arg5),
            deploy_time_ms              : 0x2::clock::timestamp_ms(arg4),
            reward_infos                : 0x1::vector::empty<PoolRewardInfo>(),
            reward_last_updated_time_ms : 0,
        }
    }

    fun flip_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod_euclidean(arg1, arg0.tick_spacing), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero()), 12);
        let (v0, v1) = position_tick(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::div(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing)));
        try_init_tick_word<T0, T1, T2>(arg0, v0);
        let v2 = get_tick_word_mut<T0, T1, T2>(arg0, v0);
        *v2 = *v2 ^ 1 << v1;
    }

    public fun get_pool_balance<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    public fun get_pool_fee<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u32 {
        arg0.fee
    }

    public fun get_pool_sqrt_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u128 {
        arg0.sqrt_price
    }

    public fun get_position<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : &Position {
        get_position_by_key<T0, T1, T2>(arg0, get_position_key(arg1, arg2, arg3))
    }

    public fun get_position_base_info<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x1::string::String) : (u128, u128, u128, u64, u64, &vector<PositionRewardInfo>) {
        let v0 = get_position_by_key<T0, T1, T2>(arg0, arg1);
        (v0.liquidity, v0.fee_growth_inside_a, v0.fee_growth_inside_b, v0.tokens_owed_a, v0.tokens_owed_b, &v0.reward_infos)
    }

    fun get_position_by_key<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x1::string::String) : &Position {
        0x2::dynamic_object_field::borrow<0x1::string::String, Position>(&arg0.id, arg1)
    }

    public fun get_position_fee_growth_inside_a<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x1::string::String) : u128 {
        get_position_by_key<T0, T1, T2>(arg0, arg1).fee_growth_inside_a
    }

    public fun get_position_fee_growth_inside_b<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x1::string::String) : u128 {
        get_position_by_key<T0, T1, T2>(arg0, arg1).fee_growth_inside_b
    }

    public fun get_position_key(arg0: address, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : 0x1::string::String {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::string_tools::get_position_key(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg2))
    }

    fun get_position_mut<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : &mut Position {
        get_position_mut_by_key<T0, T1, T2>(arg0, get_position_key(arg1, arg2, arg3))
    }

    fun get_position_mut_by_key<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::string::String) : &mut Position {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Position>(&mut arg0.id, arg1)
    }

    public fun get_position_reward_info(arg0: &PositionRewardInfo) : (u128, u64) {
        (arg0.reward_growth_inside, arg0.amount_owed)
    }

    public fun get_position_reward_infos<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x1::string::String) : &vector<PositionRewardInfo> {
        &get_position_by_key<T0, T1, T2>(arg0, arg1).reward_infos
    }

    public fun get_tick<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : &Tick {
        assert!(0x2::dynamic_field::exists_<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg0.id, arg1), 0);
        0x2::dynamic_field::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&arg0.id, arg1)
    }

    fun get_tick_word<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : u256 {
        *0x2::table::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>(&arg0.tick_map, arg1)
    }

    fun get_tick_word_mut<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : &mut u256 {
        0x2::table::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>(&mut arg0.tick_map, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 6,
        };
        0x2::transfer::share_object<Versioned>(v0);
    }

    public(friend) fun init_reward<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PoolRewardVault<T3> {
        assert!(arg1 < 3, 13);
        assert!(arg1 == 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos), 13);
        let v0 = PoolRewardVault<T3>{
            id   : 0x2::object::new(arg3),
            coin : 0x2::balance::zero<T3>(),
        };
        let v1 = PoolRewardInfo{
            id                   : 0x2::object::new(arg3),
            vault                : 0x2::object::id_address<PoolRewardVault<T3>>(&v0),
            vault_coin_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T3>())),
            emissions_per_second : 0,
            growth_global        : 0,
            manager              : arg2,
        };
        0x1::vector::insert<PoolRewardInfo>(&mut arg0.reward_infos, v1, arg1);
        let v2 = InitRewardEvent{
            pool           : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            reward_index   : arg1,
            reward_vault   : 0x2::object::id_address<PoolRewardVault<T3>>(&v0),
            reward_manager : arg2,
        };
        0x2::event::emit<InitRewardEvent>(v2);
        v0
    }

    fun init_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: &mut 0x2::tx_context::TxContext) : &mut Tick {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u128>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = Tick{
            id                     : 0x2::object::new(arg2),
            liquidity_gross        : 0,
            liquidity_net          : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero(),
            fee_growth_outside_a   : 0,
            fee_growth_outside_b   : 0,
            reward_growths_outside : v0,
            initialized            : false,
        };
        0x2::dynamic_field::add<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1, v2);
        0x2::dynamic_field::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1)
    }

    public(friend) fun merge_coin<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 21);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        v0
    }

    public(friend) fun migrate_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_position_by_key<T0, T1, T2>(arg0, arg1);
        let v1 = 0x1::vector::empty<PositionRewardInfo>();
        let v2 = &v0.reward_infos;
        let v3 = 0;
        while (v3 < 3) {
            let v4 = 0x1::vector::borrow<PositionRewardInfo>(v2, v3);
            let v5 = PositionRewardInfo{
                reward_growth_inside : v4.reward_growth_inside,
                amount_owed          : v4.amount_owed,
            };
            0x1::vector::push_back<PositionRewardInfo>(&mut v1, v5);
            v3 = v3 + 1;
        };
        let v6 = Position{
            id                  : 0x2::object::new(arg3),
            liquidity           : v0.liquidity,
            fee_growth_inside_a : v0.fee_growth_inside_a,
            fee_growth_inside_b : v0.fee_growth_inside_b,
            tokens_owed_a       : v0.tokens_owed_a,
            tokens_owed_b       : v0.tokens_owed_b,
            reward_infos        : v1,
        };
        save_position<T0, T1, T2>(arg0, arg2, v6);
        clean_position<T0, T1, T2>(arg0, arg1);
        let v7 = MigratePositionEvent{
            pool    : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            old_key : arg1,
            new_key : arg2,
        };
        0x2::event::emit<MigratePositionEvent>(v7);
    }

    public(friend) fun mint<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.unlocked, 8);
        assert!(arg4 > 0, 1);
        try_init_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6);
        let (v0, v1) = modify_position<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::from(arg4), arg5, arg6);
        assert!(!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(v0) && !0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(v1), 3);
        let v2 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v0) as u64);
        let v3 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::abs_u128(v1) as u64);
        let v4 = MintEvent{
            pool             : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            owner            : arg1,
            tick_lower_index : arg2,
            tick_upper_index : arg3,
            amount_a         : v2,
            amount_b         : v3,
            liquidity_delta  : arg4,
        };
        0x2::event::emit<MintEvent>(v4);
        (v2, v3)
    }

    fun modify_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128) {
        check_ticks(arg2, arg3);
        update_position<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero();
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero();
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::eq(arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero())) {
            if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0.tick_current_index, arg2)) {
                v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg3), arg4);
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0.tick_current_index, arg3)) {
                v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta(arg0.sqrt_price, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg3), arg4);
                v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), arg0.sqrt_price, arg4);
                arg0.liquidity = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(arg0.liquidity, arg4);
            } else {
                v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg3), arg4);
            };
        };
        (v0, v1)
    }

    public(friend) fun modify_position_reward_inside<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: address, arg4: u64, arg5: u128) {
        0x1::vector::borrow_mut<PositionRewardInfo>(&mut get_position_mut<T0, T1, T2>(arg0, arg3, arg1, arg2).reward_infos, arg4).reward_growth_inside = arg5;
    }

    public(friend) fun modify_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, arg0.tick_current_index)) {
            let v0 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, 0).growth_global;
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg1, 0, v0);
        } else {
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg1, 0, 0);
        };
    }

    public(friend) fun modify_tick_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, arg0.tick_current_index)) {
            let v0 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, 0).growth_global;
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg1, 0, v0);
        } else {
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg1, 0, 0);
        };
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg2, arg0.tick_current_index)) {
            let v1 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, 0).growth_global;
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg2, 0, v1);
        } else {
            modify_tick_reward_outside<T0, T1, T2>(arg0, arg2, 0, 0);
        };
    }

    fun modify_tick_reward_outside<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: u64, arg3: u128) {
        let v0 = 0x1::vector::borrow_mut<u128>(&mut 0x2::dynamic_field::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1).reward_growths_outside, arg2);
        *v0 = arg3;
        let v1 = ModifyTickRewardEvent{
            pool       : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            old_reward : *v0,
            new_reward : *v0,
        };
        0x2::event::emit<ModifyTickRewardEvent>(v1);
    }

    fun next_fee_growth_inside<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: &mut 0x2::tx_context::TxContext) : (u128, u128) {
        let v0 = get_tick<T0, T1, T2>(arg0, arg1);
        let v1 = get_tick<T0, T1, T2>(arg0, arg2);
        let (v2, v3) = if (!v0.initialized) {
            (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
        } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg3, arg1)) {
            (v0.fee_growth_outside_a, v0.fee_growth_outside_b)
        } else {
            (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_a, v0.fee_growth_outside_a), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_b, v0.fee_growth_outside_b))
        };
        let (v4, v5) = if (!v0.initialized) {
            (0, 0)
        } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg3, arg2)) {
            (v1.fee_growth_outside_a, v1.fee_growth_outside_b)
        } else {
            (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_a, v1.fee_growth_outside_a), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_b, v1.fee_growth_outside_b))
        };
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_a, v2), v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg0.fee_growth_global_b, v3), v5))
    }

    fun next_initialized_tick_within_one_word<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: bool) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, bool) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::div(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing));
        let v1 = v0;
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero()) && !0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod_euclidean(arg1, arg0.tick_spacing), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero())) {
            v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1));
        };
        let (v2, v3) = if (arg2) {
            let (v4, v5) = position_tick(v1);
            try_init_tick_word<T0, T1, T2>(arg0, v4);
            let v6 = get_tick_word<T0, T1, T2>(arg0, v4) & (1 << v5) - 1 + (1 << v5);
            let v7 = if (v6 != 0) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(((v5 - 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_bit::most_significant_bit(v6)) as u32))), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing))
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from((v5 as u32))), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing))
            };
            (v12, v7)
        } else {
            let (v8, v9) = position_tick(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1)));
            try_init_tick_word<T0, T1, T2>(arg0, v8);
            let v10 = get_tick_word<T0, T1, T2>(arg0, v8) & ((1 << v9) - 1 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935);
            let v11 = if (v10 != 0) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_bit::least_significant_bit(v10) as u32)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from((v9 as u32)))), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing))
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(1)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(((255 - v9) as u32))), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg0.tick_spacing))
            };
            (v13, v11)
        };
        (v3, v2)
    }

    fun next_pool_reward_infos<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64) : vector<u128> {
        let v0 = arg0.reward_last_updated_time_ms;
        assert!(arg1 >= v0, 15);
        let v1 = 0x1::vector::empty<u128>();
        let v2 = (arg1 - v0) / 1000;
        let v3 = 0;
        while (v3 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            let v4 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, v3);
            if (arg0.liquidity == 0 || v2 == 0) {
                0x1::vector::insert<u128>(&mut v1, v4.growth_global, v3);
            } else {
                v4.growth_global = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_add(v4.growth_global, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor((v2 as u128), v4.emissions_per_second, arg0.liquidity));
                0x1::vector::insert<u128>(&mut v1, v4.growth_global, v3);
            };
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::length<u128>(&v1);
        while (v5 < 3) {
            0x1::vector::push_back<u128>(&mut v1, 0);
            v5 = v5 + 1;
        };
        arg0.reward_last_updated_time_ms = arg1;
        v1
    }

    fun next_reward_growths_inside<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: &mut 0x2::tx_context::TxContext) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = get_tick<T0, T1, T2>(arg0, arg1);
        let v2 = get_tick<T0, T1, T2>(arg0, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            let v4 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, v3);
            let v5 = if (!v1.initialized) {
                v4.growth_global
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg3, arg1)) {
                *0x1::vector::borrow<u128>(&v1.reward_growths_outside, v3)
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(v4.growth_global, *0x1::vector::borrow<u128>(&v1.reward_growths_outside, v3))
            };
            let v6 = if (!v2.initialized) {
                0
            } else if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg3, arg2)) {
                *0x1::vector::borrow<u128>(&v2.reward_growths_outside, v3)
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(v4.growth_global, *0x1::vector::borrow<u128>(&v2.reward_growths_outside, v3))
            };
            0x1::vector::insert<u128>(&mut v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(v4.growth_global, v5), v6), v3);
            v3 = v3 + 1;
        };
        v0
    }

    public fun position_tick(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u8) {
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::shr(arg0, 8), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod_euclidean(arg0, 256)) as u8))
    }

    public(friend) fun remove_reward<T0, T1, T2, T3>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut PoolRewardVault<T3>, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos), 13);
        next_pool_reward_infos<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg5));
        let v0 = 0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, arg2);
        assert!(v0.manager == 0x2::tx_context::sender(arg6), 17);
        assert!(v0.vault == 0x2::object::id_address<PoolRewardVault<T3>>(arg1), 14);
        assert!(arg3 <= 0x2::balance::value<T3>(&arg1.coin), 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut arg1.coin, arg3), arg6), arg4);
        let v1 = RemoveRewardEvent{
            pool           : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            reward_index   : arg2,
            reward_vault   : v0.vault,
            reward_manager : v0.manager,
            amount         : arg3,
            recipient      : arg4,
        };
        0x2::event::emit<RemoveRewardEvent>(v1);
    }

    fun save_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::string::String, arg2: Position) {
        0x2::dynamic_object_field::add<0x1::string::String, Position>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun split_and_transfer<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        transfer_in<T0, T1, T2>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg5), 0x2::coin::split<T1>(&mut arg3, arg4, arg5));
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
        if (0x2::coin::value<T1>(&arg3) == 0) {
            0x2::coin::destroy_zero<T1>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg5));
        };
    }

    public(friend) fun swap_coin_a_b<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, arg3), arg5), arg4);
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public(friend) fun swap_coin_a_b_b_c<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T2, T1>, arg1: &mut Pool<T2, T4, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg7)));
        0x2::balance::join<T2>(&mut arg1.coin_a, 0x2::coin::into_balance<T2>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_b, arg4), arg7)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(0x2::balance::split<T4>(&mut arg1.coin_b, arg5), arg7), arg6);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        };
    }

    public(friend) fun swap_coin_a_b_c_b<T0, T1, T2, T3, T4>(arg0: &mut Pool<T0, T2, T1>, arg1: &mut Pool<T4, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg7)));
        0x2::balance::join<T2>(&mut arg1.coin_b, 0x2::coin::into_balance<T2>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_b, arg4), arg7)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(0x2::balance::split<T4>(&mut arg1.coin_a, arg5), arg7), arg6);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        };
    }

    public(friend) fun swap_coin_b_a<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg2, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, arg3), arg5), arg4);
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public(friend) fun swap_coin_b_a_b_c<T0, T1, T2, T3, T4>(arg0: &mut Pool<T2, T0, T1>, arg1: &mut Pool<T2, T4, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_b, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg7)));
        0x2::balance::join<T2>(&mut arg1.coin_a, 0x2::coin::into_balance<T2>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_a, arg4), arg7)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(0x2::balance::split<T4>(&mut arg1.coin_b, arg5), arg7), arg6);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        };
    }

    public(friend) fun swap_coin_b_a_c_b<T0, T1, T2, T3, T4>(arg0: &mut Pool<T2, T0, T1>, arg1: &mut Pool<T4, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_b, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg7)));
        0x2::balance::join<T2>(&mut arg1.coin_b, 0x2::coin::into_balance<T2>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.coin_a, arg4), arg7)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(0x2::balance::split<T4>(&mut arg1.coin_a, arg5), arg7), arg6);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        };
    }

    public(friend) fun toggle_pool_status<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.unlocked = !arg0.unlocked;
        let v0 = TogglePoolStatusEvent{
            pool   : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            status : arg0.unlocked,
        };
        0x2::event::emit<TogglePoolStatusEvent>(v0);
    }

    public(friend) fun transfer_in<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg2));
    }

    public(friend) fun transfer_out<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, arg1), arg4), arg3);
        };
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, arg2), arg4), arg3);
        };
    }

    fun try_init_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_position_key(arg1, arg2, arg3);
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            let v1 = 0x1::vector::empty<PositionRewardInfo>();
            let v2 = 0;
            while (v2 < 3) {
                let v3 = PositionRewardInfo{
                    reward_growth_inside : 0,
                    amount_owed          : 0,
                };
                0x1::vector::push_back<PositionRewardInfo>(&mut v1, v3);
                v2 = v2 + 1;
            };
            let v4 = Position{
                id                  : 0x2::object::new(arg4),
                liquidity           : 0,
                fee_growth_inside_a : 0,
                fee_growth_inside_b : 0,
                tokens_owed_a       : 0,
                tokens_owed_b       : 0,
                reward_infos        : v1,
            };
            0x2::dynamic_object_field::add<0x1::string::String, Position>(&mut arg0.id, v0, v4);
        };
    }

    fun try_init_tick_word<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        if (!0x2::table::contains<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>(&arg0.tick_map, arg1)) {
            0x2::table::add<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u256>(&mut arg0.tick_map, arg1, 0);
        };
    }

    public(friend) fun update_pool_fee_protocol<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u32) {
        arg0.fee_protocol = arg1;
        let v0 = UpdatePoolFeeProtocolEvent{
            pool         : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            fee_protocol : arg1,
        };
        0x2::event::emit<UpdatePoolFeeProtocolEvent>(v0);
    }

    fun update_position<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: address, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.tick_current_index;
        let v1 = false;
        let v2 = false;
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::eq(arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero())) {
            let v3 = next_pool_reward_infos<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg5));
            let v4 = update_tick<T0, T1, T2>(arg0, arg2, v0, arg4, false, v3, arg6);
            v1 = v4;
            let v5 = update_tick<T0, T1, T2>(arg0, arg3, v0, arg4, true, v3, arg6);
            v2 = v5;
            if (v4) {
                flip_tick<T0, T1, T2>(arg0, arg2, arg6);
            };
            if (v5) {
                flip_tick<T0, T1, T2>(arg0, arg3, arg6);
            };
        };
        let (v6, v7) = next_fee_growth_inside<T0, T1, T2>(arg0, arg2, arg3, v0, arg6);
        let v8 = next_reward_growths_inside<T0, T1, T2>(arg0, arg2, arg3, v0, arg6);
        update_position_metadata<T0, T1, T2>(arg0, get_position_key(arg1, arg2, arg3), arg4, v6, v7, v8, arg6);
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::is_neg(arg4)) {
            if (v1) {
                clear_tick<T0, T1, T2>(arg0, arg2, arg6);
            };
            if (v2) {
                clear_tick<T0, T1, T2>(arg0, arg3, arg6);
            };
        };
    }

    fun update_position_metadata<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x1::string::String, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128, arg3: u128, arg4: u128, arg5: vector<u128>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos);
        let v1 = get_position_mut_by_key<T0, T1, T2>(arg0, arg1);
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::eq(arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero())) {
            assert!(v1.liquidity > 0, 6);
            v1.liquidity
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v1.liquidity, arg2)
        };
        let v3 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg3, v1.fee_growth_inside_a), v1.liquidity, 18446744073709551616) as u64);
        let v4 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(arg4, v1.fee_growth_inside_b), v1.liquidity, 18446744073709551616) as u64);
        v1.fee_growth_inside_a = arg3;
        v1.fee_growth_inside_b = arg4;
        if (v3 > 0 || v4 > 0) {
            v1.tokens_owed_a = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u64::wrapping_add(v1.tokens_owed_a, v3);
            v1.tokens_owed_b = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u64::wrapping_add(v1.tokens_owed_b, v4);
        };
        let v5 = 0;
        while (v5 < v0) {
            let v6 = *0x1::vector::borrow<u128>(&arg5, v5);
            let v7 = 0x1::vector::borrow_mut<PositionRewardInfo>(&mut v1.reward_infos, v5);
            v7.reward_growth_inside = v6;
            v7.amount_owed = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u64::wrapping_add(v7.amount_owed, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::wrapping_sub(v6, v7.reward_growth_inside), v1.liquidity, 18446744073709551616) as u64));
            v5 = v5 + 1;
        };
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::eq(arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::zero())) {
            v1.liquidity = v2;
        };
    }

    public(friend) fun update_reward_emissions<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        next_pool_reward_infos<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
        assert!(arg1 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos), 13);
        let v0 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, arg1);
        assert!(v0.manager == 0x2::tx_context::sender(arg4), 17);
        v0.emissions_per_second = arg2 << 64;
        let v1 = UpdateRewardEmissionsEvent{
            pool                        : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            reward_index                : arg1,
            reward_vault                : v0.vault,
            reward_manager              : v0.manager,
            reward_emissions_per_second : arg2,
        };
        0x2::event::emit<UpdateRewardEmissionsEvent>(v1);
    }

    public(friend) fun update_reward_manager<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 3, 13);
        assert!(arg1 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos), 13);
        0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, arg1).manager = arg2;
        let v0 = UpdateRewardManagerEvent{
            pool           : 0x2::object::id<Pool<T0, T1, T2>>(arg0),
            reward_index   : arg1,
            reward_manager : arg2,
        };
        0x2::event::emit<UpdateRewardManagerEvent>(v0);
    }

    fun update_tick<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::I128, arg4: bool, arg5: vector<u128>, arg6: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = arg0.fee_growth_global_a;
        let v1 = arg0.fee_growth_global_b;
        let v2 = arg0.max_liquidity_per_tick;
        let v3 = if (!0x2::dynamic_field::exists_<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg0.id, arg1)) {
            init_tick<T0, T1, T2>(arg0, arg1, arg6)
        } else {
            0x2::dynamic_field::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, Tick>(&mut arg0.id, arg1)
        };
        let v4 = v3.liquidity_gross;
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v4, arg3);
        assert!(v5 <= v2, 11);
        if (v4 == 0) {
            if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, arg2)) {
                v3.fee_growth_outside_a = v0;
                v3.fee_growth_outside_b = v1;
                v3.reward_growths_outside = arg5;
            };
            v3.initialized = true;
        };
        v3.liquidity_gross = v5;
        let v6 = if (arg4) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::sub(v3.liquidity_net, arg3)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::add(v3.liquidity_net, arg3)
        };
        v3.liquidity_net = v6;
        v5 == 0 != v4 == 0
    }

    public(friend) fun upgrade(arg0: &mut Versioned) {
        let v0 = arg0.version;
        assert!(v0 < 6, 22);
        arg0.version = 6;
        let v1 = UpgradeEvent{
            old_version : v0,
            new_version : 6,
        };
        0x2::event::emit<UpgradeEvent>(v1);
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

