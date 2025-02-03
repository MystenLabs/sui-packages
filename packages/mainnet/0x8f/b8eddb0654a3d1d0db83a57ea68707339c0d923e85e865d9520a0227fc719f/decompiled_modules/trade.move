module 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::trade {
    struct FlashSwapReceipt {
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
    }

    struct FlashLoanReceipt {
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct SwapState has copy, drop {
        amount_specified_remaining: u64,
        amount_calculated: u64,
        sqrt_price: u128,
        tick_index: 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::I32,
        fee_growth_global: u128,
        protocol_fee: u64,
        liquidity: u128,
        fee_amount: u64,
    }

    struct SwapStepComputations has copy, drop {
        sqrt_price_start: u128,
        tick_index_next: 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::I32,
        initialized: bool,
        sqrt_price_next: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
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
        tick_index: 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::I32,
        fee_amount: u64,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct RepayFlashLoanEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
        actual_fee_paid_x: u64,
        actual_fee_paid_y: u64,
        reserve_x: u64,
        reserve_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct RepayFlashSwapEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x_debt: u64,
        amount_y_debt: u64,
        paid_x: u64,
        paid_y: u64,
        reserve_x: u64,
        reserve_y: u64,
    }

    struct FlashLoanEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        reserve_x: u64,
        reserve_y: u64,
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

    public fun compute_swap_result<T0, T1>(arg0: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128, arg4: u64) : SwapState {
        let v0 = if (arg1) {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_x<T0, T1>(arg0)
        } else {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_y<T0, T1>(arg0)
        };
        let v1 = SwapState{
            amount_specified_remaining : arg4,
            amount_calculated          : 0,
            sqrt_price                 : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0),
            tick_index                 : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_index_current<T0, T1>(arg0),
            fee_growth_global          : v0,
            protocol_fee               : 0,
            liquidity                  : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0),
            fee_amount                 : 0,
        };
        while (v1.amount_specified_remaining != 0 && v1.sqrt_price != arg3) {
            let v2 = SwapStepComputations{
                sqrt_price_start : 0,
                tick_index_next  : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            v2.sqrt_price_start = v1.sqrt_price;
            let (v3, v4) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_bitmap::next_initialized_tick_within_one_word(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::borrow_tick_bitmap<T0, T1>(arg0), v1.tick_index, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_spacing<T0, T1>(arg0), arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::lt(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::min_tick())) {
                v2.tick_index_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::min_tick();
            } else if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::gt(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::max_tick())) {
                v2.tick_index_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::max(v2.sqrt_price_next, arg3)
            } else {
                0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::min(v2.sqrt_price_next, arg3)
            };
            let (v6, v7, v8, v9) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::swap_math::compute_swap_step(v1.sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::swap_fee_rate<T0, T1>(arg0), arg2);
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
            if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0) > 0) {
                let v10 = v2.fee_amount / 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0);
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::wrapping_add(v1.fee_growth_global, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::mul_div_floor((v2.fee_amount as u128), (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::q64() as u128), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            if (v1.sqrt_price == v2.sqrt_price_next) {
                if (v2.initialized) {
                    let v11 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick::get_liquidity_net(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::borrow_ticks<T0, T1>(arg0), v2.tick_index_next);
                    let v12 = v11;
                    if (arg1) {
                        v12 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i128::neg(v11);
                    };
                    v1.liquidity = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::liquidity_math::add_delta(v1.liquidity, v12);
                };
                let v13 = if (arg1) {
                    0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::sub(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.tick_index = v13;
                continue
            };
            if (v1.sqrt_price != v2.sqrt_price_start) {
                v1.tick_index = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_tick_at_sqrt_price(v1.sqrt_price);
            };
        };
        v1
    }

    public fun compute_swap_result_max<T0, T1>(arg0: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u128) : SwapState {
        compute_swap_result<T0, T1>(arg0, arg1, arg2, arg3, 18446744073709551615)
    }

    public fun flash_loan<T0, T1>(arg0: &mut 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt) {
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::assert_supported_version(arg3);
        assert!(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0) > 0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::insufficient_liquidity());
        let (v0, v1) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::get_reserves<T0, T1>(arg0);
        assert!(arg1 < v0 && arg2 < v1, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::insufficient_funds());
        let v2 = FlashLoanEvent{
            sender    : 0x2::tx_context::sender(arg4),
            pool_id   : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
            amount_x  : arg1,
            amount_y  : arg2,
            reserve_x : v0,
            reserve_y : v1,
        };
        0x2::event::emit<FlashLoanEvent>(v2);
        let v3 = FlashLoanReceipt{
            pool_id  : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
            amount_x : arg1,
            amount_y : arg2,
            fee_x    : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u64::mul_div_round(arg1, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::swap_fee_rate<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::fee_rate_denominator()),
            fee_y    : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u64::mul_div_round(arg2, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::swap_fee_rate<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::fee_rate_denominator()),
        };
        let (v4, v5) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::take_from_reserves<T0, T1>(arg0, arg1, arg2);
        (v4, v5, v3)
    }

    public fun flash_receipt_debts(arg0: &FlashLoanReceipt) : (u64, u64) {
        (arg0.amount_x + arg0.fee_x, arg0.amount_y + arg0.fee_y)
    }

    public fun flash_swap<T0, T1>(arg0: &mut 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::Version, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt) {
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::assert_supported_version(arg6);
        assert!(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0) != 0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::pool_not_initialised());
        if (arg1) {
            assert!(arg4 < 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::high_slippage());
            assert!(arg4 >= 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::min_sqrt_price(), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::invalid_price_limit());
        } else {
            assert!(arg4 > 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::high_slippage());
            assert!(arg4 <= 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::max_sqrt_price(), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::invalid_price_limit());
        };
        let v0 = if (arg1) {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_x<T0, T1>(arg0)
        } else {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_y<T0, T1>(arg0)
        };
        let v1 = SwapState{
            amount_specified_remaining : arg3,
            amount_calculated          : 0,
            sqrt_price                 : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0),
            tick_index                 : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_index_current<T0, T1>(arg0),
            fee_growth_global          : v0,
            protocol_fee               : 0,
            liquidity                  : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0),
            fee_amount                 : 0,
        };
        while (v1.amount_specified_remaining != 0 && v1.sqrt_price != arg4) {
            let v2 = SwapStepComputations{
                sqrt_price_start : 0,
                tick_index_next  : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::zero(),
                initialized      : false,
                sqrt_price_next  : 0,
                amount_in        : 0,
                amount_out       : 0,
                fee_amount       : 0,
            };
            v2.sqrt_price_start = v1.sqrt_price;
            let (v3, v4) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_bitmap::next_initialized_tick_within_one_word(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::borrow_tick_bitmap<T0, T1>(arg0), v1.tick_index, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_spacing<T0, T1>(arg0), arg1);
            v2.tick_index_next = v3;
            v2.initialized = v4;
            if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::lt(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::min_tick())) {
                v2.tick_index_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::min_tick();
            } else if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::gt(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::max_tick())) {
                v2.tick_index_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::max_tick();
            };
            v2.sqrt_price_next = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_sqrt_price_at_tick(v2.tick_index_next);
            let v5 = if (arg1) {
                0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::max(v2.sqrt_price_next, arg4)
            } else {
                0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::min(v2.sqrt_price_next, arg4)
            };
            let (v6, v7, v8, v9) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::swap_math::compute_swap_step(v1.sqrt_price, v5, v1.liquidity, v1.amount_specified_remaining, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::swap_fee_rate<T0, T1>(arg0), arg2);
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
            if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0) > 0) {
                let v10 = v2.fee_amount / 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0);
                v2.fee_amount = v2.fee_amount - v10;
                v1.protocol_fee = v1.protocol_fee + v10;
            };
            if (v1.liquidity > 0) {
                v1.fee_growth_global = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::wrapping_add(v1.fee_growth_global, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::mul_div_floor((v2.fee_amount as u128), (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::q64() as u128), v1.liquidity));
            };
            v1.fee_amount = v1.fee_amount + v2.fee_amount;
            if (v1.sqrt_price == v2.sqrt_price_next) {
                let (v11, v12) = if (arg1) {
                    (v1.fee_growth_global, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_y<T0, T1>(arg0))
                } else {
                    (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_x<T0, T1>(arg0), v1.fee_growth_global)
                };
                if (v2.initialized) {
                    let (v13, v14) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::oracle::observe_single(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::borrow_observations<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg5), 0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_index_current<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observation_index<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observation_cardinality<T0, T1>(arg0));
                    let v15 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick::cross(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::ticks_mut<T0, T1>(arg0), v2.tick_index_next, v11, v12, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::update_reward_infos<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::utils::to_seconds(0x2::clock::timestamp_ms(arg5))), v14, v13, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::utils::to_seconds(0x2::clock::timestamp_ms(arg5)));
                    let v16 = v15;
                    if (arg1) {
                        v16 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i128::neg(v15);
                    };
                    v1.liquidity = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::liquidity_math::add_delta(v1.liquidity, v16);
                };
                let v17 = if (arg1) {
                    0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::sub(v2.tick_index_next, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::from(1))
                } else {
                    v2.tick_index_next
                };
                v1.tick_index = v17;
                continue
            };
            if (v1.sqrt_price != v2.sqrt_price_start) {
                v1.tick_index = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_tick_at_sqrt_price(v1.sqrt_price);
            };
        };
        if (!0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::eq(v1.tick_index, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_index_current<T0, T1>(arg0))) {
            let (v18, v19) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::oracle::write(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observations_mut<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observation_index<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::utils::to_seconds(0x2::clock::timestamp_ms(arg5)), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::tick_index_current<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observation_cardinality<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::observation_cardinality_next<T0, T1>(arg0));
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_sqrt_price<T0, T1>(arg0, v1.sqrt_price);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_tick_index_current<T0, T1>(arg0, v1.tick_index);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_observation_index<T0, T1>(arg0, v18);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_observation_cardinality<T0, T1>(arg0, v19);
        } else {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_sqrt_price<T0, T1>(arg0, v1.sqrt_price);
        };
        if (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0) != v1.liquidity) {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_liquidity<T0, T1>(arg0, v1.liquidity);
        };
        if (arg1) {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_fee_growth_global_x<T0, T1>(arg0, v1.fee_growth_global);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_protocol_fee_x<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_x<T0, T1>(arg0) + v1.protocol_fee);
        } else {
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_fee_growth_global_y<T0, T1>(arg0, v1.fee_growth_global);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_protocol_fee_y<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_y<T0, T1>(arg0) + v1.protocol_fee);
        };
        let (v20, v21) = if (arg1 == arg2) {
            (arg3 - v1.amount_specified_remaining, v1.amount_calculated)
        } else {
            (v1.amount_calculated, arg3 - v1.amount_specified_remaining)
        };
        let (v22, v23, v24) = if (arg1) {
            let v25 = FlashSwapReceipt{
                pool_id       : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
                amount_x_debt : v20,
                amount_y_debt : 0,
            };
            let (v26, v27) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::take_from_reserves<T0, T1>(arg0, 0, v21);
            (v27, v25, v26)
        } else {
            let v28 = FlashSwapReceipt{
                pool_id       : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
                amount_x_debt : 0,
                amount_y_debt : v21,
            };
            let (v29, v30) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::take_from_reserves<T0, T1>(arg0, v20, 0);
            (v30, v28, v29)
        };
        let (v31, v32) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::reserves<T0, T1>(arg0);
        let v33 = SwapEvent{
            sender            : 0x2::tx_context::sender(arg7),
            pool_id           : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
            x_for_y           : arg1,
            amount_x          : v20,
            amount_y          : v21,
            sqrt_price_before : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0),
            sqrt_price_after  : v1.sqrt_price,
            liquidity         : v1.liquidity,
            tick_index        : v1.tick_index,
            fee_amount        : v1.fee_amount,
            reserve_x         : v31,
            reserve_y         : v32,
        };
        0x2::event::emit<SwapEvent>(v33);
        (v24, v22, v23)
    }

    public fun get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg0: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: u64, arg2: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::position::Position, arg3: u128, arg4: bool, arg5: u64) : (u64, bool) {
        let (v0, v1) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::liquidity_math::get_amounts_for_liquidity(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::sqrt_price<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_sqrt_price_at_tick(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::position::tick_lower_index(arg2)), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::tick_math::get_sqrt_price_at_tick(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::position::tick_upper_index(arg2)), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0), false);
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

    public fun get_state_amount_calculated(arg0: &SwapState) : u64 {
        arg0.amount_calculated
    }

    public fun get_state_amount_specified(arg0: &SwapState) : u64 {
        arg0.amount_specified_remaining
    }

    public fun get_state_fee_amount(arg0: &SwapState) : u64 {
        arg0.fee_amount
    }

    public fun get_state_fee_growth_global(arg0: &SwapState) : u128 {
        arg0.fee_growth_global
    }

    public fun get_state_liquidity(arg0: &SwapState) : u128 {
        arg0.liquidity
    }

    public fun get_state_protocol_fee(arg0: &SwapState) : u64 {
        arg0.protocol_fee
    }

    public fun get_state_sqrt_price(arg0: &SwapState) : u128 {
        arg0.sqrt_price
    }

    public fun get_state_tick_index(arg0: &SwapState) : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::I32 {
        arg0.tick_index
    }

    public fun get_step_amount_in(arg0: &SwapStepComputations) : u64 {
        arg0.amount_in
    }

    public fun get_step_amount_out(arg0: &SwapStepComputations) : u64 {
        arg0.amount_out
    }

    public fun get_step_fee_amount(arg0: &SwapStepComputations) : u64 {
        arg0.fee_amount
    }

    public fun get_step_initialized(arg0: &SwapStepComputations) : bool {
        arg0.initialized
    }

    public fun get_step_sqrt_price_next(arg0: &SwapStepComputations) : u128 {
        arg0.sqrt_price_next
    }

    public fun get_step_sqrt_price_start(arg0: &SwapStepComputations) : u128 {
        arg0.sqrt_price_start
    }

    public fun get_step_tick_index_next(arg0: &SwapStepComputations) : 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::i32::I32 {
        arg0.tick_index_next
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: FlashLoanReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::assert_supported_version(arg4);
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::verify_pool<T0, T1>(arg0, arg1.pool_id);
        let FlashLoanReceipt {
            pool_id  : _,
            amount_x : v1,
            amount_y : v2,
            fee_x    : v3,
            fee_y    : v4,
        } = arg1;
        let (v5, v6) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::reserves<T0, T1>(arg0);
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::add_to_reserves<T0, T1>(arg0, arg2, arg3);
        let (v7, v8) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::reserves<T0, T1>(arg0);
        assert!(v5 + v1 + v3 <= v7 && v6 + v2 + v4 <= v8, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::invalid_reserves_state());
        let v9 = v7 - v5 + v1;
        let v10 = v8 - v6 + v2;
        if (v9 > 0) {
            let v11 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0) % 16;
            let v12 = if (v11 == 0) {
                0
            } else {
                v9 / v11
            };
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_protocol_fee_x<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_x<T0, T1>(arg0) + v12);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_fee_growth_global_x<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::wrapping_add(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_x<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::mul_div_floor(((v9 - v12) as u128), (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::q64() as u128), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0))));
        };
        if (v10 > 0) {
            let v13 = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_rate<T0, T1>(arg0) >> 4;
            let v14 = if (v13 == 0) {
                0
            } else {
                v10 / v13
            };
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_protocol_fee_y<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::protocol_fee_y<T0, T1>(arg0) + v14);
            0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::set_fee_growth_global_y<T0, T1>(arg0, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::wrapping_add(0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::fee_growth_global_y<T0, T1>(arg0), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::full_math_u128::mul_div_floor(((v10 - v14) as u128), (0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::constants::q64() as u128), 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::liquidity<T0, T1>(arg0))));
        };
        let v15 = RepayFlashLoanEvent{
            sender            : 0x2::tx_context::sender(arg5),
            pool_id           : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
            amount_x_debt     : v1 + v3,
            amount_y_debt     : v2 + v4,
            actual_fee_paid_x : v9,
            actual_fee_paid_y : v10,
            reserve_x         : v7,
            reserve_y         : v8,
            fee_x             : v3,
            fee_y             : v4,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v15);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>, arg1: FlashSwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::version::assert_supported_version(arg4);
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::verify_pool<T0, T1>(arg0, arg1.pool_id);
        let FlashSwapReceipt {
            pool_id       : _,
            amount_x_debt : v1,
            amount_y_debt : v2,
        } = arg1;
        let (v3, v4) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::reserves<T0, T1>(arg0);
        0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::add_to_reserves<T0, T1>(arg0, arg2, arg3);
        let (v5, v6) = 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::reserves<T0, T1>(arg0);
        assert!(v3 + v1 <= v5 && v4 + v2 <= v6, 0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::error::invalid_reserves_state());
        let v7 = RepayFlashSwapEvent{
            sender        : 0x2::tx_context::sender(arg5),
            pool_id       : 0x2::object::id<0x8fb8eddb0654a3d1d0db83a57ea68707339c0d923e85e865d9520a0227fc719f::pool::Pool<T0, T1>>(arg0),
            amount_x_debt : v1,
            amount_y_debt : v2,
            paid_x        : v5 - v3,
            paid_y        : v6 - v4,
            reserve_x     : v5,
            reserve_y     : v6,
        };
        0x2::event::emit<RepayFlashSwapEvent>(v7);
    }

    public fun swap_receipt_debts(arg0: &FlashSwapReceipt) : (u64, u64) {
        (arg0.amount_x_debt, arg0.amount_y_debt)
    }

    // decompiled from Move bytecode v6
}

