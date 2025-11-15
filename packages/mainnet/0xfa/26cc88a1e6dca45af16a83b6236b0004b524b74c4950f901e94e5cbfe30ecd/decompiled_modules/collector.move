module 0x4f1c5c376f4ad4e33a9010d2b604352b69c5d94150c3897e2ae83ec0f6a07175::collector {
    struct Collector<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        claimable_amount: u64,
        claimed_amount: u64,
        unfilled_amount: u64,
        accumulated_amount: u64,
    }

    public(friend) fun add_accumulated_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.accumulated_amount = arg0.accumulated_amount + arg1;
    }

    public(friend) fun add_claimable_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.claimable_amount = arg0.claimable_amount + arg1;
    }

    public(friend) fun add_claimed_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.claimed_amount = arg0.claimed_amount + arg1;
    }

    public(friend) fun add_unfilled_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.unfilled_amount = arg0.unfilled_amount + arg1;
    }

    public fun borrow_balance_mut<T0>(arg0: &mut Collector<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun claimable_amount<T0>(arg0: &Collector<T0>) : u64 {
        arg0.claimable_amount
    }

    public fun claimed_amount<T0>(arg0: &Collector<T0>) : u64 {
        arg0.claimed_amount
    }

    public fun fill_balance<T0>(arg0: &mut Collector<T0>, arg1: &mut 0x2::balance::Balance<T0>) {
        let v0 = arg0.unfilled_amount;
        let v1 = 0x2::balance::value<T0>(arg1);
        if (v0 <= v1) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(arg1, v0));
            arg0.unfilled_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::withdraw_all<T0>(arg1));
            arg0.unfilled_amount = v0 - v1;
        };
    }

    public fun new<T0>() : Collector<T0> {
        Collector<T0>{
            balance            : 0x2::balance::zero<T0>(),
            claimable_amount   : 0,
            claimed_amount     : 0,
            unfilled_amount    : 0,
            accumulated_amount : 0,
        }
    }

    public(friend) fun record_claim_unfilled_amount<T0>(arg0: &mut Collector<T0>) {
        let v0 = arg0.unfilled_amount;
        arg0.unfilled_amount = 0;
        arg0.claimed_amount = arg0.claimed_amount + v0;
        arg0.claimable_amount = arg0.claimable_amount - v0;
    }

    public(friend) fun sub_accumulated_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.accumulated_amount = arg0.accumulated_amount - arg1;
    }

    public(friend) fun sub_claimable_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.claimable_amount = arg0.claimable_amount - arg1;
    }

    public(friend) fun sub_claimed_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.claimed_amount = arg0.claimed_amount - arg1;
    }

    public(friend) fun sub_unfilled_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.unfilled_amount = arg0.unfilled_amount - arg1;
    }

    public fun unfilled_amount<T0>(arg0: &Collector<T0>) : u64 {
        arg0.unfilled_amount
    }

    // decompiled from Move bytecode v6
}

