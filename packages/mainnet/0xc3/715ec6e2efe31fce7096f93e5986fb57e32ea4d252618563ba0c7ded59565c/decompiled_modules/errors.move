module 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors {
    public fun bn_error() : u64 {
        14006
    }

    public fun division_by_zero() : u64 {
        14002
    }

    public fun overflow() : u64 {
        14001
    }

    public fun tick_invalid_perfect_ratio() : u64 {
        14005
    }

    public fun tick_out_of_bounds() : u64 {
        14003
    }

    public fun tick_ratio_out_of_bounds() : u64 {
        14004
    }

    // decompiled from Move bytecode v7
}

