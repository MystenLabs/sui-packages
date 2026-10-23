module 0xdd578b94c7eb51999f730c04050f01a4e64cb65a3a8059f89f387e76842e85a0::optimizer {
    public fun adaptive_append_book_run(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_book_run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun adaptive_append_dlmm_run(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_dlmm_run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun adaptive_append_secant_dlmm_if(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u128>, arg5: vector<u64>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_secant_dlmm_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun adaptive_append_v3_frontier_run(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: u128, arg9: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_frontier_run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun adaptive_append_v3_run(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_append_v3_run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun adaptive_book_request(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::BookReadDemand) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_book_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun adaptive_cetus_read_demand(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_cetus_read_demand(arg0, arg1)
    }

    public fun adaptive_cetus_secant_eligible(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_cetus_secant_eligible(arg0, arg1)
    }

    public fun adaptive_cetus_stop_rate(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_cetus_stop_rate(arg0, arg1)
    }

    public fun adaptive_note_reads(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_note_reads(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun adaptive_request(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun adaptive_result(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_result(arg0)
    }

    public fun adaptive_result_with_profit_floor(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u128) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_result_with_profit_floor(arg0, arg1)
    }

    public fun adaptive_run(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_run(arg0);
    }

    public fun adaptive_start_if(arg0: bool, arg1: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg2: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_start_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun adaptive_v3_request(arg0: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::AdaptiveSearch, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, bool, 0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::V3ReadDemand) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::adaptive_v3_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun aftermath_geometric_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::aftermath_geometric_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun amount_in(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::amount_in(arg0)
    }

    public fun amount_lower_bound(arg0: &vector<u128>, arg1: u128) : u64 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::amount_lower_bound(arg0, arg1)
    }

    public fun auxiliary_fee_estimate(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::auxiliary_fee_estimate(arg0)
    }

    public fun bolt_hop(arg0: vector<u128>) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::bolt_hop(arg0)
    }

    public fun bucket_psm_hop(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::bucket_psm_hop(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun capped_ratio_hop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::capped_ratio_hop(arg0, arg1, arg2, arg3)
    }

    public fun coarse_rejected(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::coarse_rejected(arg0)
    }

    public fun coarse_rejection() : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::coarse_rejection()
    }

    public fun coefficient_state(arg0: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: u128, arg2: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeState {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::coefficient_state(arg0, arg1, arg2)
    }

    public fun complete(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::complete(arg0)
    }

    public fun contains_amount(arg0: &vector<u128>, arg1: u128) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::contains_amount(arg0, arg1)
    }

    public fun dlmm_hop_from_bins_with_model(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::dlmm_hop_from_bins_with_model(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun dlmm_stage_from_bins_with_model_if(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool, arg5: bool, arg6: bool, arg7: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::dlmm_stage_from_bins_with_model_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun effective_input(arg0: u128, arg1: u64, arg2: u64) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::effective_input(arg0, arg1, arg2)
    }

    public fun empty_progressive_sample() : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::ProgressiveSample {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::empty_progressive_sample()
    }

    public fun empty_result() : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::empty_result()
    }

    public fun flowx_v2_exact_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::flowx_v2_exact_hop(arg0, arg1, arg2, arg3)
    }

    public fun found(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::found(arg0)
    }

    public fun gross_profit(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::gross_profit(arg0)
    }

    public fun hasui_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::hasui_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun hawal_capacity_stage(arg0: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::hawal_capacity_stage(arg0)
    }

    public fun hawal_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: bool, arg8: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::hawal_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun join_staged_route(arg0: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::join_staged_route(arg0, arg1)
    }

    public fun kriya_v2_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::kriya_v2_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun linear_hop(arg0: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::LinearSegment>, arg1: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::linear_hop(arg0, arg1)
    }

    public fun linear_hop_from_capacities(arg0: vector<u128>, arg1: vector<u128>, arg2: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::linear_hop_from_capacities(arg0, arg1, arg2)
    }

    public fun linear_rate_hop(arg0: u128) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::linear_rate_hop(arg0)
    }

    public fun lst_ratio_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::lst_ratio_hop(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun lst_ratio_hop_with_minimum(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::lst_ratio_hop_with_minimum(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun metastable_hop(arg0: vector<u128>, arg1: u8, arg2: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::metastable_hop(arg0, arg1, arg2)
    }

    public fun midpoint(arg0: u128, arg1: u128) : u128 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::midpoint(arg0, arg1)
    }

    public fun momentum_v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::momentum_v3_current_hop(arg0, arg1, arg2, arg3)
    }

    public fun obric_virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::obric_virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun optimize_selected_staged_if(arg0: bool, arg1: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg2: vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::optimize_selected_staged_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun orderbook_hop(arg0: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::OrderbookSegment>, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_hop(arg0, arg1, arg2, arg3, arg4)
    }

    public fun orderbook_hop_from_vectors(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_hop_from_vectors(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun orderbook_hop_from_vectors_with_auxiliary_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_hop_from_vectors_with_auxiliary_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun orderbook_hop_from_vectors_with_input_fee(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_hop_from_vectors_with_input_fee(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun orderbook_rate_hop(arg0: u64, arg1: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_rate_hop(arg0, arg1)
    }

    public fun orderbook_rate_hop_with_auxiliary_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_rate_hop_with_auxiliary_fee(arg0, arg1, arg2, arg3)
    }

    public fun orderbook_rate_hop_with_input_fee(arg0: u64, arg1: bool, arg2: u64, arg3: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_rate_hop_with_input_fee(arg0, arg1, arg2, arg3)
    }

    public fun orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_stage_from_vectors_with_auxiliary_fee_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun orderbook_stage_from_vectors_with_input_fee_if(arg0: vector<u64>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::orderbook_stage_from_vectors_with_input_fee_if(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun passes_bolt_coarse_gate(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: u256, arg2: bool) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::passes_bolt_coarse_gate(arg0, arg1, arg2)
    }

    public fun passes_bounded_profit_gate(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: u128) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::passes_bounded_profit_gate(arg0, arg1)
    }

    public fun passes_marginal_gate(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: u256) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::passes_marginal_gate(arg0, arg1)
    }

    public fun passes_state_gate(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::passes_state_gate(arg0)
    }

    public fun pqf_hop_from_prepared(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: bool, arg4: bool, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::pqf_hop_from_prepared(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun progressive_better(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::ProgressiveSample, arg1: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::ProgressiveSample) : bool {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::progressive_better(arg0, arg1)
    }

    public fun reader_price_square_limit(arg0: &vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>, arg1: u64) : u256 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::reader_price_square_limit(arg0, arg1)
    }

    public fun record_candidate_with_fee(arg0: u128, arg1: u128, arg2: u256, arg3: &mut 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::record_candidate_with_fee(arg0, arg1, arg2, arg3);
    }

    public fun replacement_stage(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::replacement_stage(arg0)
    }

    public fun reuse_current_stage() : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::reuse_current_stage()
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::search_rejection_code(arg0)
    }

    public fun status(arg0: &0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : u8 {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::status(arg0)
    }

    public fun steamm_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: bool, arg11: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::steamm_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun steamm_omm_hop(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::steamm_omm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun steamm_omm_v2_legacy_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::steamm_omm_v2_legacy_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
    }

    public fun steamm_omm_v2_legacy_hop_with_migration(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::steamm_omm_v2_legacy_hop_with_migration(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    public fun suiswap_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: bool, arg11: u8) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::suiswap_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun v2_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v2_hop(arg0, arg1, arg2, arg3)
    }

    public fun v2_hop_split_fee(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v2_hop_split_fee(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v2_hop_with_gate(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v2_hop_with_gate(arg0, arg1, arg2, arg3, arg4)
    }

    public fun v3_current_hop(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v3_current_hop(arg0, arg1, arg2, arg3)
    }

    public fun v3_frontier_stage_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: u128, arg5: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v3_frontier_stage_if(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun v3_window_stage(arg0: u128, arg1: vector<0xc7cf0965203fdf3e696d4b033fbe5c845fddeadd0be9d50dcf838a7241d3236e::windows::TickBoundary>) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v3_window_stage(arg0, arg1)
    }

    public fun v3_window_stage_from_vectors_if(arg0: u128, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<bool>, arg4: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::v3_window_stage_from_vectors_if(arg0, arg1, arg2, arg3, arg4)
    }

    public fun ve33_stable_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::ve33_stable_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun virtual_cpmm_hop(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::virtual_cpmm_hop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun with_lst_redemption_bounds(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::with_lst_redemption_bounds(arg0)
    }

    public fun with_pool_balances(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg1: u64, arg2: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::with_pool_balances(arg0, arg1, arg2)
    }

    public fun with_suidex_execution_bounds(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::with_suidex_execution_bounds(arg0)
    }

    public fun with_turbos_pool_balances(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg1: u64, arg2: u64) : 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop {
        0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::with_turbos_pool_balances(arg0, arg1, arg2)
    }

    public fun pack_hops_0() : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>()
    }

    public fun pack_hops_1(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>();
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(&mut v0, arg0);
        v0
    }

    public fun pack_hops_2(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg1);
        v0
    }

    public fun pack_hops_3(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg2);
        v0
    }

    public fun pack_hops_4(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop, arg3: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg2);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::Hop>(v1, arg3);
        v0
    }

    public fun pack_results_0() : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult> {
        0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>()
    }

    public fun pack_results_1(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>();
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(&mut v0, arg0);
        v0
    }

    public fun pack_results_2(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg1);
        v0
    }

    public fun pack_results_3(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg2);
        v0
    }

    public fun pack_results_4(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult, arg3: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg2);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::OptimizeResult>(v1, arg3);
        v0
    }

    public fun pack_stages_0() : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop> {
        0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>()
    }

    public fun pack_stages_1(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>();
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(&mut v0, arg0);
        v0
    }

    public fun pack_stages_2(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg1);
        v0
    }

    public fun pack_stages_3(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg2);
        v0
    }

    public fun pack_stages_4(arg0: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg1: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg2: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop, arg3: 0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop) : vector<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop> {
        let v0 = 0x1::vector::empty<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg0);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg1);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg2);
        0x1::vector::push_back<0x817b973d14daa9a20444c8bda8e6e738ad0268817eb35be7dd6755ec61582314::optimizer::StagedHop>(v1, arg3);
        v0
    }

    // decompiled from Move bytecode v7
}

