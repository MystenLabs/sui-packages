module 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::pool {
    struct PoolRewardCustodianDfKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_type_x: 0x1::type_name::TypeName,
        coin_type_y: 0x1::type_name::TypeName,
        sqrt_price: u128,
        tick_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        observation_index: u64,
        observation_cardinality: u64,
        observation_cardinality_next: u64,
        tick_spacing: u32,
        max_liquidity_per_tick: u128,
        protocol_fee_rate: u64,
        swap_fee_rate: u64,
        fee_growth_global_x: u128,
        fee_growth_global_y: u128,
        protocol_fee_x: u64,
        protocol_fee_y: u64,
        liquidity: u128,
        ticks: 0x2::table::Table<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::TickInfo>,
        tick_bitmap: 0x2::table::Table<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, u256>,
        observations: vector<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::Observation>,
        locked: bool,
        reward_infos: vector<PoolRewardInfo>,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        strategy_fee_rate: u64,
        strategy_mode: u64,
        strategy_coin_x: bool,
        strategy_address: address,
        strategy_reserve_x: 0x2::balance::Balance<T0>,
        strategy_reserve_y: 0x2::balance::Balance<T1>,
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
        tick_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        fee_growth_global: u128,
        liquidity: u128,
        fee_amount: u64,
        protocol_fee_amount: u64,
        strategy_fee_amount: u64,
    }

    struct SwapStepComputations has copy, drop {
        sqrt_price_start: u128,
        tick_index_next: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        initialized: bool,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    struct SwapReceipt {
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
        strategy_x_debt: u64,
        strategy_y_debt: u64,
    }

    struct FlashReceipt {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct ModifyLiquidity has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        tick_upper_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        liquidity_delta: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::I128,
        amount_x: u64,
        amount_y: u64,
    }

    struct Swap has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        x_for_y: bool,
        amount_x: u64,
        amount_y: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        liquidity: u128,
        tick_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
        fee_amount: u64,
        protocol_fee_amount: u64,
        strategy_fee_amount: u64,
    }

    struct Flash has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct Pay has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
        strategy_x_debt: u64,
        strategy_y_debt: u64,
        paid_x: u64,
        paid_y: u64,
    }

    struct Collect has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct CollectProtocolFee has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct SetProtocolFeeRate has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        protocol_fee_rate_x_old: u64,
        protocol_fee_rate_y_old: u64,
        protocol_fee_rate_x_new: u64,
        protocol_fee_rate_y_new: u64,
    }

    struct SetStrategy has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        strategy_fee_rate: u64,
        strategy_mode: u64,
        strategy_coin_x: bool,
        strategy_address: address,
    }

    struct WithdrawStrategyBalance has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct Initialize has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        sqrt_price: u128,
        tick_index: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32,
    }

    struct IncreaseObservationCardinalityNext has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        observation_cardinality_next_old: u64,
        observation_cardinality_next_new: u64,
    }

    struct InitializePoolReward has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        started_at_seconds: u64,
    }

    struct UpdatePoolRewardEmission has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        total_reward: u64,
        ended_at_seconds: u64,
        reward_per_seconds: u128,
    }

    struct CollectPoolReward has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapReceipt) {
        let v0 = arg1 && (arg0.strategy_mode == 1 || arg0.strategy_mode == 3) || arg0.strategy_mode == 2 || arg0.strategy_mode == 3;
        swap_internal<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun initialize<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128, arg2: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg2);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg2);
        if (arg0.sqrt_price > 0) {
            abort 2
        };
        let v0 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_tick_at_sqrt_price(arg1);
        arg0.tick_index = v0;
        arg0.sqrt_price = arg1;
        let (v1, v2) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::initialize(&mut arg0.observations, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        arg0.observation_cardinality = v1;
        arg0.observation_cardinality_next = v2;
        arg0.locked = false;
        let v3 = Initialize{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            sqrt_price : arg1,
            tick_index : v0,
        };
        0x2::event::emit<Initialize>(v3);
    }

    public fun observe<T0, T1>(arg0: &Pool<T0, T1>, arg1: vector<u64>, arg2: &0x2::clock::Clock) : (vector<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::I64>, vector<u256>) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::observe(&arg0.observations, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg2)), arg1, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality)
    }

    public fun borrow_observations<T0, T1>(arg0: &Pool<T0, T1>) : &vector<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::Observation> {
        &arg0.observations
    }

    public fun borrow_tick_bitmap<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, u256> {
        &arg0.tick_bitmap
    }

    public fun borrow_ticks<T0, T1>(arg0: &Pool<T0, T1>) : &0x2::table::Table<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::TickInfo> {
        &arg0.ticks
    }

    fun check_lock<T0, T1>(arg0: &Pool<T0, T1>) {
        if (arg0.locked) {
            abort 3
        };
    }

    fun check_pool_match<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) {
        if (0x2::object::id<Pool<T0, T1>>(arg0) != arg1) {
            abort 0
        };
    }

    public fun coin_type_x<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::type_name::TypeName {
        arg0.coin_type_x
    }

    public fun coin_type_y<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::type_name::TypeName {
        arg0.coin_type_y
    }

    public fun collect<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position, arg2: u64, arg3: u64, arg4: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg4);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg4);
        check_lock<T0, T1>(arg0);
        check_pool_match<T0, T1>(arg0, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::pool_id(arg1));
        let v0 = 0x2::math::min(arg2, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::coins_owed_x(arg1));
        let v1 = 0x2::math::min(arg3, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::coins_owed_y(arg1));
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::decrease_debt(arg1, v0, v1);
        let v2 = Collect{
            sender      : 0x2::tx_context::sender(arg5),
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position>(arg1),
            amount_x    : v0,
            amount_y    : v1,
        };
        0x2::event::emit<Collect>(v2);
        take<T0, T1>(arg0, v0, v1)
    }

    public fun collect_pool_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position, arg2: u64, arg3: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg3);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg3);
        check_lock<T0, T1>(arg0);
        check_pool_match<T0, T1>(arg0, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::pool_id(arg1));
        let v0 = find_reward_info_index<T0, T1, T2>(arg0);
        let v1 = 0x2::math::min(arg2, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::coins_owed_reward(arg1, v0));
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::decrease_reward_debt(arg1, v0, v1);
        let v2 = CollectPoolReward{
            sender           : 0x2::tx_context::sender(arg4),
            pool_id          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position>(arg1),
            reward_coin_type : 0x1::type_name::get<T2>(),
            amount           : v1,
        };
        0x2::event::emit<CollectPoolReward>(v2);
        let v3 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v3);
        safe_withdraw<T2>(v4, v1)
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg4);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg4);
        check_lock<T0, T1>(arg1);
        let v0 = 0x2::math::min(arg2, arg1.protocol_fee_x);
        let v1 = 0x2::math::min(arg3, arg1.protocol_fee_y);
        arg1.protocol_fee_x = arg1.protocol_fee_x - v0;
        arg1.protocol_fee_y = arg1.protocol_fee_y - v1;
        let v2 = CollectProtocolFee{
            sender   : 0x2::tx_context::sender(arg5),
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg1),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<CollectProtocolFee>(v2);
        take<T0, T1>(arg1, v0, v1)
    }

    public(friend) fun create<T0, T1>(arg0: u64, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id                           : 0x2::object::new(arg2),
            coin_type_x                  : 0x1::type_name::get<T0>(),
            coin_type_y                  : 0x1::type_name::get<T1>(),
            sqrt_price                   : 0,
            tick_index                   : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::zero(),
            observation_index            : 0,
            observation_cardinality      : 0,
            observation_cardinality_next : 0,
            tick_spacing                 : arg1,
            max_liquidity_per_tick       : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::tick_spacing_to_max_liquidity_per_tick(arg1),
            protocol_fee_rate            : 0,
            swap_fee_rate                : arg0,
            fee_growth_global_x          : 0,
            fee_growth_global_y          : 0,
            protocol_fee_x               : 0,
            protocol_fee_y               : 0,
            liquidity                    : 0,
            ticks                        : 0x2::table::new<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::TickInfo>(arg2),
            tick_bitmap                  : 0x2::table::new<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, u256>(arg2),
            observations                 : 0x1::vector::empty<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::Observation>(),
            locked                       : true,
            reward_infos                 : 0x1::vector::empty<PoolRewardInfo>(),
            reserve_x                    : 0x2::balance::zero<T0>(),
            reserve_y                    : 0x2::balance::zero<T1>(),
            strategy_fee_rate            : 0,
            strategy_mode                : 0,
            strategy_coin_x              : true,
            strategy_address             : @0x0,
            strategy_reserve_x           : 0x2::balance::zero<T0>(),
            strategy_reserve_y           : 0x2::balance::zero<T1>(),
        }
    }

    public fun extend_pool_reward_timestamp<T0, T1, T2>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg3);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg3);
        check_lock<T0, T1>(arg1);
        update_reward_infos<T0, T1>(arg1, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg4)));
        update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2, arg5);
    }

    public fun fee_growth_global_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_x
    }

    public fun fee_growth_global_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.fee_growth_global_y
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
        if (!v2) {
            abort 10
        };
        v1
    }

    public fun flash<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashReceipt) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg3);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg3);
        check_lock<T0, T1>(arg0);
        arg0.locked = true;
        if (arg0.liquidity == 0) {
            abort 6
        };
        let v0 = Flash{
            sender   : 0x2::tx_context::sender(arg4),
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_x : arg1,
            amount_y : arg2,
        };
        0x2::event::emit<Flash>(v0);
        let v1 = FlashReceipt{
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_x : arg1,
            amount_y : arg2,
            fee_x    : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u64::mul_div_round(arg1, arg0.swap_fee_rate, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_fee_rate_denominator_value()),
            fee_y    : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u64::mul_div_round(arg2, arg0.swap_fee_rate, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_fee_rate_denominator_value()),
        };
        (0x2::balance::split<T0>(&mut arg0.reserve_x, arg1), 0x2::balance::split<T1>(&mut arg0.reserve_y, arg2), v1)
    }

    public fun flash_receipt_debts(arg0: &FlashReceipt) : (u64, u64) {
        (arg0.amount_x + arg0.fee_x, arg0.amount_y + arg0.fee_y)
    }

    public fun increase_observation_cardinality_next<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg2);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg2);
        check_lock<T0, T1>(arg0);
        let v0 = arg0.observation_cardinality_next;
        let v1 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::grow(&mut arg0.observations, v0, arg1);
        arg0.observation_cardinality_next = v1;
        let v2 = IncreaseObservationCardinalityNext{
            sender                           : 0x2::tx_context::sender(arg3),
            pool_id                          : 0x2::object::id<Pool<T0, T1>>(arg0),
            observation_cardinality_next_old : v0,
            observation_cardinality_next_new : v1,
        };
        0x2::event::emit<IncreaseObservationCardinalityNext>(v2);
    }

    public fun increase_pool_reward<T0, T1, T2>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg3);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg3);
        check_lock<T0, T1>(arg1);
        update_reward_infos<T0, T1>(arg1, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg4)));
        update_pool_reward_emission<T0, T1, T2>(arg1, arg2, 0, arg5);
    }

    public fun initialize_pool_reward<T0, T1, T2>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg5);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg5);
        check_lock<T0, T1>(arg1);
        if (arg2 <= 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg6))) {
            abort 9
        };
        let v0 = 0x1::type_name::get<T2>();
        let v1 = PoolRewardInfo{
            reward_coin_type       : v0,
            last_update_time       : arg2,
            ended_at_seconds       : 0,
            total_reward           : 0,
            total_reward_allocated : 0,
            reward_per_seconds     : 0,
            reward_growth_global   : 0,
        };
        let v2 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        0x2::dynamic_field::add<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg1.id, v2, 0x2::balance::zero<T2>());
        0x1::vector::push_back<PoolRewardInfo>(&mut arg1.reward_infos, v1);
        let v3 = InitializePoolReward{
            sender             : 0x2::tx_context::sender(arg7),
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg1),
            reward_coin_type   : v0,
            started_at_seconds : arg2,
        };
        0x2::event::emit<InitializePoolReward>(v3);
        update_pool_reward_emission<T0, T1, T2>(arg1, arg4, arg3, arg7);
    }

    public fun is_locked<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.locked
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun max_liquidity_per_tick<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.max_liquidity_per_tick
    }

    public fun modify_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position, arg2: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::I128, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (u64, u64) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg5);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg5);
        check_lock<T0, T1>(arg0);
        check_pool_match<T0, T1>(arg0, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::pool_id(arg1));
        let (v0, v1) = modify_position<T0, T1>(arg0, arg1, arg2, arg6);
        if (!0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::is_neg(arg2)) {
            if (0x2::balance::value<T0>(&arg3) < v0 || 0x2::balance::value<T1>(&arg4) < v1) {
                abort 1
            };
            put<T0, T1>(arg0, arg3, arg4);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::destroy_zero<T1>(arg4);
            if (v0 > 0 || v1 > 0) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::increase_debt(arg1, v0, v1);
            };
        };
        let v2 = ModifyLiquidity{
            sender           : 0x2::tx_context::sender(arg7),
            pool_id          : 0x2::object::id<Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position>(arg1),
            tick_lower_index : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_lower_index(arg1),
            tick_upper_index : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_upper_index(arg1),
            liquidity_delta  : arg2,
            amount_x         : v0,
            amount_y         : v1,
        };
        0x2::event::emit<ModifyLiquidity>(v2);
        (v0, v1)
    }

    fun modify_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position, arg2: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::I128, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = !0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::is_neg(arg2);
        let v1 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_lower_index(arg1);
        let v2 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_upper_index(arg1);
        let v3 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::abs_u128(arg2);
        update_position<T0, T1>(arg0, arg1, arg2, arg3);
        if (!0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::eq(arg2, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::zero())) {
            if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::lt(arg0.tick_index, v1)) {
                (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::sqrt_price_math::get_amount_x_delta(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v1), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v2), v3, v0), 0)
            } else if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::lt(arg0.tick_index, v2)) {
                let (v6, v7) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::write(&mut arg0.observations, arg0.observation_index, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg3)), arg0.tick_index, arg0.liquidity, arg0.observation_cardinality, arg0.observation_cardinality_next);
                arg0.observation_index = v6;
                arg0.observation_cardinality = v7;
                arg0.liquidity = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::liquidity_math::add_delta(arg0.liquidity, arg2);
                (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::sqrt_price_math::get_amount_x_delta(arg0.sqrt_price, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v2), v3, v0), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::sqrt_price_math::get_amount_y_delta(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v1), arg0.sqrt_price, v3, v0))
            } else {
                (0, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::sqrt_price_math::get_amount_y_delta(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v1), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v2), v3, v0))
            }
        } else {
            (0, 0)
        }
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

    public fun pay<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: SwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg4);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg4);
        check_pool_match<T0, T1>(arg0, arg1.pool_id);
        let SwapReceipt {
            pool_id         : _,
            amount_x_debt   : v1,
            amount_y_debt   : v2,
            strategy_x_debt : v3,
            strategy_y_debt : v4,
        } = arg1;
        let v5 = if (v3 > 0) {
            0x2::balance::split<T0>(&mut arg2, v3)
        } else {
            0x2::balance::zero<T0>()
        };
        let v6 = if (v4 > 0) {
            0x2::balance::split<T1>(&mut arg3, v4)
        } else {
            0x2::balance::zero<T1>()
        };
        let (v7, v8) = reserves<T0, T1>(arg0);
        put<T0, T1>(arg0, arg2, arg3);
        let (v9, v10) = reserves<T0, T1>(arg0);
        if (v7 + v1 - v3 > v9 || v8 + v2 - v4 > v10) {
            abort 1
        };
        pay_strategy_fees<T0, T1>(arg0, v3, v4, v5, v6, arg4, arg5, arg6);
        arg0.locked = false;
        let v11 = Pay{
            sender          : 0x2::tx_context::sender(arg6),
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_x_debt   : v1,
            amount_y_debt   : v2,
            strategy_x_debt : v3,
            strategy_y_debt : v4,
            paid_x          : v9 - v7,
            paid_y          : v10 - v8,
        };
        0x2::event::emit<Pay>(v11);
    }

    fun pay_strategy_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            if (arg0.strategy_coin_x) {
                0x2::balance::join<T0>(&mut arg0.strategy_reserve_x, arg3);
            } else {
                arg0.locked = false;
                let (v0, v1, v2) = swap_internal<T0, T1>(arg0, false, true, true, 0x2::balance::value<T0>(&arg3), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::min_sqrt_price() + 1, arg5, arg6, arg7);
                0x2::balance::destroy_zero<T0>(v0);
                pay<T0, T1>(arg0, v2, arg3, 0x2::balance::zero<T1>(), arg5, arg6, arg7);
                0x2::balance::join<T1>(&mut arg0.strategy_reserve_y, v1);
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
        if (arg2 > 0) {
            if (!arg0.strategy_coin_x) {
                0x2::balance::join<T1>(&mut arg0.strategy_reserve_y, arg4);
            } else {
                arg0.locked = false;
                let (v3, v4, v5) = swap_internal<T0, T1>(arg0, false, false, true, 0x2::balance::value<T1>(&arg4), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::max_sqrt_price() - 1, arg5, arg6, arg7);
                0x2::balance::destroy_zero<T1>(v4);
                pay<T0, T1>(arg0, v5, 0x2::balance::zero<T0>(), arg4, arg5, arg6, arg7);
                0x2::balance::join<T0>(&mut arg0.strategy_reserve_x, v3);
            };
        } else {
            0x2::balance::destroy_zero<T1>(arg4);
        };
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

    fun put<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.reserve_x, arg1);
        0x2::balance::join<T1>(&mut arg0.reserve_y, arg2);
    }

    public fun repay<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: FlashReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg4);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg4);
        check_pool_match<T0, T1>(arg0, arg1.pool_id);
        let FlashReceipt {
            pool_id  : _,
            amount_x : v1,
            amount_y : v2,
            fee_x    : v3,
            fee_y    : v4,
        } = arg1;
        let (v5, v6) = reserves<T0, T1>(arg0);
        put<T0, T1>(arg0, arg2, arg3);
        let (v7, v8) = reserves<T0, T1>(arg0);
        if (v5 + v1 + v3 > v7 || v6 + v2 + v4 > v8) {
            abort 1
        };
        let v9 = v7 - v5 + v1;
        let v10 = v8 - v6 + v2;
        if (v9 > 0) {
            let v11 = arg0.protocol_fee_rate % 16;
            let v12 = if (v11 == 0) {
                0
            } else {
                v9 / v11
            };
            arg0.protocol_fee_x = arg0.protocol_fee_x + v12;
            arg0.fee_growth_global_x = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::wrapping_add(arg0.fee_growth_global_x, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::mul_div_floor(((v9 - v12) as u128), (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_q64() as u128), arg0.liquidity));
        };
        if (v10 > 0) {
            let v13 = arg0.protocol_fee_rate >> 4;
            let v14 = if (v13 == 0) {
                0
            } else {
                v10 / v13
            };
            arg0.protocol_fee_y = arg0.protocol_fee_y + v14;
            arg0.fee_growth_global_y = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::wrapping_add(arg0.fee_growth_global_y, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::mul_div_floor(((v10 - v14) as u128), (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_q64() as u128), arg0.liquidity));
        };
        arg0.locked = false;
        let v15 = Pay{
            sender          : 0x2::tx_context::sender(arg5),
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_x_debt   : v1 + v3,
            amount_y_debt   : v2 + v4,
            strategy_x_debt : 0,
            strategy_y_debt : 0,
            paid_x          : v9,
            paid_y          : v10,
        };
        0x2::event::emit<Pay>(v15);
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
        if (arg1 >= reward_length<T0, T1>(arg0)) {
            abort 11
        };
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

    public fun set_protocol_fee_rate<T0, T1>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg4);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg4);
        check_lock<T0, T1>(arg1);
        if (arg2 != 0 && (arg2 < 4 || arg2 > 10) || arg3 != 0 && (arg3 < 4 || arg3 > 10)) {
            abort 7
        };
        let v0 = arg1.protocol_fee_rate;
        arg1.protocol_fee_rate = arg2 + (arg3 << 4);
        let v1 = SetProtocolFeeRate{
            sender                  : 0x2::tx_context::sender(arg5),
            pool_id                 : 0x2::object::id<Pool<T0, T1>>(arg1),
            protocol_fee_rate_x_old : v0 % 16,
            protocol_fee_rate_y_old : v0 >> 4,
            protocol_fee_rate_x_new : arg2,
            protocol_fee_rate_y_new : arg3,
        };
        0x2::event::emit<SetProtocolFeeRate>(v1);
    }

    public fun set_strategy<T0, T1>(arg0: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::admin_cap::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: address, arg6: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg7: &0x2::tx_context::TxContext) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg6);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg6);
        check_lock<T0, T1>(arg1);
        if (arg2 + arg1.swap_fee_rate >= 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_fee_rate_denominator_value()) {
            abort 12
        };
        if (arg3 > 3) {
            abort 13
        };
        arg1.strategy_fee_rate = arg2;
        arg1.strategy_mode = arg3;
        arg1.strategy_coin_x = arg4;
        arg1.strategy_address = arg5;
        let v0 = SetStrategy{
            sender            : 0x2::tx_context::sender(arg7),
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg1),
            strategy_fee_rate : arg2,
            strategy_mode     : arg3,
            strategy_coin_x   : arg4,
            strategy_address  : arg5,
        };
        0x2::event::emit<SetStrategy>(v0);
    }

    public fun snapshot_cumulatives_inside<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, arg2: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32, arg3: &0x2::clock::Clock) : (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::I64, u256, u64) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::check_ticks(arg1, arg2, arg0.tick_spacing);
        if (!0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::is_initialized(&arg0.ticks, arg1) || !0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::is_initialized(&arg0.ticks, arg2)) {
            abort 8
        };
        if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::lt(arg0.tick_index, arg1)) {
            (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::sub(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg1), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg2)), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg1) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg2), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg1) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg2))
        } else if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::lt(arg0.tick_index, arg2)) {
            let v3 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg3));
            let (v4, v5) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::observe_single(&arg0.observations, v3, 0, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality);
            (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::sub(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::sub(v4, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg1)), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg2)), v5 - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg1) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg2), v3 - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg1) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg2))
        } else {
            (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::sub(0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg2), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_tick_cumulative_out_side(&arg0.ticks, arg1)), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg2) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_per_liquidity_out_side(&arg0.ticks, arg1), 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg2) - 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_seconds_out_side(&arg0.ticks, arg1))
        }
    }

    public fun sqrt_price_current<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.sqrt_price
    }

    public fun strategy_address<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.strategy_address
    }

    public fun strategy_coin_x<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.strategy_coin_x
    }

    public fun strategy_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.strategy_fee_rate
    }

    public fun strategy_mode<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.strategy_mode
    }

    public fun strategy_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.strategy_reserve_x), 0x2::balance::value<T1>(&arg0.strategy_reserve_y))
    }

    public fun swap_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.swap_fee_rate
    }

    fun swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapReceipt) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg6);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg6);
        check_lock<T0, T1>(arg0);
        if (arg2) {
            if (arg5 >= arg0.sqrt_price) {
                abort 4
            };
            if (arg5 <= 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::min_sqrt_price()) {
                abort 5
            };
        } else {
            if (arg5 <= arg0.sqrt_price) {
                abort 4
            };
            if (arg5 >= 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::max_sqrt_price()) {
                abort 5
            };
        };
        arg0.locked = true;
        let v0 = arg0.sqrt_price;
        let v1 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg7));
        let v2 = 0;
        let v3 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i64::zero();
        let v4 = false;
        let v5 = update_reward_infos<T0, T1>(arg0, v1);
        let v6 = if (arg3) {
            arg0.protocol_fee_rate % 16
        } else {
            arg0.protocol_fee_rate >> 4
        };
        let v7 = if (arg2) {
            arg0.fee_growth_global_x
        } else {
            arg0.fee_growth_global_y
        };
        let v8 = SwapState{
            amount_specified_remaining : arg4,
            amount_calculated          : 0,
            sqrt_price                 : arg0.sqrt_price,
            tick_index                 : arg0.tick_index,
            fee_growth_global          : v7,
            liquidity                  : arg0.liquidity,
            fee_amount                 : 0,
            protocol_fee_amount        : 0,
            strategy_fee_amount        : 0,
        };
        let v9 = if (arg1) {
            arg0.swap_fee_rate + arg0.strategy_fee_rate
        } else {
            arg0.swap_fee_rate
        };
        while (v8.amount_specified_remaining != 0 && v8.sqrt_price != arg5) {
            let v10 = SwapStepComputations{
                sqrt_price_start : 0,
                tick_index_next  : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            v10.sqrt_price_start = v8.sqrt_price;
            let (v11, v12) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_bitmap::next_initialized_tick_within_one_word(&arg0.tick_bitmap, v8.tick_index, arg0.tick_spacing, arg2);
            v10.tick_index_next = v11;
            v10.initialized = v12;
            if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::lt(v10.tick_index_next, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::min_tick())) {
                v10.tick_index_next = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::min_tick();
            } else if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::gt(v10.tick_index_next, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::max_tick())) {
                v10.tick_index_next = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::max_tick();
            };
            v10.sqrt_price_next = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_sqrt_price_at_tick(v10.tick_index_next);
            let v13 = if (arg2) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::max(v10.sqrt_price_next, arg5)
            } else {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::min(v10.sqrt_price_next, arg5)
            };
            let (v14, v15, v16, v17) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::swap_math::compute_swap_step(v8.sqrt_price, v13, v8.liquidity, v8.amount_specified_remaining, v9, arg3);
            v8.sqrt_price = v14;
            v10.amount_in = v15;
            v10.amount_out = v16;
            v10.fee_amount = v17;
            if (arg3) {
                v8.amount_specified_remaining = v8.amount_specified_remaining - v10.amount_in + v10.fee_amount;
                v8.amount_calculated = v8.amount_calculated + v10.amount_out;
            } else {
                v8.amount_specified_remaining = v8.amount_specified_remaining - v10.amount_out;
                v8.amount_calculated = v8.amount_calculated + v10.amount_in + v10.fee_amount;
            };
            if (arg1 && arg0.strategy_fee_rate > 0) {
                let v18 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u64::mul_div_floor(v10.fee_amount, arg0.strategy_fee_rate, v9);
                v10.fee_amount = v10.fee_amount - v18;
                v8.strategy_fee_amount = v8.strategy_fee_amount + v18;
            };
            if (v6 > 0) {
                let v19 = v10.fee_amount / v6;
                v10.fee_amount = v10.fee_amount - v19;
                v8.protocol_fee_amount = v8.protocol_fee_amount + v19;
            };
            if (v8.liquidity > 0) {
                v8.fee_growth_global = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::wrapping_add(v8.fee_growth_global, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::mul_div_floor((v10.fee_amount as u128), (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_q64() as u128), v8.liquidity));
            };
            v8.fee_amount = v8.fee_amount + v10.fee_amount;
            if (v8.sqrt_price == v10.sqrt_price_next) {
                let (v20, v21) = if (arg2) {
                    (v8.fee_growth_global, arg0.fee_growth_global_y)
                } else {
                    (arg0.fee_growth_global_x, v8.fee_growth_global)
                };
                if (v10.initialized) {
                    if (!v4) {
                        v4 = true;
                        let (v22, v23) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::observe_single(&arg0.observations, v1, 0, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality);
                        v3 = v22;
                        v2 = v23;
                    };
                    let v24 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::cross(&mut arg0.ticks, v10.tick_index_next, v20, v21, v5, v2, v3, v1);
                    let v25 = v24;
                    if (arg2) {
                        v25 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::neg(v24);
                    };
                    v8.liquidity = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::liquidity_math::add_delta(v8.liquidity, v25);
                };
                let v26 = if (arg2) {
                    0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::sub(v10.tick_index_next, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::from(1))
                } else {
                    v10.tick_index_next
                };
                v8.tick_index = v26;
                continue
            };
            if (v8.sqrt_price != v10.sqrt_price_start) {
                v8.tick_index = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_math::get_tick_at_sqrt_price(v8.sqrt_price);
            };
        };
        if (!0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::eq(v8.tick_index, arg0.tick_index)) {
            let (v27, v28) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::write(&mut arg0.observations, arg0.observation_index, v1, arg0.tick_index, arg0.liquidity, arg0.observation_cardinality, arg0.observation_cardinality_next);
            arg0.sqrt_price = v8.sqrt_price;
            arg0.tick_index = v8.tick_index;
            arg0.observation_index = v27;
            arg0.observation_cardinality = v28;
        } else {
            arg0.sqrt_price = v8.sqrt_price;
        };
        if (arg0.liquidity != v8.liquidity) {
            arg0.liquidity = v8.liquidity;
        };
        if (arg2) {
            arg0.fee_growth_global_x = v8.fee_growth_global;
            arg0.protocol_fee_x = arg0.protocol_fee_x + v8.protocol_fee_amount;
        } else {
            arg0.fee_growth_global_y = v8.fee_growth_global;
            arg0.protocol_fee_y = arg0.protocol_fee_y + v8.protocol_fee_amount;
        };
        let (v29, v30) = if (arg2 == arg3) {
            (arg4 - v8.amount_specified_remaining, v8.amount_calculated)
        } else {
            (v8.amount_calculated, arg4 - v8.amount_specified_remaining)
        };
        let (v31, v32, v33) = if (arg2) {
            let v34 = SwapReceipt{
                pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount_x_debt   : v29,
                amount_y_debt   : 0,
                strategy_x_debt : v8.strategy_fee_amount,
                strategy_y_debt : 0,
            };
            let (v35, v36) = take<T0, T1>(arg0, 0, v30);
            (v35, v36, v34)
        } else {
            let v37 = SwapReceipt{
                pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
                amount_x_debt   : 0,
                amount_y_debt   : v30,
                strategy_x_debt : 0,
                strategy_y_debt : v8.strategy_fee_amount,
            };
            let (v38, v39) = take<T0, T1>(arg0, v29, 0);
            (v38, v39, v37)
        };
        let v40 = Swap{
            sender              : 0x2::tx_context::sender(arg8),
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg0),
            x_for_y             : arg2,
            amount_x            : v29,
            amount_y            : v30,
            sqrt_price_before   : v0,
            sqrt_price_after    : v8.sqrt_price,
            liquidity           : v8.liquidity,
            tick_index          : v8.tick_index,
            fee_amount          : v8.fee_amount,
            protocol_fee_amount : v8.protocol_fee_amount,
            strategy_fee_amount : v8.strategy_fee_amount,
        };
        0x2::event::emit<Swap>(v40);
        (v31, v32, v33)
    }

    public fun swap_receipt_debts(arg0: &SwapReceipt) : (u64, u64) {
        (arg0.amount_x_debt, arg0.amount_y_debt)
    }

    fun take<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg0.reserve_x;
        let v1 = safe_withdraw<T0>(v0, arg1);
        let v2 = &mut arg0.reserve_y;
        (v1, safe_withdraw<T1>(v2, arg2))
    }

    public fun tick_index_current<T0, T1>(arg0: &Pool<T0, T1>) : 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i32::I32 {
        arg0.tick_index
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun total_reward<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).total_reward
    }

    public fun total_reward_allocated<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        reward_info_at<T0, T1>(arg0, arg1).total_reward_allocated
    }

    fun update_pool_reward_emission<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, find_reward_info_index<T0, T1, T2>(arg0));
        let v1 = v0.ended_at_seconds + arg2;
        if (v1 <= v0.last_update_time) {
            abort 9
        };
        v0.total_reward = v0.total_reward + 0x2::balance::value<T2>(&arg1);
        v0.ended_at_seconds = v1;
        v0.reward_per_seconds = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::mul_div_floor(((v0.total_reward - v0.total_reward_allocated) as u128), (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_q64() as u128), ((v0.ended_at_seconds - v0.last_update_time) as u128));
        let v2 = PoolRewardCustodianDfKey<T2>{dummy_field: false};
        0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<PoolRewardCustodianDfKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v2), arg1);
        let v3 = UpdatePoolRewardEmission{
            sender             : 0x2::tx_context::sender(arg3),
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_coin_type   : v0.reward_coin_type,
            total_reward       : v0.total_reward,
            ended_at_seconds   : v0.ended_at_seconds,
            reward_per_seconds : v0.reward_per_seconds,
        };
        0x2::event::emit<UpdatePoolRewardEmission>(v3);
    }

    fun update_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::Position, arg2: 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::I128, arg3: &0x2::clock::Clock) {
        let v0 = update_reward_infos<T0, T1>(arg0, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        let v1 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_lower_index(arg1);
        let v2 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::tick_upper_index(arg1);
        let (v3, v4) = if (!0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::eq(arg2, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::zero())) {
            let v5 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::utils::to_seconds(0x2::clock::timestamp_ms(arg3));
            let (v6, v7) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::oracle::observe_single(&arg0.observations, v5, 0, arg0.tick_index, arg0.observation_index, arg0.liquidity, arg0.observation_cardinality);
            let v8 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::update(&mut arg0.ticks, v1, arg0.tick_index, arg2, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0, v7, v6, v5, false, arg0.max_liquidity_per_tick);
            let v9 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::update(&mut arg0.ticks, v2, arg0.tick_index, arg2, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0, v7, v6, v5, true, arg0.max_liquidity_per_tick);
            if (v8) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, v1, arg0.tick_spacing);
            };
            if (v9) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick_bitmap::flip_tick(&mut arg0.tick_bitmap, v2, arg0.tick_spacing);
            };
            (v8, v9)
        } else {
            (false, false)
        };
        let (v10, v11, v12) = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::get_fee_and_reward_growths_inside(&arg0.ticks, v1, v2, arg0.tick_index, arg0.fee_growth_global_x, arg0.fee_growth_global_y, v0);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::position::update(arg1, arg2, v10, v11, v12);
        if (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::lt(arg2, 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::i128::zero())) {
            if (v3) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::clear(&mut arg0.ticks, v1);
            };
            if (v4) {
                0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::tick::clear(&mut arg0.ticks, v2);
            };
        };
    }

    fun update_reward_infos<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolRewardInfo>(&arg0.reward_infos)) {
            let v2 = 0x1::vector::borrow_mut<PoolRewardInfo>(&mut arg0.reward_infos, v1);
            v1 = v1 + 1;
            if (arg1 > v2.last_update_time) {
                let v3 = 0x2::math::min(arg1, v2.ended_at_seconds);
                if (arg0.liquidity != 0 && v3 > v2.last_update_time) {
                    let v4 = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::full_mul(((v3 - v2.last_update_time) as u128), v2.reward_per_seconds);
                    v2.reward_growth_global = 0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::full_math_u128::wrapping_add(v2.reward_growth_global, ((v4 / (arg0.liquidity as u256)) as u128));
                    v2.total_reward_allocated = v2.total_reward_allocated + ((v4 / (0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::constants::get_q64() as u256)) as u64);
                };
                v2.last_update_time = arg1;
            };
            0x1::vector::push_back<u128>(&mut v0, v2.reward_growth_global);
        };
        v0
    }

    public fun withdraw_strategy_balance<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::object::UID, arg2: &0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::Versioned, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_version(arg2);
        0x2536af824bffa011b336e140841652e95a3f925207a5c642ad8c7e462f781d45::versioned::check_pause(arg2);
        check_lock<T0, T1>(arg0);
        if (0x2::object::uid_to_address(arg1) != arg0.strategy_address) {
            abort 14
        };
        let v0 = 0x2::balance::value<T0>(&arg0.strategy_reserve_x);
        let v1 = 0x2::balance::value<T1>(&arg0.strategy_reserve_y);
        let v2 = WithdrawStrategyBalance{
            sender   : 0x2::tx_context::sender(arg3),
            pool_id  : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<WithdrawStrategyBalance>(v2);
        (0x2::balance::split<T0>(&mut arg0.strategy_reserve_x, v0), 0x2::balance::split<T1>(&mut arg0.strategy_reserve_y, v1))
    }

    // decompiled from Move bytecode v6
}

