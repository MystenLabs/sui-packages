module 0x7f573fefe6717f4bd3d1ebacc51f0d89cb26b39af82ed705a94da2f71f3098e2::godlode {
    struct Godlode has store, key {
        id: 0x2::object::UID,
        accum_faith: u64,
        odds: u64,
        emission_per_round: u64,
    }

    public fun accrue(arg0: &mut Godlode) {
        arg0.accum_faith = arg0.accum_faith + arg0.emission_per_round;
    }

    public fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Godlode {
        Godlode{
            id                 : 0x2::object::new(arg2),
            accum_faith        : 0,
            odds               : arg0,
            emission_per_round : arg1,
        }
    }

    public fun maybe_hit(arg0: &mut Godlode, arg1: u64) : (bool, u64) {
        if (arg1 % arg0.odds == 0) {
            arg0.accum_faith = 0;
            (true, arg0.accum_faith)
        } else {
            (false, 0)
        }
    }

    // decompiled from Move bytecode v6
}

