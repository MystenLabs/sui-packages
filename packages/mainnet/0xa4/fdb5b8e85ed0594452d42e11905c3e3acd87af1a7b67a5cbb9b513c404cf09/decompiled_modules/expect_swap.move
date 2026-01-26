module 0xa4fdb5b8e85ed0594452d42e11905c3e3acd87af1a7b67a5cbb9b513c404cf09::expect_swap {
    struct ExpectSwapResultEvent has copy, drop, store {
        data: 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult,
    }

    public fun compute_swap_step(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: bool) : (u256, u256, u128, u256) {
        let (v0, v1, v2, v3) = 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::clmm_math::compute_swap_step(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        ((v0 as u256), (v1 as u256), v2, (v3 as u256))
    }

    public fun step_swap_result_amount_in(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_amount_in(arg0) as u256)
    }

    public fun step_swap_result_amount_out(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_amount_out(arg0) as u256)
    }

    public fun step_swap_result_current_liquidity(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u128 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_current_liquidity(arg0)
    }

    public fun step_swap_result_current_sqrt_price(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u128 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_current_sqrt_price(arg0)
    }

    public fun step_swap_result_fee_amount(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_fee_amount(arg0) as u256)
    }

    public fun step_swap_result_remainder_amount(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u64 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_remainder_amount(arg0)
    }

    public fun step_swap_result_target_sqrt_price(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult) : u128 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::step_swap_result_target_sqrt_price(arg0)
    }

    public fun expect_swap<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : 0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun expect_swap_result_after_sqrt_price(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : u128 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_after_sqrt_price(arg0)
    }

    public fun expect_swap_result_amount_in(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_amount_in(arg0) as u256)
    }

    public fun expect_swap_result_amount_out(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_amount_out(arg0) as u256)
    }

    public fun expect_swap_result_fee_amount(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : u256 {
        (0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_fee_amount(arg0) as u256)
    }

    public fun expect_swap_result_is_exceed(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : bool {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_is_exceed(arg0)
    }

    public fun expect_swap_result_step_results(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : &vector<0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult> {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculate_swap_result_step_results(arg0)
    }

    public fun expect_swap_result_step_swap_result(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult, arg1: u64) : &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::SwapStepResult {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_step_swap_result(arg0, arg1)
    }

    public fun expect_swap_result_steps_length(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::CalculatedSwapResult) : u64 {
        0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::calculated_swap_result_steps_length(arg0)
    }

    public fun get_expect_swap_result<T0, T1>(arg0: &0x55c5787f414c53450e2721c79eb9af4a4cc939b29ad789e628eb6829018f0dee::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = ExpectSwapResultEvent{data: expect_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4)};
        0x2::event::emit<ExpectSwapResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

