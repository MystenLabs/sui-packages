module 0xc8825adac03f04a42ba4900aaff152c8e00b2628e7148a2a9bfed909115a17e5::utils {
    public fun check_amount_threshold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 7001);
        arg0
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    public fun partition_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    public fun plus(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    public fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

