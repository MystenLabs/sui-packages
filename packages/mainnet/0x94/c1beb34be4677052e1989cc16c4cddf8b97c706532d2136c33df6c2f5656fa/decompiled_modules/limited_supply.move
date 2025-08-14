module 0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::limited_supply {
    struct LimitedSupply has store {
        limit: u64,
        supply: u64,
    }

    public fun decrease(arg0: &mut LimitedSupply, arg1: u64) : u64 {
        if (supply(arg0) < arg1) {
            err_supply_not_enough();
        };
        arg0.supply = supply(arg0) - arg1;
        supply(arg0)
    }

    public fun destroy(arg0: LimitedSupply) {
        let LimitedSupply {
            limit  : _,
            supply : v1,
        } = arg0;
        if (v1 > 0) {
            err_destroy_non_empty_supply();
        };
    }

    fun err_destroy_non_empty_supply() {
        abort 101
    }

    fun err_exceed_limit() {
        abort 102
    }

    fun err_supply_not_enough() {
        abort 103
    }

    public fun increasable_amount(arg0: &LimitedSupply) : u64 {
        if (limit(arg0) > supply(arg0)) {
            limit(arg0) - supply(arg0)
        } else {
            0
        }
    }

    public fun increase(arg0: &mut LimitedSupply, arg1: u64) : u64 {
        arg0.supply = supply(arg0) + arg1;
        if (supply(arg0) > limit(arg0)) {
            err_exceed_limit();
        };
        supply(arg0)
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

    // decompiled from Move bytecode v6
}

