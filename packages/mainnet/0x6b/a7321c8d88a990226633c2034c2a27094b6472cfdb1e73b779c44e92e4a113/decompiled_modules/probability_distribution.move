module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::probability_distribution {
    struct ProbabilityDistribution has copy, drop, store {
        distribution: 0x1::string::String,
        min: u64,
        max: u64,
        mean: 0x1::option::Option<u64>,
        std_dev: 0x1::option::Option<u64>,
        lambda: 0x1::option::Option<u64>,
        weighted_high: 0x1::option::Option<bool>,
    }

    public fun exponential(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2 > arg1, 1);
        assert!(arg0 > 0 && arg0 <= 184467440737095, 1);
        if (arg3) {
            arg2 - arg1 + arg0 * 100000 / 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::rand::rng(1, 100000, arg4) % (arg2 - arg1) - arg1
        } else {
            0x2::math::min(0x2::math::max(arg1 + arg0 * 100000 / 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::rand::rng(1, 100000, arg4) % (arg2 - arg1), arg1), arg2)
        }
    }

    public fun normal(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg3 > arg2, 1);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 12) {
            v1 = v1 + 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::rand::rng(arg2, arg3, arg4);
            v0 = v0 + 1;
        };
        let v2 = v1 / 12;
        if (v2 > arg0) {
            let v3 = (arg0 as u128) + (arg1 as u128) * ((v2 - arg0) as u128) / ((arg3 - arg2) as u128);
            if (v3 > (arg3 as u128)) {
                return arg3
            };
            return 0x2::math::max((v3 as u64), arg2)
        };
        let v4 = (arg1 as u128) * ((arg0 - v2) as u128) / ((arg3 - arg2) as u128);
        if (v4 > (arg0 as u128)) {
            return arg2
        };
        0x2::math::min(arg0 - (v4 as u64), arg3)
    }

    public fun sample_from_distribution(arg0: &ProbabilityDistribution, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = *0x1::string::bytes(&arg0.distribution);
        if (v0 == b"uniform") {
            return 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::rand::rng(arg0.min, arg0.max, arg1)
        };
        if (v0 == b"normal") {
            return normal(*0x1::option::borrow<u64>(&arg0.mean), *0x1::option::borrow<u64>(&arg0.std_dev), arg0.min, arg0.max, arg1)
        };
        assert!(v0 == b"exponential", 0);
        exponential(*0x1::option::borrow<u64>(&arg0.lambda), arg0.min, arg0.max, *0x1::option::borrow<bool>(&arg0.weighted_high), arg1)
    }

    // decompiled from Move bytecode v6
}

