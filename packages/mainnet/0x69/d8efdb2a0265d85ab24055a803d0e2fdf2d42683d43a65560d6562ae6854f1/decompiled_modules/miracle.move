module 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle {
    struct Miracle has store, key {
        id: 0x2::object::UID,
        accum_faith: u64,
        base_odds: u64,
        current_odds: u64,
        emission_per_test: u64,
        drought_tests: u64,
        tests_completed: u64,
    }

    public fun accrue(arg0: &mut Miracle) {
        arg0.tests_completed = arg0.tests_completed + 1;
        let v0 = emission_for_test_number(arg0.tests_completed);
        arg0.emission_per_test = v0;
        arg0.accum_faith = arg0.accum_faith + v0;
    }

    fun bump_odds_after_miss(arg0: &mut Miracle) {
        arg0.drought_tests = arg0.drought_tests + 1;
        let v0 = arg0.current_odds * 99 / 100;
        if (v0 < 1) {
            arg0.current_odds = 1;
        } else {
            arg0.current_odds = v0;
        };
    }

    public fun create(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Miracle {
        assert!(arg0 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_BAD_SPLIT());
        Miracle{
            id                : 0x2::object::new(arg2),
            accum_faith       : 0,
            base_odds         : arg0,
            current_odds      : arg0,
            emission_per_test : arg1,
            drought_tests     : 0,
            tests_completed   : 0,
        }
    }

    fun emission_for_test_number(arg0: u64) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 69000) {
            108000000000
        } else if (arg0 <= 138000) {
            40000000000
        } else if (arg0 <= 207000) {
            18000000000
        } else if (arg0 <= 357000) {
            7000000000
        } else if (arg0 <= 607000) {
            3000000000
        } else if (arg0 <= 1433000) {
            1000000000
        } else {
            0
        }
    }

    public fun maybe_trigger(arg0: &mut Miracle, arg1: u64) : (bool, u64, u64, u64, u64) {
        let v0 = arg0.current_odds;
        assert!(v0 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_BAD_SPLIT());
        if (arg1 % v0 == 0) {
            let v6 = arg0.accum_faith;
            arg0.accum_faith = 0;
            let v7 = arg0.drought_tests;
            let v8 = staircase_phase_for_test_number(arg0.tests_completed);
            reset_on_hit(arg0);
            (true, v6, v7, v8, arg0.current_odds)
        } else {
            bump_odds_after_miss(arg0);
            (false, 0, arg0.drought_tests, 0, arg0.current_odds)
        }
    }

    fun reset_on_hit(arg0: &mut Miracle) {
        arg0.current_odds = arg0.base_odds;
        arg0.drought_tests = 0;
    }

    public fun set_params(arg0: &mut Miracle, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_BAD_SPLIT());
        arg0.base_odds = arg1;
        arg0.current_odds = arg1;
        arg0.emission_per_test = arg2;
        arg0.drought_tests = 0;
    }

    fun staircase_phase_for_test_number(arg0: u64) : u64 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 69000) {
            1
        } else if (arg0 <= 138000) {
            2
        } else if (arg0 <= 207000) {
            3
        } else if (arg0 <= 357000) {
            4
        } else if (arg0 <= 607000) {
            5
        } else if (arg0 <= 1433000) {
            6
        } else {
            7
        }
    }

    // decompiled from Move bytecode v6
}

