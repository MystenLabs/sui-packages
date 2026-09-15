module 0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::treasury {
    struct Treasury<phantom T0> has store {
        funds: 0x2::balance::Balance<T0>,
        funding_buffer: u64,
    }

    public fun value<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun buffer<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.funding_buffer
    }

    public(friend) fun deposit<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.funds, arg1);
    }

    public(friend) fun drain<T0>(arg0: &mut Treasury<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.funds, 0x1::u64::min(arg1, 0x2::balance::value<T0>(&arg0.funds)))
    }

    public(friend) fun new<T0>() : Treasury<T0> {
        Treasury<T0>{
            funds          : 0x2::balance::zero<T0>(),
            funding_buffer : 0,
        }
    }

    public(friend) fun set_buffer<T0>(arg0: &mut Treasury<T0>, arg1: u64) {
        arg0.funding_buffer = arg1;
    }

    public(friend) fun surplus<T0>(arg0: &mut Treasury<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        let v1 = if (v0 > arg0.funding_buffer) {
            v0 - arg0.funding_buffer
        } else {
            0
        };
        0x2::balance::split<T0>(&mut arg0.funds, v1)
    }

    // decompiled from Move bytecode v7
}

