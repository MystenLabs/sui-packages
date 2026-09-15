module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::treasury {
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

