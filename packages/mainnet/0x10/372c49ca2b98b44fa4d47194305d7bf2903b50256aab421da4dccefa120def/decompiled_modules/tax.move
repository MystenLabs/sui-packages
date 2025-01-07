module 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax {
    struct Tax<phantom T0> has copy, drop, store {
        tax_receiver: address,
        royalty: u64,
        penalty_ratio: u64,
        min_price: u64,
    }

    public fun calc_tax<T0>(arg0: &Tax<T0>, arg1: u64) : (bool, u64) {
        if (is_available<T0>(arg0, arg1)) {
            (true, arg1 * arg0.penalty_ratio / 10000)
        } else {
            (false, arg1 * arg0.royalty / 10000)
        }
    }

    public fun get_beneficiary<T0>(arg0: &Tax<T0>) : address {
        arg0.tax_receiver
    }

    public fun get_tax_ratio<T0>(arg0: &Tax<T0>) : u64 {
        arg0.penalty_ratio
    }

    public fun is_available<T0>(arg0: &Tax<T0>, arg1: u64) : bool {
        arg0.min_price >= arg1
    }

    public fun new_tax<T0>(arg0: address, arg1: u64, arg2: u64, arg3: u64) : Tax<T0> {
        Tax<T0>{
            tax_receiver  : arg0,
            royalty       : arg1,
            penalty_ratio : arg2,
            min_price     : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

