module 0x93835d11de5bba7bd1dc4d180a48d82ee718d32024070247d5549aea4ddd26b9::expect_swap {
    struct ExpectSwapResultEvent has copy, drop, store {
        data: 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult,
    }

    public fun expect_swap<T0, T1>(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: bool) : (u256, u256, u128, u256) {
        let (v0, v1, v2, v3) = 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::clmm_math::compute_swap_step(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        ((v0 as u256), (v1 as u256), v2, (v3 as u256))
    }

    public fun expect_swap_result_after_sqrt_price(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : u128 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_after_sqrt_price(arg0)
    }

    public fun expect_swap_result_amount_in(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_amount_in(arg0) as u256)
    }

    public fun expect_swap_result_amount_out(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_amount_out(arg0) as u256)
    }

    public fun expect_swap_result_fee_amount(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_fee_amount(arg0) as u256)
    }

    public fun expect_swap_result_is_exceed(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : bool {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_is_exceed(arg0)
    }

    public fun expect_swap_result_step_results(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : &vector<0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult> {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculate_swap_result_step_results(arg0)
    }

    public fun expect_swap_result_step_swap_result(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult, arg1: u64) : &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_step_swap_result(arg0, arg1)
    }

    public fun expect_swap_result_steps_length(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::CalculatedSwapResult) : u64 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::calculated_swap_result_steps_length(arg0)
    }

    public fun get_expect_swap_result<T0, T1>(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = ExpectSwapResultEvent{data: expect_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<ExpectSwapResultEvent>(v0);
    }

    public fun step_swap_result_amount_in(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_amount_in(arg0) as u256)
    }

    public fun step_swap_result_amount_out(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_amount_out(arg0) as u256)
    }

    public fun step_swap_result_current_liquidity(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u128 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_current_liquidity(arg0)
    }

    public fun step_swap_result_current_sqrt_price(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u128 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_current_sqrt_price(arg0)
    }

    public fun step_swap_result_fee_amount(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u256 {
        (0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_fee_amount(arg0) as u256)
    }

    public fun step_swap_result_remainder_amount(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u64 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_remainder_amount(arg0)
    }

    public fun step_swap_result_target_sqrt_price(arg0: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::SwapStepResult) : u128 {
        0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::step_swap_result_target_sqrt_price(arg0)
    }

    // decompiled from Move bytecode v6
}

