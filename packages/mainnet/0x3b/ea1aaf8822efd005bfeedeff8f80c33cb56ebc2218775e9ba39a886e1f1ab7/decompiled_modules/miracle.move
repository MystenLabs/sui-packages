module 0x3bea1aaf8822efd005bfeedeff8f80c33cb56ebc2218775e9ba39a886e1f1ab7::miracle {
    struct Miracle has store, key {
        id: 0x2::object::UID,
        accum_faith: u64,
        base_odds: u64,
        current_odds: u64,
        emission_per_round: u64,
        min_odds: u64,
    }

    public fun accrue(arg0: &mut Miracle) {
        arg0.accum_faith = arg0.accum_faith + arg0.emission_per_round;
    }

    public fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Miracle {
        assert!(arg0 > 0, 0x3bea1aaf8822efd005bfeedeff8f80c33cb56ebc2218775e9ba39a886e1f1ab7::errors::E_BAD_SPLIT());
        Miracle{
            id                 : 0x2::object::new(arg2),
            accum_faith        : 0,
            base_odds          : arg0,
            current_odds       : arg0,
            emission_per_round : arg1,
            min_odds           : 1,
        }
    }

    public fun maybe_hit(arg0: &mut Miracle, arg1: u64) : (bool, u64) {
        assert!(arg0.current_odds > 0, 0x3bea1aaf8822efd005bfeedeff8f80c33cb56ebc2218775e9ba39a886e1f1ab7::errors::E_BAD_SPLIT());
        if (arg1 % arg0.current_odds == 0) {
            arg0.accum_faith = 0;
            arg0.current_odds = arg0.base_odds;
            (true, arg0.accum_faith)
        } else {
            if (arg0.current_odds > arg0.min_odds) {
                arg0.current_odds = arg0.current_odds - 1;
            };
            (false, 0)
        }
    }

    public fun set_params(arg0: &mut Miracle, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 0x3bea1aaf8822efd005bfeedeff8f80c33cb56ebc2218775e9ba39a886e1f1ab7::errors::E_BAD_SPLIT());
        arg0.base_odds = arg1;
        arg0.current_odds = arg1;
        arg0.emission_per_round = arg2;
    }

    // decompiled from Move bytecode v6
}

