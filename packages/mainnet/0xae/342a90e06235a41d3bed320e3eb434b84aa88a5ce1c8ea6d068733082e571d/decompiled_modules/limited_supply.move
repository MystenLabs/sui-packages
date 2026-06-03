module 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply {
    struct LimitedSupply has store {
        limit: u64,
        supply: u64,
    }

    public fun decrease(arg0: &mut LimitedSupply, arg1: u64) : u64 {
        assert!(arg0.supply >= arg1, 13906834316077563909);
        arg0.supply = arg0.supply - arg1;
        arg0.supply
    }

    public fun destroy(arg0: LimitedSupply) {
        let LimitedSupply {
            limit  : _,
            supply : v1,
        } = arg0;
        assert!(v1 == 0, 13906834273127628801);
    }

    public fun increasable_amount(arg0: &LimitedSupply) : u64 {
        if (arg0.limit > arg0.supply) {
            arg0.limit - arg0.supply
        } else {
            0
        }
    }

    public fun increase(arg0: &mut LimitedSupply, arg1: u64) : u64 {
        arg0.supply = arg0.supply + arg1;
        assert!(arg0.supply <= arg0.limit, 13906834294602596355);
        arg0.supply
    }

    public fun is_increasable(arg0: &LimitedSupply, arg1: u64) : bool {
        arg1 <= increasable_amount(arg0)
    }

    public fun limit(arg0: &LimitedSupply) : u64 {
        arg0.limit
    }

    public fun new(arg0: u64) : LimitedSupply {
        LimitedSupply{
            limit  : arg0,
            supply : 0,
        }
    }

    public fun set_limit(arg0: &mut LimitedSupply, arg1: u64) {
        arg0.limit = arg1;
    }

    public fun supply(arg0: &LimitedSupply) : u64 {
        arg0.supply
    }

    // decompiled from Move bytecode v7
}

