module 0xa853df1e354fa41466bd92db48ed8daa373bb6759790562181ae4d3bac9c09::consts {
    struct SwapSummaryEvent<phantom T0, phantom T1> has copy, drop {
        total_in_t0: u64,
        total_in_t1: u64,
        total_out_t0: u64,
        total_out_t1: u64,
    }

    struct SwapErrorEvent has copy, drop {
        error_code: u64,
        phase: u64,
    }

    public fun cpsos() : u8 {
        150
    }

    public fun e_amount_in_too_high() : u64 {
        108
    }

    public fun e_amount_out_too_low() : u64 {
        107
    }

    public fun e_insufficient_base_balance() : u64 {
        102
    }

    public fun e_insufficient_deep_balance() : u64 {
        104
    }

    public fun e_insufficient_input_balance() : u64 {
        109
    }

    public fun e_insufficient_quantity() : u64 {
        105
    }

    public fun e_insufficient_quote_balance() : u64 {
        103
    }

    public fun e_invalid_price() : u64 {
        101
    }

    public fun e_no_error() : u64 {
        0
    }

    public fun e_order_expired() : u64 {
        106
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun new_swap_error_event(arg0: u64, arg1: u64) : SwapErrorEvent {
        SwapErrorEvent{
            error_code : arg0,
            phase      : arg1,
        }
    }

    public fun new_swap_summary_event<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : SwapSummaryEvent<T0, T1> {
        SwapSummaryEvent<T0, T1>{
            total_in_t0  : arg0,
            total_in_t1  : arg1,
            total_out_t0 : arg2,
            total_out_t1 : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

