module 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::accounting {
    struct Accounting has store {
        total_to_refund: u64,
        total_raised: u64,
        total_refunded: u64,
        total_raised_for_boost: u64,
        total_boosted: u64,
    }

    public fun current_liabilities(arg0: &Accounting) : u64 {
        arg0.total_to_refund - arg0.total_refunded
    }

    public(friend) fun new() : Accounting {
        Accounting{
            total_to_refund        : 0,
            total_raised           : 0,
            total_refunded         : 0,
            total_raised_for_boost : 0,
            total_boosted          : 0,
        }
    }

    public fun total_boosted(arg0: &Accounting) : u64 {
        arg0.total_boosted
    }

    public(friend) fun total_boosted_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_boosted
    }

    public fun total_raised(arg0: &Accounting) : u64 {
        arg0.total_raised
    }

    public fun total_raised_for_boost(arg0: &Accounting) : u64 {
        arg0.total_raised_for_boost
    }

    public(friend) fun total_raised_for_boost_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_raised_for_boost
    }

    public(friend) fun total_raised_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_raised
    }

    public fun total_refunded(arg0: &Accounting) : u64 {
        arg0.total_refunded
    }

    public(friend) fun total_refunded_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_refunded
    }

    public fun total_to_refund(arg0: &Accounting) : u64 {
        arg0.total_to_refund
    }

    public(friend) fun total_to_refund_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_to_refund
    }

    // decompiled from Move bytecode v6
}

