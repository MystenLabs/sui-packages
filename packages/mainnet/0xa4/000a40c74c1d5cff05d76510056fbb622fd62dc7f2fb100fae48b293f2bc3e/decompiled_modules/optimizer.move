module 0xa4000a40c74c1d5cff05d76510056fbb622fd62dc7f2fb100fae48b293f2bc3e::optimizer {
    public fun adaptive_append_book_if(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_append_book_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun adaptive_append_dlmm_if(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_append_dlmm_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun adaptive_append_secant_dlmm_if(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_append_secant_dlmm_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun adaptive_append_v3_frontier_if(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: u128, arg9: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_append_v3_frontier_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun adaptive_append_v3_if(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_append_v3_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun adaptive_cetus_read_demand(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: bool) : (u128, u128) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_cetus_read_demand(arg0, arg1, arg2)
    }

    public fun adaptive_cetus_secant_eligible(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_cetus_secant_eligible(arg0, arg1)
    }

    public fun adaptive_cetus_stop_rate(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_cetus_stop_rate(arg0, arg1)
    }

    public fun adaptive_note_reads(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_note_reads(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun adaptive_request(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun adaptive_result(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_result(arg0)
    }

    public fun adaptive_result_with_profit_floor(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch, arg1: u128) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_result_with_profit_floor(arg0, arg1)
    }

    public fun adaptive_run(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_run(arg0);
    }

    public fun adaptive_start_if(arg0: bool, arg1: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg2: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AdaptiveSearch {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::adaptive_start_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun advance_empty_boundaries(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: &mut u64, arg2: &mut u128, arg3: &mut u128, arg4: bool) : u64 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::advance_empty_boundaries(arg0, arg1, arg2, arg3, arg4)
    }

    public fun advance_segment_orderbook(arg0: u8, arg1: bool, arg2: u128, arg3: u64, arg4: bool, arg5: u128, arg6: &mut vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg7: u128) : (u128, u128, u64, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::advance_segment_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun advance_segment_v2(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::advance_segment_v2(arg0, arg1, arg2, arg3, arg4)
    }

    public fun advance_segment_v3(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: u64, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: u128) : (u128, u128, u128, u64, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::advance_segment_v3(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_linear(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : (bool, u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::affine_linear(arg0)
    }

    public fun affine_ratio(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u128, arg6: u128) : (bool, u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::affine_ratio(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_steamm_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : (bool, u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::affine_steamm_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun affine_steamm_omm(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u128) : (bool, u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::affine_steamm_omm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun affine_virtual_cpmm(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool) : (bool, u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::affine_virtual_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun aftermath_a20(arg0: u64) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_a20(arg0)
    }

    public fun aftermath_exp(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_exp(arg0)
    }

    public fun aftermath_fixed_div_up(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_fixed_div_up(arg0, arg1)
    }

    public fun aftermath_fixed_mul_down(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_fixed_mul_down(arg0, arg1)
    }

    public fun aftermath_fixed_mul_up(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_fixed_mul_up(arg0, arg1)
    }

    public fun aftermath_geometric_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_geometric_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun aftermath_ln(arg0: u256) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_ln(arg0)
    }

    public fun aftermath_ln_36(arg0: u256) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_ln_36(arg0)
    }

    public fun aftermath_log_exp_pow(arg0: u256, arg1: u256) : (u256, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_log_exp_pow(arg0, arg1)
    }

    public fun aftermath_pow_up(arg0: u256, arg1: u256) : (u256, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_pow_up(arg0, arg1)
    }

    public fun aftermath_signed(arg0: u256, arg1: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed(arg0, arg1)
    }

    public fun aftermath_signed_add(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed_add(arg0, arg1)
    }

    public fun aftermath_signed_div_u(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned, arg1: u256) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed_div_u(arg0, arg1)
    }

    public fun aftermath_signed_mul_u(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned, arg1: u256) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed_mul_u(arg0, arg1)
    }

    public fun aftermath_signed_neg(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed_neg(arg0)
    }

    public fun aftermath_signed_rem_u(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned, arg1: u256) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::AftermathSigned {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_signed_rem_u(arg0, arg1)
    }

    public fun aftermath_weights(arg0: u128) : (u64, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_weights(arg0)
    }

    public fun aftermath_x20(arg0: u64) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aftermath_x20(arg0)
    }

    public fun aligned_in_range(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::aligned_in_range(arg0, arg1, arg2, arg3)
    }

    public fun amount0_delta_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::amount0_delta_down(arg0, arg1, arg2)
    }

    public fun amount0_delta_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::amount0_delta_up(arg0, arg1, arg2)
    }

    public fun amount_in(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::amount_in(arg0)
    }

    public fun amount_lower_bound(arg0: &vector<u128>, arg1: u128) : u64 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::amount_lower_bound(arg0, arg1)
    }

    public fun amount_out(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::amount_out(arg0)
    }

    public fun apply_boundary_liquidity(arg0: &mut u128, arg1: bool, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::apply_boundary_liquidity(arg0, arg1, arg2);
    }

    public fun auxiliary_fee_estimate(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::auxiliary_fee_estimate(arg0)
    }

    public fun bolt_hop(arg0: vector<u128>) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::bolt_hop(arg0)
    }

    public fun bucket_psm_hop(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::bucket_psm_hop(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_curvature_linear() : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_curvature_linear()
    }

    public fun cap_curvature_orderbook() : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_curvature_orderbook()
    }

    public fun cap_curvature_v2(arg0: u128, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_curvature_v2(arg0, arg1)
    }

    public fun cap_curvature_v3(arg0: u128, arg1: u128, arg2: bool, arg3: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_curvature_v3(arg0, arg1, arg2, arg3)
    }

    public fun cap_inverse_linear(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>, arg4: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_inverse_linear(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_inverse_orderbook(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u128, arg5: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg6: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_inverse_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_inverse_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_inverse_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_inverse_v3(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary, arg6: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_inverse_v3(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_marginal_aftermath_geometric(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u128, arg5: u128) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_aftermath_geometric(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_marginal_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_marginal_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_linear(arg0, arg1, arg2, arg3)
    }

    public fun cap_marginal_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_orderbook(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_marginal_v2(arg0: u128, arg1: u128) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_v2(arg0, arg1)
    }

    public fun cap_marginal_v3(arg0: u128, arg1: bool) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_marginal_v3(arg0, arg1)
    }

    public fun cap_segment_quote_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_segment_quote_orderbook(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun cap_segment_quote_v2(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_segment_quote_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun cap_segment_quote_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary, arg5: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_segment_quote_v3(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun cap_upper_bucket_psm(arg0: u128, arg1: u128, arg2: bool) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_upper_bucket_psm(arg0, arg1, arg2)
    }

    public fun cap_upper_linear(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_upper_linear(arg0, arg1, arg2, arg3)
    }

    public fun cap_upper_orderbook(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_upper_orderbook(arg0, arg1, arg2, arg3, arg4)
    }

    public fun cap_upper_v2(arg0: u128, arg1: u128) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_upper_v2(arg0, arg1)
    }

    public fun cap_upper_v3(arg0: u128, arg1: bool) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::cap_upper_v3(arg0, arg1)
    }

    public fun capped_ratio_hop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::capped_ratio_hop(arg0, arg1, arg2, arg3)
    }

    public fun clmm_input_boundary(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::clmm_input_boundary(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun coarse_rejected(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::coarse_rejected(arg0)
    }

    public fun coarse_rejection() : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::coarse_rejection()
    }

    public fun coefficient_root(arg0: u256, arg1: u256, arg2: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::coefficient_root(arg0, arg1, arg2)
    }

    public fun coefficient_state(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u128, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeState {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::coefficient_state(arg0, arg1, arg2)
    }

    public fun complete(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::complete(arg0)
    }

    public fun contains_amount(arg0: &vector<u128>, arg1: u128) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::contains_amount(arg0, arg1)
    }

    public fun current_linear_segment(arg0: u64, arg1: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::current_linear_segment(arg0, arg1)
    }

    public fun current_orderbook_segment(arg0: u64, arg1: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>) : &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::current_orderbook_segment(arg0, arg1)
    }

    public fun div_ceil(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::div_ceil(arg0, arg1)
    }

    public fun div_up_u256(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::div_up_u256(arg0, arg1)
    }

    public fun dlmm_hop_from_bins_with_model(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::dlmm_hop_from_bins_with_model(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun dlmm_segment(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::dlmm_segment(arg0, arg1, arg2, arg3, arg4)
    }

    public fun dlmm_stage_from_bins_with_model_if(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool, arg7: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::dlmm_stage_from_bins_with_model_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::effective_input(arg0, arg1, arg2)
    }

    public fun effective_output(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::effective_output(arg0, arg1, arg2)
    }

    public fun empty_progressive_sample() : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ProgressiveSample {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::empty_progressive_sample()
    }

    public fun empty_result() : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::empty_result()
    }

    public fun evaluations(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u64 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::evaluations(arg0)
    }

    public fun extend_v3_prefix_cache(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3PrefixCache, arg2: u128, arg3: u64) : u64 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::extend_v3_prefix_cache(arg0, arg1, arg2, arg3)
    }

    public fun flowx_v2_exact_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::flowx_v2_exact_hop(arg0, arg1, arg2, arg3)
    }

    public fun found(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::found(arg0)
    }

    public fun gross_from_effective(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::gross_from_effective(arg0, arg1, arg2)
    }

    public fun gross_profit(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::gross_profit(arg0)
    }

    public fun hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::hasui_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun hawal_capacity_stage(arg0: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::hawal_capacity_stage(arg0)
    }

    public fun hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: bool, arg8: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::hawal_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun join_staged_route(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::join_staged_route(arg0, arg1)
    }

    public fun kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::kriya_v2_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun kriya_ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::kriya_ve33_get_y(arg0, arg1, arg2, arg3)
    }

    public fun largest_gap_midpoint(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::largest_gap_midpoint(arg0, arg1, arg2, arg3)
    }

    public fun linear_hop(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>, arg1: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_hop(arg0, arg1)
    }

    public fun linear_hop_from_capacities(arg0: vector<u128>, arg1: vector<u128>, arg2: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_hop_from_capacities(arg0, arg1, arg2)
    }

    public fun linear_input_boundary(arg0: u64, arg1: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_input_boundary(arg0, arg1)
    }

    public fun linear_marginal_fraction(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment) : (u256, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_marginal_fraction(arg0)
    }

    public fun linear_rate_hop(arg0: u128) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_rate_hop(arg0)
    }

    public fun linear_segment(arg0: u128, arg1: u128) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_segment(arg0, arg1)
    }

    public fun linear_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::linear_terminal(arg0, arg1, arg2, arg3)
    }

    public fun liquidity_after_boundary(arg0: u128, arg1: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary, arg2: bool) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::liquidity_after_boundary(arg0, arg1, arg2)
    }

    public fun log2_down(arg0: u256) : u8 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::log2_down(arg0)
    }

    public fun lst_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::lst_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun lst_ratio_hop_with_minimum(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::lst_ratio_hop_with_minimum(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun metastable_hop(arg0: vector<u128>, arg1: u8, arg2: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::metastable_hop(arg0, arg1, arg2)
    }

    public fun midpoint(arg0: u128, arg1: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::midpoint(arg0, arg1)
    }

    public fun momentum_v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::momentum_v3_current_hop(arg0, arg1, arg2, arg3)
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_div_down(arg0, arg1, arg2)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_div_up(arg0, arg1, arg2)
    }

    public fun mul_fraction_ceil(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_fraction_ceil(arg0, arg1, arg2)
    }

    public fun mul_q64_ceil(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_q64_ceil(arg0, arg1)
    }

    public fun mul_ratio_down_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_ratio_down_saturating(arg0, arg1, arg2)
    }

    public fun mul_ratio_up_saturating(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::mul_ratio_up_saturating(arg0, arg1, arg2)
    }

    public fun new_prefixCache(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3Prefix>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: bool, arg10: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3PrefixCache {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::new_prefixCache(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun new_shortfall(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookPrefix>, arg1: u128, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookShortfall {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::new_shortfall(arg0, arg1, arg2)
    }

    public fun next_sqrt_price(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::next_sqrt_price(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun next_sqrt_price_partial(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: bool) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::next_sqrt_price_partial(arg0, arg1, arg2, arg3, arg4)
    }

    public fun obric_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::obric_virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun optimize(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u128, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::optimize(arg0, arg1, arg2)
    }

    public fun optimize_coefficients(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u128, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::optimize_coefficients(arg0, arg1, arg2)
    }

    public fun optimize_selected_staged_if(arg0: bool, arg1: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg2: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::optimize_selected_staged_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun orderbook_hop(arg0: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_hop(arg0, arg1, arg2, arg3, arg4)
    }

    public fun orderbook_hop_from_vectors(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun orderbook_hop_from_vectors_with_auxiliary_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_hop_from_vectors_with_auxiliary_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun orderbook_hop_from_vectors_with_input_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_hop_from_vectors_with_input_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun orderbook_input_boundary(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_input_boundary(arg0, arg1, arg2, arg3, arg4)
    }

    public fun orderbook_rate_hop(arg0: u64, arg1: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_rate_hop(arg0, arg1)
    }

    public fun orderbook_rate_hop_with_auxiliary_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_rate_hop_with_auxiliary_fee(arg0, arg1, arg2, arg3)
    }

    public fun orderbook_rate_hop_with_input_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_rate_hop_with_input_fee(arg0, arg1, arg2, arg3)
    }

    public fun orderbook_segment(arg0: u64, arg1: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_segment(arg0, arg1)
    }

    public fun orderbook_segment_base_consumed(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_segment_base_consumed(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun orderbook_segment_output_capacity(arg0: bool, arg1: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_segment_output_capacity(arg0, arg1)
    }

    public fun orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun orderbook_stage_from_vectors_with_input_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_stage_from_vectors_with_input_fee_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun orderbook_terminal(arg0: u8, arg1: u64, arg2: bool, arg3: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::orderbook_terminal(arg0, arg1, arg2, arg3)
    }

    public fun passes_bolt_coarse_gate(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u256, arg2: bool) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::passes_bolt_coarse_gate(arg0, arg1, arg2)
    }

    public fun passes_bounded_profit_gate(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u128) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::passes_bounded_profit_gate(arg0, arg1)
    }

    public fun passes_marginal_gate(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u256) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::passes_marginal_gate(arg0, arg1)
    }

    public fun passes_state_gate(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::passes_state_gate(arg0)
    }

    public fun pqf_hop_from_prepared(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: bool, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::pqf_hop_from_prepared(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun prefix_upper_bound_virtual(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3Prefix>, arg1: u64, arg2: u128, arg3: &mut u64) : (u64, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::prefix_upper_bound_virtual(arg0, arg1, arg2, arg3)
    }

    public fun prepare_cpmm(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::PreparedCpmm {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::prepare_cpmm(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun progress_result(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeState) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::progress_result(arg0)
    }

    public fun progressive_better(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ProgressiveSample, arg1: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ProgressiveSample) : bool {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::progressive_better(arg0, arg1)
    }

    public fun q64() : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::q64()
    }

    public fun quote_bucket_psm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_bucket_psm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun quote_capped_ratio_hop(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_capped_ratio_hop(arg0, arg1, arg2, arg3, arg4)
    }

    public fun quote_cpmm_cached_with_slope(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, u256) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_cpmm_cached_with_slope(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_hasui_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun quote_hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: bool, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_hawal_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun quote_kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128, arg7: bool, arg8: u128, arg9: u128, arg10: u128, arg11: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_kriya_v2_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun quote_linear_hop_bounded_impl(arg0: u64, arg1: bool, arg2: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>, arg3: u128, arg4: &mut u64) : (u128, u8, u64, u128) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_linear_hop_bounded_impl(arg0, arg1, arg2, arg3, arg4)
    }

    public fun quote_linear_segment_value(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment, arg1: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_linear_segment_value(arg0, arg1)
    }

    public fun quote_linear_with_shortfall(arg0: u64, arg1: bool, arg2: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::LinearSegment>, arg3: u128, arg4: &mut u64, arg5: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookShortfall) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_linear_with_shortfall(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun quote_lst_ratio_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: u128, arg7: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_lst_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun quote_orderbook_hop_bounded(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_orderbook_hop_bounded(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun quote_orderbook_prefix(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookPrefix>) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_orderbook_prefix(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun quote_orderbook_segment(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg6: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_orderbook_segment(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_orderbook_segment_and_consumed_base(arg0: u8, arg1: bool, arg2: u64, arg3: bool, arg4: u128, arg5: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg6: u128) : (u128, u128) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_orderbook_segment_and_consumed_base(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun quote_orderbook_with_shortfall(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookSegment>, arg8: u128, arg9: &mut u64, arg10: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OrderbookShortfall, arg11: bool) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_orderbook_with_shortfall(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun quote_prepared_cpmm(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::PreparedCpmm, arg1: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_prepared_cpmm(arg0, arg1)
    }

    public fun quote_steamm_cpmm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_steamm_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun quote_steamm_omm_hop(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_steamm_omm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun quote_v3_cached(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_v3_cached(arg0, arg1, arg2, arg3)
    }

    public fun quote_v3_cached_with_slope(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3PrefixCache, arg2: u128, arg3: &mut u64) : (u128, u256, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_v3_cached_with_slope(arg0, arg1, arg2, arg3)
    }

    public fun quote_ve33_stable_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_ve33_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun quote_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::quote_virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun reader_price_square_limit(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>, arg1: u64) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::reader_price_square_limit(arg0, arg1)
    }

    public fun record_candidate_with_fee(arg0: u128, arg1: u128, arg2: u256, arg3: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::record_candidate_with_fee(arg0, arg1, arg2, arg3);
    }

    public fun refinement_point(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg1: &vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::refinement_point(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun replacement_stage(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::replacement_stage(arg0)
    }

    public fun reserve_prefix_window(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>, arg1: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::V3PrefixCache, arg2: u64, arg3: u64) : (u64, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::reserve_prefix_window(arg0, arg1, arg2, arg3)
    }

    public fun resume_coefficients(arg0: &mut 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeState) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::resume_coefficients(arg0);
    }

    public fun reuse_current_stage() : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::reuse_current_stage()
    }

    public fun reuse_current_stage_if(arg0: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::reuse_current_stage_if(arg0)
    }

    public fun round_down_to_quantum(arg0: u128, arg1: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::round_down_to_quantum(arg0, arg1)
    }

    public fun round_up_to_quantum(arg0: u128, arg1: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::round_up_to_quantum(arg0, arg1)
    }

    public fun route_model(arg0: &vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>) : u8 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::route_model(arg0)
    }

    public fun saturating_add(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::saturating_add(arg0, arg1)
    }

    public fun saturating_mul(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::saturating_mul(arg0, arg1)
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::search_rejection_code(arg0)
    }

    public fun sqrt_down(arg0: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::sqrt_down(arg0)
    }

    public fun stable_abs_diff(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::stable_abs_diff(arg0, arg1)
    }

    public fun stable_compute_d(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::stable_compute_d(arg0, arg1, arg2, arg3)
    }

    public fun stable_compute_d_with_limit(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64, arg4: u64) : (u256, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::stable_compute_d_with_limit(arg0, arg1, arg2, arg3, arg4)
    }

    public fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::stable_compute_y(arg0, arg1, arg2, arg3)
    }

    public fun stable_fee_remainder(arg0: u128, arg1: u64) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::stable_fee_remainder(arg0, arg1)
    }

    public fun status(arg0: &0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : u8 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::status(arg0)
    }

    public fun steamm_btoken_burn_amount(arg0: u256, arg1: u64) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_btoken_burn_amount(arg0, arg1)
    }

    public fun steamm_btoken_supplies(arg0: u128) : (u64, u64) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_btoken_supplies(arg0)
    }

    public fun steamm_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: bool, arg11: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun steamm_decimal_div(arg0: u256, arg1: u256) : (u256, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_decimal_div(arg0, arg1)
    }

    public fun steamm_decimal_mul(arg0: u256, arg1: u256) : (u256, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_decimal_mul(arg0, arg1)
    }

    public fun steamm_effective_amp(arg0: u64, arg1: bool, arg2: u256, arg3: u256, arg4: u128, arg5: u128, arg6: u8, arg7: u8) : (u64, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_effective_amp(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun steamm_omm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_omm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun steamm_omm_v2_legacy_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_omm_v2_legacy_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun steamm_omm_v2_legacy_hop_with_migration(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_omm_v2_legacy_hop_with_migration(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    public fun steamm_omm_v2_linear_btoken_output(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool, arg5: u256, arg6: u256, arg7: u256) : (u256, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_omm_v2_linear_btoken_output(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun steamm_q_compute_f(arg0: u128, arg1: u128, arg2: u128) : (u128, bool, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_compute_f(arg0, arg1, arg2)
    }

    public fun steamm_q_compute_f_prime(arg0: u128, arg1: u128, arg2: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_compute_f_prime(arg0, arg1, arg2)
    }

    public fun steamm_q_div(arg0: u128, arg1: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_div(arg0, arg1)
    }

    public fun steamm_q_floor_log2(arg0: u128) : u8 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_floor_log2(arg0)
    }

    public fun steamm_q_from_decimal(arg0: u256) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_from_decimal(arg0)
    }

    public fun steamm_q_from_integer(arg0: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_from_integer(arg0)
    }

    public fun steamm_q_ln_plus_64ln2(arg0: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_ln_plus_64ln2(arg0)
    }

    public fun steamm_q_mul(arg0: u128, arg1: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_mul(arg0, arg1)
    }

    public fun steamm_q_newton(arg0: u128, arg1: u128) : (u128, bool) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::steamm_q_newton(arg0, arg1)
    }

    public fun suiswap_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: bool, arg11: u8) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::suiswap_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun tick_boundary(arg0: u128, arg1: u128, arg2: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::tick_boundary(arg0, arg1, arg2)
    }

    public fun to_u128(arg0: u256) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::to_u128(arg0)
    }

    public fun v2_curve_output(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128) : u128 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v2_curve_output(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v2_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v2_hop(arg0, arg1, arg2, arg3)
    }

    public fun v2_hop_split_fee(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v2_hop_split_fee(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v2_hop_with_gate(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v2_hop_with_gate(arg0, arg1, arg2, arg3, arg4)
    }

    public fun v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v3_current_hop(arg0, arg1, arg2, arg3)
    }

    public fun v3_frontier_stage_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: u128, arg5: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v3_frontier_stage_if(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v3_window_stage(arg0: u128, arg1: vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::TickBoundary>) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v3_window_stage(arg0, arg1)
    }

    public fun v3_window_stage_from_vectors_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::v3_window_stage_from_vectors_if(arg0, arg1, arg2, arg3, arg4)
    }

    public fun ve33_get_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ve33_get_y(arg0, arg1, arg2, arg3)
    }

    public fun ve33_invariant(arg0: u256, arg1: u256) : u256 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ve33_invariant(arg0, arg1)
    }

    public fun ve33_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::ve33_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::virtual_cpmm_state_status(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun with_lst_redemption_bounds(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::with_lst_redemption_bounds(arg0)
    }

    public fun with_pool_balances(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg1: u64, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::with_pool_balances(arg0, arg1, arg2)
    }

    public fun with_suidex_execution_bounds(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::with_suidex_execution_bounds(arg0)
    }

    public fun with_turbos_pool_balances(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg1: u64, arg2: u64) : 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop {
        0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::with_turbos_pool_balances(arg0, arg1, arg2)
    }

    public fun pack_hops_0() : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>()
    }

    public fun pack_hops_1(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>();
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(&mut v0, arg0);
        v0
    }

    public fun pack_hops_2(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg1);
        v0
    }

    public fun pack_hops_3(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg2);
        v0
    }

    public fun pack_hops_4(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop, arg3: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg2);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::Hop>(v1, arg3);
        v0
    }

    public fun pack_results_0() : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult> {
        0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>()
    }

    public fun pack_results_1(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>();
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(&mut v0, arg0);
        v0
    }

    public fun pack_results_2(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg1);
        v0
    }

    public fun pack_results_3(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg2);
        v0
    }

    public fun pack_results_4(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult, arg3: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg2);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::OptimizeResult>(v1, arg3);
        v0
    }

    public fun pack_stages_0() : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop> {
        0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>()
    }

    public fun pack_stages_1(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>();
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(&mut v0, arg0);
        v0
    }

    public fun pack_stages_2(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg1);
        v0
    }

    public fun pack_stages_3(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg2);
        v0
    }

    public fun pack_stages_4(arg0: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg1: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg2: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop, arg3: 0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop) : vector<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg1);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg2);
        0x1::vector::push_back<0x628c531efcecca5929288ece16402afd5e6988d18d9d080bb75f73b63bae9f92::optimizer::StagedHop>(v1, arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

