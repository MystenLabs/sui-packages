module 0xeaa8fa15ffe040dcf3e5d0d2611826953e7951269086d2e87a343c8c8b242ec9::memez_burner {
    struct MemezBurner has copy, drop, store {
        fee: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        target_liquidity: u64,
    }

    public(friend) fun calculate(arg0: MemezBurner, arg1: u64) : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS {
        let v0 = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(arg0.fee);
        if (v0 == 0 || arg1 == 0) {
            return 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0)
        };
        if (arg1 >= arg0.target_liquidity) {
            return 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(v0)
        };
        let v1 = 10000;
        0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(arg0.fee), 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(arg1, v1, arg0.target_liquidity), v1))
    }

    public(friend) fun new(arg0: u64, arg1: u64) : MemezBurner {
        MemezBurner{
            fee              : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg0),
            target_liquidity : arg1,
        }
    }

    public(friend) fun zero() : MemezBurner {
        MemezBurner{
            fee              : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0),
            target_liquidity : 0,
        }
    }

    // decompiled from Move bytecode v6
}

