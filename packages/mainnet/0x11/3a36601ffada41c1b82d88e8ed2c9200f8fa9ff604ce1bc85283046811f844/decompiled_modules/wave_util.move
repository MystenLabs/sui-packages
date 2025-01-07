module 0x113a36601ffada41c1b82d88e8ed2c9200f8fa9ff604ce1bc85283046811f844::wave_util {
    public fun check_min_amount_and_split_percent<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
        split_percent<T0>(arg0, arg2, arg3)
    }

    public fun check_min_amount_out<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
    }

    public fun split_percent<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0 || arg1 < 10000, 1);
        0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg1 / 10000, arg2)
    }

    // decompiled from Move bytecode v6
}

