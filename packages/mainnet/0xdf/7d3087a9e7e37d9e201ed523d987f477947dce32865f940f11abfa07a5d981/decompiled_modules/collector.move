module 0xdf7d3087a9e7e37d9e201ed523d987f477947dce32865f940f11abfa07a5d981::collector {
    struct Collector<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        unclaimed_amount: u64,
    }

    public(friend) fun add_unclaimed_amount<T0>(arg0: &mut Collector<T0>, arg1: u64) {
        arg0.unclaimed_amount = arg0.unclaimed_amount + arg1;
    }

    public fun borrow_balance_mut<T0>(arg0: &mut Collector<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun fill_balance<T0>(arg0: &mut Collector<T0>, arg1: &mut 0x2::balance::Balance<T0>) {
        let v0 = arg0.unclaimed_amount;
        let v1 = 0x2::balance::value<T0>(arg1);
        if (v0 <= v1) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(arg1, v0));
            arg0.unclaimed_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::withdraw_all<T0>(arg1));
            arg0.unclaimed_amount = v0 - v1;
        };
    }

    public fun new<T0>() : Collector<T0> {
        Collector<T0>{
            balance          : 0x2::balance::zero<T0>(),
            unclaimed_amount : 0,
        }
    }

    public(friend) fun set_unclaimed_amount_to_zero<T0>(arg0: &mut Collector<T0>) {
        arg0.unclaimed_amount = 0;
    }

    public fun unclaimed_amount<T0>(arg0: &Collector<T0>) : u64 {
        arg0.unclaimed_amount
    }

    // decompiled from Move bytecode v6
}

