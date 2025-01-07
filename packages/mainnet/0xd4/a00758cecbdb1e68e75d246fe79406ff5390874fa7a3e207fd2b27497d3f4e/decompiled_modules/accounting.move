module 0xd4a00758cecbdb1e68e75d246fe79406ff5390874fa7a3e207fd2b27497d3f4e::accounting {
    struct Accounting has store {
        total_to_refund: u64,
        total_raised: u64,
        total_claimed: u64,
        total_raised_for_boost: u64,
        total_boosted: u64,
    }

    public fun current_liabilities(arg0: &Accounting) : u64 {
        arg0.total_to_refund - arg0.total_claimed
    }

    public(friend) fun drop(arg0: Accounting) {
        let Accounting {
            total_to_refund        : _,
            total_raised           : _,
            total_claimed          : _,
            total_raised_for_boost : _,
            total_boosted          : _,
        } = arg0;
    }

    public(friend) fun new() : Accounting {
        Accounting{
            total_to_refund        : 0,
            total_raised           : 0,
            total_claimed          : 0,
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

    public fun total_claimed(arg0: &Accounting) : u64 {
        arg0.total_claimed
    }

    public(friend) fun total_claimed_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_claimed
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

    public fun total_to_refund(arg0: &Accounting) : u64 {
        arg0.total_to_refund
    }

    public(friend) fun total_to_refund_mut(arg0: &mut Accounting) : &mut u64 {
        &mut arg0.total_to_refund
    }

    public fun total_unclaimed(arg0: &Accounting) : u64 {
        arg0.total_raised - arg0.total_claimed
    }

    public fun total_unclaimed_boosted(arg0: &Accounting) : u64 {
        arg0.total_raised_for_boost - arg0.total_boosted
    }

    // decompiled from Move bytecode v6
}

