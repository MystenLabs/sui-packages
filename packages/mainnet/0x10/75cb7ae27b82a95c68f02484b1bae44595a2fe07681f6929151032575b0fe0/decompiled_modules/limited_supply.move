module 0x1075cb7ae27b82a95c68f02484b1bae44595a2fe07681f6929151032575b0fe0::limited_supply {
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
        abort 0
    }

    fun err_exceed_limit() {
        abort 1
    }

    fun err_limit_exceed_supply() {
        abort 3
    }

    fun err_supply_not_enough() {
        abort 2
    }

    public fun increase(arg0: &mut LimitedSupply, arg1: u64) : u64 {
        arg0.supply = supply(arg0) + arg1;
        if (supply(arg0) > limit(arg0)) {
            err_exceed_limit();
        };
        supply(arg0)
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
        if (arg0.limit < arg0.supply) {
            err_limit_exceed_supply();
        };
        arg0.limit = arg1;
    }

    public fun supply(arg0: &LimitedSupply) : u64 {
        arg0.supply
    }

    // decompiled from Move bytecode v6
}

