module 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::proof {
    struct TradeProof<phantom T0, phantom T1, phantom T2> has drop, store {
        input: u64,
        min_output: u64,
    }

    public fun create<T0: drop, T1, T2>(arg0: T0, arg1: u64, arg2: u64) : TradeProof<T0, T1, T2> {
        TradeProof<T0, T1, T2>{
            input      : arg1,
            min_output : arg2,
        }
    }

    public fun min_price<T0: drop, T1, T2>(arg0: &TradeProof<T0, T1, T2>) : u64 {
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::math::div(arg0.input, arg0.min_output)
    }

    // decompiled from Move bytecode v6
}

