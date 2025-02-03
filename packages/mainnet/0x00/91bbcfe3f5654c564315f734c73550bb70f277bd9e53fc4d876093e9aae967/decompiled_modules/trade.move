module 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::trade {
    struct Pay has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
        paid_x: u64,
        paid_y: u64,
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

    struct SwapReceipt {
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
    }

    struct Flash has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct SwapEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        x_for_y: bool,
        amount_x: u64,
        amount_y: u64,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        liquidity: u128,
        tick_index: 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::I32,
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

    struct FlashReceipt {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    public fun swap<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, SwapReceipt) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg6);
        assert!(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::sqrt_price<T0, T1>(arg0) != 0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::pool_not_initialised());
        if (arg1) {
            assert!(arg4 < 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::sqrt_price<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::high_slippage());
            assert!(arg4 > 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::min_sqrt_price(), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_price_limit());
        } else {
            assert!(arg4 > 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::sqrt_price<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::high_slippage());
            assert!(arg4 < 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::max_sqrt_price(), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_price_limit());
        };
        let v0 = if (arg1) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_x<T0, T1>(arg0)
        } else {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_y<T0, T1>(arg0)
        };
        let v1 = SwapState{
            amount_specified_remaining : arg3,
            amount_calculated          : 0,
            sqrt_price                 : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::sqrt_price<T0, T1>(arg0),
            tick_index                 : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_index_current<T0, T1>(arg0),
            fee_growth_global          : v0,
            protocol_fee               : 0,
            liquidity                  : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0),
            fee_amount                 : 0,
        };
        while (v1.amount_specified_remaining != 0 && v1.sqrt_price != arg4) {
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
            let (v3, v4) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_bitmap::next_initialized_tick_within_one_word(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::borrow_tick_bitmap<T0, T1>(arg0), v1.tick_index, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_spacing<T0, T1>(arg0), arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::lt(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::min_tick())) {
                v2.tick_index_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::min_tick();
            } else if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::gt(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::max_tick())) {
                v2.tick_index_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::max(v2.sqrt_price_next, arg4)
            } else {
                0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::min(v2.sqrt_price_next, arg4)
            };
            let (v6, v7, v8, v9) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::swap_math::compute_swap_step(v1.sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::swap_fee_rate<T0, T1>(arg0), arg2);
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
            if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_rate<T0, T1>(arg0) > 0) {
                let v10 = v2.fee_amount / 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_rate<T0, T1>(arg0);
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::wrapping_add(v1.fee_growth_global, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::mul_div_floor((v2.fee_amount as u128), (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u128), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            if (v1.sqrt_price == v2.sqrt_price_next) {
                let (v11, v12) = if (arg1) {
                    (v1.fee_growth_global, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_y<T0, T1>(arg0))
                } else {
                    (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_x<T0, T1>(arg0), v1.fee_growth_global)
                };
                if (v2.initialized) {
                    let (v13, v14) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::observe_single(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::borrow_observations<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg5), 0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_index_current<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observation_index<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observation_cardinality<T0, T1>(arg0));
                    let v15 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick::cross(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::ticks_mut<T0, T1>(arg0), v2.tick_index_next, v11, v12, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::update_reward_infos<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg5))), v14, v13, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg5)));
                    let v16 = v15;
                    if (arg1) {
                        v16 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i128::neg(v15);
                    };
                    v1.liquidity = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::liquidity_math::add_delta(v1.liquidity, v16);
                };
                let v17 = if (arg1) {
                    0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::sub(v2.tick_index_next, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.tick_index = v17;
                continue
            };
            if (v1.sqrt_price != v2.sqrt_price_start) {
                v1.tick_index = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::tick_math::get_tick_at_sqrt_price(v1.sqrt_price);
            };
        };
        if (!0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::i32::eq(v1.tick_index, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_index_current<T0, T1>(arg0))) {
            let (v18, v19) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::oracle::write(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observations_mut<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observation_index<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::utils::to_seconds(0x2::clock::timestamp_ms(arg5)), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::tick_index_current<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observation_cardinality<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::observation_cardinality_next<T0, T1>(arg0));
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_sqrt_price<T0, T1>(arg0, v1.sqrt_price);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_tick_index_current<T0, T1>(arg0, v1.tick_index);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_observation_index<T0, T1>(arg0, v18);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_observation_cardinality<T0, T1>(arg0, v19);
        } else {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_sqrt_price<T0, T1>(arg0, v1.sqrt_price);
        };
        if (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0) != v1.liquidity) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_liquidity<T0, T1>(arg0, v1.liquidity);
        };
        if (arg1) {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_fee_growth_global_x<T0, T1>(arg0, v1.fee_growth_global);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_protocol_fee_x<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_x<T0, T1>(arg0) + v1.protocol_fee);
        } else {
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_fee_growth_global_y<T0, T1>(arg0, v1.fee_growth_global);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_protocol_fee_y<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_y<T0, T1>(arg0) + v1.protocol_fee);
        };
        let (v20, v21) = if (arg1 == arg2) {
            (arg3 - v1.amount_specified_remaining, v1.amount_calculated)
        } else {
            (v1.amount_calculated, arg3 - v1.amount_specified_remaining)
        };
        let (v22, v23, v24) = if (arg1) {
            let v25 = SwapReceipt{
                pool_id       : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
                amount_x_debt : v20,
                amount_y_debt : 0,
            };
            let (v26, v27) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::take_from_reserves<T0, T1>(arg0, 0, v21);
            (v27, v25, v26)
        } else {
            let v28 = SwapReceipt{
                pool_id       : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
                amount_x_debt : 0,
                amount_y_debt : v21,
            };
            let (v29, v30) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::take_from_reserves<T0, T1>(arg0, v20, 0);
            (v30, v28, v29)
        };
        let v31 = SwapEvent{
            sender            : 0x2::tx_context::sender(arg7),
            pool_id           : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            x_for_y           : arg1,
            amount_x          : v20,
            amount_y          : v21,
            sqrt_price_before : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::sqrt_price<T0, T1>(arg0),
            sqrt_price_after  : v1.sqrt_price,
            liquidity         : v1.liquidity,
            tick_index        : v1.tick_index,
            fee_amount        : v1.fee_amount,
        };
        0x2::event::emit<SwapEvent>(v31);
        (v24, v22, v23)
    }

    public fun flash<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashReceipt) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg3);
        assert!(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0) > 0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::insufficient_liquidity());
        let (v0, v1) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::get_reserves<T0, T1>(arg0);
        assert!(arg1 < v0 && arg2 < v1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::insufficient_funds());
        let v2 = Flash{
            sender   : 0x2::tx_context::sender(arg4),
            pool_id  : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            amount_x : arg1,
            amount_y : arg2,
        };
        0x2::event::emit<Flash>(v2);
        let v3 = FlashReceipt{
            pool_id  : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            amount_x : arg1,
            amount_y : arg2,
            fee_x    : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u64::mul_div_round(arg1, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::swap_fee_rate<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::fee_rate_denominator()),
            fee_y    : 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u64::mul_div_round(arg2, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::swap_fee_rate<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::fee_rate_denominator()),
        };
        let (v4, v5) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::take_from_reserves<T0, T1>(arg0, arg1, arg2);
        (v4, v5, v3)
    }

    public fun flash_receipt_debts(arg0: &FlashReceipt) : (u64, u64) {
        (arg0.amount_x + arg0.fee_x, arg0.amount_y + arg0.fee_y)
    }

    public fun pay<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: SwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg4);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::verify_pool<T0, T1>(arg0, arg1.pool_id);
        let SwapReceipt {
            pool_id       : _,
            amount_x_debt : v1,
            amount_y_debt : v2,
        } = arg1;
        let (v3, v4) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::reserves<T0, T1>(arg0);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::add_to_reserves<T0, T1>(arg0, arg2, arg3);
        let (v5, v6) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::reserves<T0, T1>(arg0);
        assert!(v3 + v1 <= v5 && v4 + v2 <= v6, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_reserves_state());
        let v7 = Pay{
            sender        : 0x2::tx_context::sender(arg5),
            pool_id       : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            amount_x_debt : v1,
            amount_y_debt : v2,
            paid_x        : v5 - v3,
            paid_y        : v6 - v4,
        };
        0x2::event::emit<Pay>(v7);
    }

    public fun repay<T0, T1>(arg0: &mut 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>, arg1: FlashReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::version::assert_current_version(arg4);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::verify_pool<T0, T1>(arg0, arg1.pool_id);
        let FlashReceipt {
            pool_id  : _,
            amount_x : v1,
            amount_y : v2,
            fee_x    : v3,
            fee_y    : v4,
        } = arg1;
        let (v5, v6) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::reserves<T0, T1>(arg0);
        0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::add_to_reserves<T0, T1>(arg0, arg2, arg3);
        let (v7, v8) = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::reserves<T0, T1>(arg0);
        assert!(v5 + v1 + v3 <= v7 && v6 + v2 + v4 <= v8, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::error::invalid_reserves_state());
        let v9 = v7 - v5 + v1;
        let v10 = v8 - v6 + v2;
        if (v9 > 0) {
            let v11 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_rate<T0, T1>(arg0) % 16;
            let v12 = if (v11 == 0) {
                0
            } else {
                v9 / v11
            };
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_protocol_fee_x<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_x<T0, T1>(arg0) + v12);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_fee_growth_global_x<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::wrapping_add(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_x<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::mul_div_floor(((v9 - v12) as u128), (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u128), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0))));
        };
        if (v10 > 0) {
            let v13 = 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_rate<T0, T1>(arg0) >> 4;
            let v14 = if (v13 == 0) {
                0
            } else {
                v10 / v13
            };
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_protocol_fee_y<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::protocol_fee_y<T0, T1>(arg0) + v14);
            0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::set_fee_growth_global_y<T0, T1>(arg0, 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::wrapping_add(0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::fee_growth_global_y<T0, T1>(arg0), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::full_math_u128::mul_div_floor(((v10 - v14) as u128), (0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::constants::q64() as u128), 0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::liquidity<T0, T1>(arg0))));
        };
        let v15 = Pay{
            sender        : 0x2::tx_context::sender(arg5),
            pool_id       : 0x2::object::id<0xc139b03c2dc11423315e5b367a3db49c6171a0964ec1ba73bfa2cb8f67985083::pool::Pool<T0, T1>>(arg0),
            amount_x_debt : v1 + v3,
            amount_y_debt : v2 + v4,
            paid_x        : v9,
            paid_y        : v10,
        };
        0x2::event::emit<Pay>(v15);
    }

    public fun swap_receipt_debts(arg0: &SwapReceipt) : (u64, u64) {
        (arg0.amount_x_debt, arg0.amount_y_debt)
    }

    // decompiled from Move bytecode v6
}

