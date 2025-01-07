module 0x1b0ce8c624d17de61440d13a263527b2fd5b5a5d4b6aac286d88755125b1b32::fees {
    struct Fees has copy, drop, store {
        fee_in_percent: u256,
        fee_out_percent: u256,
    }

    public fun fee_in_percent(arg0: &Fees) : u256 {
        arg0.fee_in_percent
    }

    public fun fee_out_percent(arg0: &Fees) : u256 {
        arg0.fee_out_percent
    }

    fun get_fee_amount(arg0: u64, arg1: u256) : u64 {
        (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up((arg0 as u256), arg1, 1000000000000000000) as u64)
    }

    public fun get_fee_in_amount(arg0: &Fees, arg1: u64) : u64 {
        get_fee_amount(arg1, arg0.fee_in_percent)
    }

    public fun get_fee_out_amount(arg0: &Fees, arg1: u64) : u64 {
        get_fee_amount(arg1, arg0.fee_out_percent)
    }

    public fun get_fee_out_initial_amount(arg0: &Fees, arg1: u64) : u64 {
        get_initial_amount(arg1, arg0.fee_out_percent)
    }

    public fun get_gross_amount(arg0: &Fees, arg1: u64) : u64 {
        get_initial_amount(arg1, arg0.fee_in_percent)
    }

    fun get_initial_amount(arg0: u64, arg1: u256) : u64 {
        (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::mul_div_up((arg0 as u256), 1000000000000000000, 1000000000000000000 - arg1) as u64)
    }

    public fun new(arg0: u256, arg1: u256) : Fees {
        Fees{
            fee_in_percent  : arg0,
            fee_out_percent : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

