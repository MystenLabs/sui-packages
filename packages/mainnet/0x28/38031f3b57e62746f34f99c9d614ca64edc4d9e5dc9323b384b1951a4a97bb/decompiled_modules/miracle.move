module 0x2838031f3b57e62746f34f99c9d614ca64edc4d9e5dc9323b384b1951a4a97bb::miracle {
    struct Miracle has store, key {
        id: 0x2::object::UID,
        accum_faith: u64,
        base_odds: u64,
        current_odds: u64,
        emission_per_test: u64,
        drought_tests: u64,
    }

    public fun accrue(arg0: &mut Miracle) {
        arg0.accum_faith = arg0.accum_faith + arg0.emission_per_test;
    }

    fun bump_odds_after_miss(arg0: &mut Miracle) {
        arg0.drought_tests = arg0.drought_tests + 1;
        let v0 = arg0.base_odds;
        let v1 = if (v0 / 100 == 0) {
            1
        } else {
            v0 / 100
        };
        let v2 = arg0.current_odds;
        if (v2 > v1) {
            arg0.current_odds = v2 - v1;
        } else {
            arg0.current_odds = 1;
        };
    }

    public fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Miracle {
        assert!(arg0 > 0, 0x2838031f3b57e62746f34f99c9d614ca64edc4d9e5dc9323b384b1951a4a97bb::errors::E_BAD_SPLIT());
        Miracle{
            id                : 0x2::object::new(arg2),
            accum_faith       : 0,
            base_odds         : arg0,
            current_odds      : arg0,
            emission_per_test : arg1,
            drought_tests     : 0,
        }
    }

    public fun maybe_trigger(arg0: &mut Miracle, arg1: u64) : (bool, u64) {
        let v0 = arg0.current_odds;
        assert!(v0 > 0, 0x2838031f3b57e62746f34f99c9d614ca64edc4d9e5dc9323b384b1951a4a97bb::errors::E_BAD_SPLIT());
        if (arg1 % v0 == 0) {
            let v3 = arg0.accum_faith;
            arg0.accum_faith = 0;
            reset_on_hit(arg0);
            (true, v3)
        } else {
            bump_odds_after_miss(arg0);
            (false, 0)
        }
    }

    fun reset_on_hit(arg0: &mut Miracle) {
        arg0.current_odds = arg0.base_odds;
        arg0.drought_tests = 0;
    }

    public fun set_params(arg0: &mut Miracle, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 0x2838031f3b57e62746f34f99c9d614ca64edc4d9e5dc9323b384b1951a4a97bb::errors::E_BAD_SPLIT());
        arg0.base_odds = arg1;
        arg0.current_odds = arg1;
        arg0.emission_per_test = arg2;
        arg0.drought_tests = 0;
    }

    // decompiled from Move bytecode v6
}

