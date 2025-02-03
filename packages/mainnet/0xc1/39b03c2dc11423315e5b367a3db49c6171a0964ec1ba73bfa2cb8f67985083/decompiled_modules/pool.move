module 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        sqrt_price: u128,
        liquidity: u128,
        tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        tick_spacing: u32,
        max_liquidity_per_tick: u128,
        swap_fee_rate: u64,
        fee_growth_global_x: u128,
        fee_growth_global_y: u128,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        protocol_fee_rate: u64,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        ticks: 0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::TickInfo>,
        tick_bitmap: 0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, u256>,
        reward_infos: vector<PoolRewardInfo>,
        observation_index: u64,
        observation_cardinality: u64,
        observation_cardinality_next: u64,
        observations: vector<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::Observation>,
    }

    struct PoolRewardInfo has copy, drop, store {
        reward_coin_type: 0x1::type_name::TypeName,
        last_update_time: u64,
        ended_at_seconds: u64,
        total_reward: u64,
        total_reward_allocated: u64,
        reward_per_seconds: u128,
        reward_growth_global: u128,
    }

    struct SwapState has copy, drop {
        amount_specified_remaining: u64,
        amount_calculated: u64,
        sqrt_price: u128,
        tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        fee_growth_global: u128,
        protocol_fee: u64,
        liquidity: u128,
        fee_amount: u64,
    }

    struct SwapStepComputations has copy, drop {
        sqrt_price_start: u128,
        tick_index_next: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
        initialized: bool,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    struct PoolRewardCustodianDfKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ObservationCardinalityUpdatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        observation_cardinality_next_old: u64,
        observation_cardinality_next_new: u64,
    }

    struct UpdatePoolRewardEmissionEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        total_reward: u64,
        ended_at_seconds: u64,
        reward_per_seconds: u128,
    }

    public fun transfer<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    public fun initialize<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock) {
        assert!(arg0.sqrt_price == 0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_initialization());
        arg0.tick_index = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_tick_at_sqrt_price(arg1);
        arg0.sqrt_price = arg1;
        let (v0, v1) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::initialize(&mut arg0.observations, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg2)));
        arg0.observation_cardinality = v0;
        arg0.observation_cardinality_next = v1;
    }

    public fun observe<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock) : (vector<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i64::I64>, vector<u256>) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::observe(&arg0.observations, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg2)), arg1, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : (u64, u64, u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        verify_pool<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::pool_id(arg1));
        let v0 = sqrt_price<T0, T1>(arg0);
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::get_liquidity_for_amounts(v0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_lower_index(arg1)), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_upper_index(arg1)), 0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&arg3));
        let v2 = 7777777779;
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<u128>(&v0);
        0x1::debug::print<u128>(&v1);
        let (v3, v4) = update_data_for_delta_l<T0, T1>(arg0, arg1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::from(v1), arg4);
        assert!(0x2::balance::value<T0>(&arg2) >= v3 && 0x2::balance::value<T1>(&arg3) >= v4, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::insufficient_funds());
        add_to_reserves<T0, T1>(arg0, 0x2::balance::split<T0>(&mut arg2, v3), 0x2::balance::split<T1>(&mut arg3, v4));
        (v3, v4, v1, arg2, arg3)
    }

    public(friend) fun add_reward_info<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: PoolRewardInfo, arg2: &0x2::tx_context::TxContext) {
        let v0 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        0x2::dynamic_field::add<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0, 0x2::balance::zero<T2>());
        0x1::vector::push_back<PoolRewardInfo>(&mut arg0.reward_infos, arg1);
    }

    public(friend) fun add_to_reserves<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.reserve_x, arg1);
        0x2::balance::join<T1>(&mut arg0.reserve_y, arg2);
    }

    public fun borrow_observations<T0, T1>(arg0: &Pool<T0, T1>) : &vector<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::Observation> {
        &arg0.observations
    }

    public fun borrow_tick_bitmap<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, u256> {
        &arg0.tick_bitmap
    }

    public fun borrow_ticks<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::TickInfo> {
        &arg0.ticks
    }

    fun closer(arg0: u128, arg1: u128, arg2: u128) : bool {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        v0 < v1
    }

    public(friend) fun collect_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        verify_pool<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::pool_id(arg1));
        let v0 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::owed_coin_x(arg1);
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::owed_coin_y(arg1);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::decrease_owed_amount(arg1, v0, v1);
        take_from_reserves<T0, T1>(arg0, v0, v1)
    }

    public(friend) fun collect_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position) : 0x2::balance::Balance<T2> {
        verify_pool<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::pool_id(arg1));
        let v0 = find_reward_info_index<T0, T1, T2>(arg0);
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::coins_owed_reward(arg1, v0);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::decrease_reward_debt(arg1, v0, v1);
        let v2 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v2);
        safe_withdraw<T2>(v3, v1)
    }

    public fun compute_swap_result<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128, arg4: u64) : SwapState {
        let v0 = if (arg1) {
            arg0.fee_growth_global_x
        } else {
            arg0.fee_growth_global_y
        };
        let v1 = SwapState{
            amount_specified_remaining : arg4,
            amount_calculated          : 0,
            sqrt_price                 : arg0.sqrt_price,
            tick_index                 : arg0.tick_index,
            fee_growth_global          : v0,
            protocol_fee               : 0,
            liquidity                  : arg0.liquidity,
            fee_amount                 : 0,
        };
        while (v1.amount_specified_remaining != 0) {
            let v2 = SwapStepComputations{
                sqrt_price_start : 0,
                tick_index_next  : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            v2.sqrt_price_start = v1.sqrt_price;
            let (v3, v4) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_bitmap::next_initialized_tick_within_one_word(&arg0.tick_bitmap, v1.tick_index, arg0.tick_spacing, arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::lt(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::min_tick())) {
                v2.tick_index_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::min_tick();
            } else if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::gt(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::max_tick())) {
                v2.tick_index_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::max(v2.sqrt_price_next, arg3)
            } else {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::min(v2.sqrt_price_next, arg3)
            };
            let (v6, v7, v8, v9) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::swap_math::compute_swap_step(v1.sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, arg0.swap_fee_rate, arg2);
            v1.sqrt_price = v6;
            v2.amount_in = v7;
            v2.amount_out = v8;
            v2.fee_amount = v9;
            if (arg2) {
                v1.amount_specified_remaining = v1.amount_specified_remaining - v2.amount_in + v2.fee_amount;
                v1.amount_calculated = v1.amount_calculated + v2.amount_out;
            } else {
                v1.amount_specified_remaining = v1.amount_specified_remaining - v2.amount_out;
                v1.amount_calculated = v1.amount_calculated + v2.amount_in + v2.fee_amount;
            };
            if (arg0.protocol_fee_rate > 0) {
                let v10 = v2.fee_amount / arg0.protocol_fee_rate;
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::wrapping_add(v1.fee_growth_global, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::mul_div_floor((v2.fee_amount as u128), (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u128), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            if (v1.sqrt_price == v2.sqrt_price_next) {
                if (v2.initialized) {
                    let v11 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::get_liquidity_net(&arg0.ticks, v2.tick_index_next);
                    let v12 = v11;
                    if (arg1) {
                        v12 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::neg(v11);
                    };
                    v1.liquidity = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::add_delta(v1.liquidity, v12);
                };
                let v13 = if (arg1) {
                    0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::sub(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.tick_index = v13;
                continue
            };
            if (v1.sqrt_price != v2.sqrt_price_start) {
                v1.tick_index = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_tick_at_sqrt_price(v1.sqrt_price);
            };
        };
        v1
    }

    public(friend) fun create<T0, T1>(arg0: u64, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id                           : 0x2::object::new(arg2),
            type_x                       : 0x1::type_name::get<T0>(),
            type_y                       : 0x1::type_name::get<T1>(),
            sqrt_price                   : 0,
            liquidity                    : 0,
            tick_index                   : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::zero(),
            tick_spacing                 : arg1,
            max_liquidity_per_tick       : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::tick_spacing_to_max_liquidity_per_tick(arg1),
            swap_fee_rate                : arg0,
            fee_growth_global_x          : 0,
            fee_growth_global_y          : 0,
            reserve_x                    : 0x2::balance::zero<T0>(),
            reserve_y                    : 0x2::balance::zero<T1>(),
            protocol_fee_rate            : 0,
            protocol_fee_x               : 0,
            protocol_fee_y               : 0,
            ticks                        : 0x2::table::new<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::TickInfo>(arg2),
            tick_bitmap                  : 0x2::table::new<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, u256>(arg2),
            reward_infos                 : 0x1::vector::empty<PoolRewardInfo>(),
            observation_index            : 0,
            observation_cardinality      : 0,
            observation_cardinality_next : 0,
            observations                 : 0x1::vector::empty<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::Observation>(),
        }
    }

    public(friend) fun default_reward_info(arg0: 0x1::type_name::TypeName, arg1: u64) : PoolRewardInfo {
        PoolRewardInfo{
            reward_coin_type       : arg0,
            last_update_time       : arg1,
            ended_at_seconds       : arg1,
            total_reward           : 0,
            total_reward_allocated : 0,
            reward_per_seconds     : 0,
            reward_growth_global   : 0,
        }
    }

    public fun fee_growth_global_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_x
    }

    public fun fee_growth_global_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_x
    }

    fun find_reward_info_index<T0, T1, T2>(arg0: &Pool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = false;
        while (v0 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            if (0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, v0).reward_coin_type == 0x1::type_name::get<T2>()) {
                v1 = v0;
                v2 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v2, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::reward_index_not_found());
        v1
    }

    public fun get_friendly_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: u128, arg2: u128) : (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32) {
        let v0 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_tick_at_sqrt_price(arg1);
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_tick_at_sqrt_price(arg2);
        let v2 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::from_u32(arg0.tick_spacing);
        (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::sub(v0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::mod(v0, v2)), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::sub(v1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::mod(v1, v2)))
    }

    public fun get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg3: u128, arg4: bool, arg5: u64) : (u64, bool) {
        let (v0, v1) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::get_amounts_for_liquidity(arg0.sqrt_price, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_lower_index(arg2)), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_upper_index(arg2)), arg0.liquidity, false);
        let (v2, v3) = if (v0 == 0) {
            let (v4, v5) = if (arg4) {
                (arg1, false)
            } else {
                (0, false)
            };
            (v5, v4)
        } else {
            let (v6, v7) = if (v1 == 0) {
                if (arg4) {
                    (0, true)
                } else {
                    (arg1, true)
                }
            } else {
                let v8 = 18446744073709551616;
                let v9 = (v0 as u128) * (v8 as u128) / (v1 as u128);
                let v10 = 0;
                let v11 = arg1 / 2;
                let v12 = false;
                while (v10 < arg5) {
                    let v13 = compute_swap_result<T0, T1>(arg0, arg4, true, arg3, v11);
                    let v14 = v13.amount_calculated;
                    let v15 = if (arg4) {
                        arg1 - v11
                    } else {
                        v14
                    };
                    let v16 = if (arg4) {
                        v14
                    } else {
                        arg1 - v11
                    };
                    let v17 = (v15 as u128) * (v8 as u128) / (v16 as u128);
                    if (v10 == 0) {
                    } else if (v17 > v9) {
                        if (arg4) {
                            let v18 = arg1 + v11;
                            v11 = v18 / 2;
                        } else {
                            let v19 = 0 + v11;
                            v11 = v19 / 2;
                        };
                        v12 = true;
                    } else {
                        if (arg4) {
                            let v20 = 0 + v11;
                            v11 = v20 / 2;
                        } else {
                            let v21 = arg1 + v11;
                            v11 = v21 / 2;
                        };
                        v12 = false;
                    };
                    v10 = v10 + 1;
                };
                (v11, !v12)
            };
            (v7, v6)
        };
        (v3, v2)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    public(friend) fun increase_observation_cardinality_next<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.observation_cardinality_next;
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::grow(&mut arg0.observations, v0, arg1);
        arg0.observation_cardinality_next = v1;
        let v2 = ObservationCardinalityUpdatedEvent{
            sender                           : 0x2::tx_context::sender(arg2),
            pool_id                          : 0x2::object::id<Pool<T0, T1>>(arg0),
            observation_cardinality_next_old : v0,
            observation_cardinality_next_new : v1,
        };
        0x2::event::emit<ObservationCardinalityUpdatedEvent>(v2);
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun max_liquidity_per_tick<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.max_liquidity_per_tick
    }

    public fun observation_cardinality<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.observation_cardinality
    }

    public fun observation_cardinality_next<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.observation_cardinality_next
    }

    public fun observation_index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.observation_index
    }

    public(friend) fun observations_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut vector<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::Observation> {
        &mut arg0.observations
    }

    public fun pool_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Pool<T0, T1>>(arg0)
    }

    public fun protocol_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_rate
    }

    public fun protocol_fee_x<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_x
    }

    public fun protocol_fee_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.protocol_fee_y
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg2: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::I128, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        verify_pool<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::pool_id(arg1));
        let (v0, v1) = update_data_for_delta_l<T0, T1>(arg0, arg1, arg2, arg3);
        let (v2, v3) = take_from_reserves<T0, T1>(arg0, v0, v1);
        if (v0 > 0 || v1 > 0) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::increase_owed_amount(arg1, v0, v1);
        };
        (v2, v3)
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    public fun reward_coin_type<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : 0x1::type_name::TypeName {
        reward_info_at<T0, T1>(arg0, arg1).reward_coin_type
    }

    public fun reward_ended_at<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).ended_at_seconds
    }

    public fun reward_growth_global<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u128 {
        reward_info_at<T0, T1>(arg0, arg1).reward_growth_global
    }

    public fun reward_info_at<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : &PoolRewardInfo {
        assert!(arg1 < reward_length<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::index_out_of_bounds());
        0x1::vector::borrow<PoolRewardInfo>(&arg0.reward_infos, arg1)
    }

    public fun reward_last_update_at<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).last_update_time
    }

    public fun reward_length<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)
    }

    public fun reward_per_seconds<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u128 {
        reward_info_at<T0, T1>(arg0, arg1).reward_per_seconds
    }

    fun safe_withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, 0x2::math::min(arg1, 0x2::balance::value<T0>(arg0)))
    }

    public(friend) fun set_fee_growth_global_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.fee_growth_global_x = arg1;
    }

    public(friend) fun set_fee_growth_global_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.fee_growth_global_y = arg1;
    }

    public(friend) fun set_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.liquidity = arg1;
    }

    public(friend) fun set_observation_cardinality<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.observation_cardinality = arg1;
    }

    public(friend) fun set_observation_index<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.observation_index = arg1;
    }

    public(friend) fun set_protocol_fee_rate<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.protocol_fee_rate = arg1;
    }

    public(friend) fun set_protocol_fee_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.protocol_fee_y = arg1;
    }

    public(friend) fun set_protocol_fee_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        arg0.protocol_fee_y = arg1;
    }

    public(friend) fun set_sqrt_price<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128) {
        arg0.sqrt_price = arg1;
    }

    public(friend) fun set_tick_index_current<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32) {
        arg0.tick_index = arg1;
    }

    public fun sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.sqrt_price
    }

    public fun swap_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.swap_fee_rate
    }

    public(friend) fun take_from_reserves<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg0.reserve_x;
        let v1 = safe_withdraw<T0>(v0, arg1);
        let v2 = &mut arg0.reserve_y;
        (v1, safe_withdraw<T1>(v2, arg2))
    }

    public(friend) fun tick_bitmap_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, u256> {
        &mut arg0.tick_bitmap
    }

    public fun tick_index_current<T0, T1>(arg0: &Pool<T0, T1>) : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32 {
        arg0.tick_index
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public(friend) fun ticks_mut<T0, T1>(arg0: &mut Pool<T0, T1>) : &mut 0x2::table::Table<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::TickInfo> {
        &mut arg0.ticks
    }

    public fun total_reward<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).total_reward
    }

    public fun total_reward_allocated<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).total_reward_allocated
    }

    public fun type_x<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::type_name::TypeName {
        arg0.type_x
    }

    public fun type_y<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::type_name::TypeName {
        arg0.type_y
    }

    public(friend) fun update_data_for_delta_l<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::Position, arg2: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::I128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = update_reward_infos<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        let v1 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_lower_index(arg1);
        let v2 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::tick_upper_index(arg1);
        let v3 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg3));
        let (v4, v5) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::observe_single(&arg0.observations, v3, 0, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality);
        if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::update(&mut arg0.ticks, v1, arg0.tick_index, arg2, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0, v5, v4, v3, false, arg0.max_liquidity_per_tick)) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, v1, arg0.tick_spacing);
            if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::lt(arg2, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::zero())) {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::clear(&mut arg0.ticks, v1);
            };
        };
        if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::update(&mut arg0.ticks, v2, arg0.tick_index, arg2, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0, v5, v4, v3, true, arg0.max_liquidity_per_tick)) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, v2, arg0.tick_spacing);
            if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::lt(arg2, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::zero())) {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::clear(&mut arg0.ticks, v2);
            };
        };
        let (v6, v7, v8) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::get_fee_and_reward_growths_inside(&arg0.ticks, v1, v2, arg0.tick_index, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::position::update(arg1, arg2, v6, v7, v8);
        if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::gte(arg0.tick_index, v1) && 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::lt(arg0.tick_index, v2)) {
            let (v9, v10) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::write(&mut arg0.observations, arg0.observation_index, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg3)), arg0.tick_index, arg0.liquidity, arg0.observation_cardinality, arg0.observation_cardinality_next);
            arg0.observation_index = v9;
            arg0.observation_cardinality = v10;
            arg0.liquidity = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::add_delta(arg0.liquidity, arg2);
        };
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::get_amounts_for_liquidity(sqrt_price<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(v1), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(v2), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::abs_u128(arg2), true)
    }

    public(friend) fun update_pool_reward_emission<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, find_reward_info_index<T0, T1, T2>(arg0));
        let v1 = v0.ended_at_seconds + arg2;
        assert!(v1 > v0.last_update_time, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_last_update_time());
        v0.total_reward = v0.total_reward + 0x2::balance::value<T2>(&arg1);
        v0.ended_at_seconds = v1;
        v0.reward_per_seconds = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::mul_div_floor(((v0.total_reward - v0.total_reward_allocated) as u128), (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u128), ((v0.ended_at_seconds - v0.last_update_time) as u128));
        let v2 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v2), arg1);
        let v3 = UpdatePoolRewardEmissionEvent{
            sender             : 0x2::tx_context::sender(arg3),
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_coin_type   : v0.reward_coin_type,
            total_reward       : v0.total_reward,
            ended_at_seconds   : v0.ended_at_seconds,
            reward_per_seconds : v0.reward_per_seconds,
        };
        0x2::event::emit<UpdatePoolRewardEmissionEvent>(v3);
    }

    public(friend) fun update_reward_infos<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            let v2 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, v1);
            v1 = v1 + 1;
            if (arg1 > v2.last_update_time) {
                let v3 = 0x2::math::min(arg1, v2.ended_at_seconds);
                if (arg0.liquidity != 0 && v3 > v2.last_update_time) {
                    let v4 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::full_mul(((v3 - v2.last_update_time) as u128), v2.reward_per_seconds);
                    v2.reward_growth_global = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::wrapping_add(v2.reward_growth_global, ((v4 / (arg0.liquidity as u256)) as u128));
                    v2.total_reward_allocated = v2.total_reward_allocated + ((v4 / (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u256)) as u64);
                };
                v2.last_update_time = arg1;
            };
            0x1::vector::push_back<u128>(&mut v0, v2.reward_growth_global);
        };
        v0
    }

    public fun verify_pool<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_pool_match());
    }

    // decompiled from Move bytecode v6
}

