module 0xa38f2f5b6df3014878ebe459fe6af07e68cea8b9cdccc5e79e70e3287cf20753::relayer_fee {
    struct RelayerFee has drop, store {
        value: u64,
        precision: u64,
    }

    public fun compute(arg0: &RelayerFee, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.value as u128) / (arg0.precision as u128)) as u64)
    }

    fun is_valid(arg0: u64, arg1: u64) : bool {
        arg1 > 0 && arg0 < arg1
    }

    public fun new(arg0: u64, arg1: u64) : RelayerFee {
        assert!(is_valid(arg0, arg1), 0);
        RelayerFee{
            value     : arg0,
            precision : arg1,
        }
    }

    public fun precision(arg0: &RelayerFee) : u64 {
        arg0.precision
    }

    public fun update(arg0: &mut RelayerFee, arg1: u64, arg2: u64) {
        assert!(is_valid(arg1, arg2), 0);
        arg0.value = arg1;
        arg0.precision = arg2;
    }

    public fun value(arg0: &RelayerFee) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

