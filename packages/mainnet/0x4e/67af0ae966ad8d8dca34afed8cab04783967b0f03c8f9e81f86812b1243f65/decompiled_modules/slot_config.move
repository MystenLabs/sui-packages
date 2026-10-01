module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config {
    struct SlotConfig has copy, drop, store {
        layout: u8,
        reels: u64,
        rows: u64,
        symbol_count: u64,
        wild: u8,
        scatter: u8,
        strips: vector<vector<u8>>,
        paytable: vector<vector<u64>>,
        scatter_pays: vector<u64>,
        paylines: vector<vector<u8>>,
        features: u64,
        fs_trigger: u64,
        fs_award: u64,
        fs_retrigger: u64,
        fs_max_total: u64,
        mult_start: u64,
        mult_step: u64,
        mult_max: u64,
        max_win_mult: u64,
        min_bet: u64,
        max_bet: u64,
        rtp_bps: u64,
    }

    public fun draws_per_spin(arg0: &SlotConfig) : u64 {
        (1 + arg0.fs_max_total) * arg0.reels
    }

    public fun eval_work(arg0: &SlotConfig) : u64 {
        (1 + arg0.fs_max_total) * (0x1::vector::length<vector<u8>>(&arg0.paylines) * arg0.reels + arg0.reels * arg0.rows)
    }

    public fun feature_free_spins() : u64 {
        1
    }

    public fun features(arg0: &SlotConfig) : u64 {
        arg0.features
    }

    public fun fs_award(arg0: &SlotConfig) : u64 {
        arg0.fs_award
    }

    public fun fs_max_total(arg0: &SlotConfig) : u64 {
        arg0.fs_max_total
    }

    public fun fs_retrigger(arg0: &SlotConfig) : u64 {
        arg0.fs_retrigger
    }

    public fun fs_trigger(arg0: &SlotConfig) : u64 {
        arg0.fs_trigger
    }

    public fun has_free_spins(arg0: &SlotConfig) : bool {
        arg0.features & 1 != 0
    }

    public fun layout(arg0: &SlotConfig) : u8 {
        arg0.layout
    }

    public fun layout_v1() : u8 {
        1
    }

    public fun max_bet(arg0: &SlotConfig) : u64 {
        arg0.max_bet
    }

    public fun max_eval_work() : u64 {
        4000
    }

    public fun max_free_spins() : u64 {
        50
    }

    public fun max_win_mult(arg0: &SlotConfig) : u64 {
        arg0.max_win_mult
    }

    public fun max_win_mult_ceiling() : u64 {
        5000
    }

    public fun min_bet(arg0: &SlotConfig) : u64 {
        arg0.min_bet
    }

    public fun mult_max(arg0: &SlotConfig) : u64 {
        arg0.mult_max
    }

    public fun mult_start(arg0: &SlotConfig) : u64 {
        arg0.mult_start
    }

    public fun mult_step(arg0: &SlotConfig) : u64 {
        arg0.mult_step
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: vector<vector<u8>>, arg6: vector<vector<u64>>, arg7: vector<u64>, arg8: vector<vector<u8>>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64) : SlotConfig {
        let v0 = SlotConfig{
            layout       : 1,
            reels        : arg0,
            rows         : arg1,
            symbol_count : arg2,
            wild         : arg3,
            scatter      : arg4,
            strips       : arg5,
            paytable     : arg6,
            scatter_pays : arg7,
            paylines     : arg8,
            features     : arg9,
            fs_trigger   : arg10,
            fs_award     : arg11,
            fs_retrigger : arg12,
            fs_max_total : arg13,
            mult_start   : arg14,
            mult_step    : arg15,
            mult_max     : arg16,
            max_win_mult : arg17,
            min_bet      : arg18,
            max_bet      : arg19,
            rtp_bps      : arg20,
        };
        validate(&v0);
        v0
    }

    public fun none() : u8 {
        255
    }

    public fun pay(arg0: &SlotConfig, arg1: u64, arg2: u64) : u64 {
        *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.paytable, arg1), arg2)
    }

    public fun payline_count(arg0: &SlotConfig) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.paylines)
    }

    public fun paylines(arg0: &SlotConfig) : &vector<vector<u8>> {
        &arg0.paylines
    }

    public fun paytable(arg0: &SlotConfig) : &vector<vector<u64>> {
        &arg0.paytable
    }

    public fun reels(arg0: &SlotConfig) : u64 {
        arg0.reels
    }

    public fun rows(arg0: &SlotConfig) : u64 {
        arg0.rows
    }

    public fun rtp_bps(arg0: &SlotConfig) : u64 {
        arg0.rtp_bps
    }

    public fun scatter(arg0: &SlotConfig) : u8 {
        arg0.scatter
    }

    public fun scatter_pay(arg0: &SlotConfig, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.scatter_pays, arg1)
    }

    public fun scatter_pays(arg0: &SlotConfig) : &vector<u64> {
        &arg0.scatter_pays
    }

    public fun strip(arg0: &SlotConfig, arg1: u64) : &vector<u8> {
        0x1::vector::borrow<vector<u8>>(&arg0.strips, arg1)
    }

    public fun strips(arg0: &SlotConfig) : &vector<vector<u8>> {
        &arg0.strips
    }

    public fun symbol_count(arg0: &SlotConfig) : u64 {
        arg0.symbol_count
    }

    public fun validate(arg0: &SlotConfig) {
        assert!(arg0.layout == 1, 0);
        let v0 = arg0.reels;
        let v1 = arg0.rows;
        assert!(v0 >= 3 && v0 <= 6, 1);
        assert!(v1 >= 1 && v1 <= 5, 1);
        let v2 = arg0.symbol_count;
        assert!(v2 >= 2 && v2 <= 32, 3);
        let v3 = arg0.wild != 255;
        let v4 = arg0.scatter != 255;
        assert!(!v3 || (arg0.wild as u64) < v2, 6);
        assert!(!v4 || (arg0.scatter as u64) < v2, 6);
        let v5 = if (!v3) {
            true
        } else if (!v4) {
            true
        } else {
            arg0.wild != arg0.scatter
        };
        assert!(v5, 6);
        assert!(0x1::vector::length<vector<u8>>(&arg0.strips) == v0, 2);
        let v6 = 0;
        while (v6 < v0) {
            let v7 = 0x1::vector::borrow<vector<u8>>(&arg0.strips, v6);
            let v8 = 0x1::vector::length<u8>(v7);
            assert!(v8 >= v1 && v8 <= 250, 2);
            let v9 = 0;
            while (v9 < v8) {
                assert!((*0x1::vector::borrow<u8>(v7, v9) as u64) < v2, 3);
                v9 = v9 + 1;
            };
            v6 = v6 + 1;
        };
        assert!(0x1::vector::length<vector<u64>>(&arg0.paytable) == v2, 4);
        let v10 = 0;
        while (v10 < v2) {
            let v11 = 0x1::vector::borrow<vector<u64>>(&arg0.paytable, v10);
            assert!(0x1::vector::length<u64>(v11) == v0 + 1, 4);
            assert!(*0x1::vector::borrow<u64>(v11, 0) == 0, 4);
            let v12 = 0;
            while (v12 <= v0) {
                assert!(*0x1::vector::borrow<u64>(v11, v12) <= 100000, 4);
                if (v12 > 0) {
                    assert!(*0x1::vector::borrow<u64>(v11, v12) >= *0x1::vector::borrow<u64>(v11, v12 - 1), 4);
                };
                if (v4 && v10 == (arg0.scatter as u64)) {
                    assert!(*0x1::vector::borrow<u64>(v11, v12) == 0, 4);
                };
                v12 = v12 + 1;
            };
            v10 = v10 + 1;
        };
        let v13 = v0 * v1;
        assert!(0x1::vector::length<u64>(&arg0.scatter_pays) == v13 + 1, 4);
        assert!(*0x1::vector::borrow<u64>(&arg0.scatter_pays, 0) == 0, 4);
        let v14 = 0;
        while (v14 <= v13) {
            let v15 = *0x1::vector::borrow<u64>(&arg0.scatter_pays, v14);
            assert!(v15 <= 100000, 4);
            if (v14 > 0) {
                assert!(v15 >= *0x1::vector::borrow<u64>(&arg0.scatter_pays, v14 - 1), 4);
            };
            if (!v4) {
                assert!(v15 == 0, 4);
            };
            v14 = v14 + 1;
        };
        let v16 = 0x1::vector::length<vector<u8>>(&arg0.paylines);
        assert!(v16 >= 1 && v16 <= 50, 5);
        let v17 = 0;
        while (v17 < v16) {
            let v18 = 0x1::vector::borrow<vector<u8>>(&arg0.paylines, v17);
            assert!(0x1::vector::length<u8>(v18) == v0, 5);
            let v19 = 0;
            while (v19 < v0) {
                assert!((*0x1::vector::borrow<u8>(v18, v19) as u64) < v1, 5);
                v19 = v19 + 1;
            };
            let v20 = 0;
            while (v20 < v17) {
                assert!(0x1::vector::borrow<vector<u8>>(&arg0.paylines, v20) != v18, 5);
                v20 = v20 + 1;
            };
            v17 = v17 + 1;
        };
        assert!(arg0.features | 1 == 1, 11);
        if (arg0.features & 1 != 0) {
            assert!(v4, 7);
            assert!(arg0.fs_trigger >= 1 && arg0.fs_trigger <= v13, 7);
            assert!(arg0.fs_max_total >= 1 && arg0.fs_max_total <= 50, 7);
            assert!(arg0.fs_award >= 1 && arg0.fs_award <= arg0.fs_max_total, 7);
            assert!(arg0.fs_retrigger <= arg0.fs_max_total, 7);
            assert!(arg0.mult_start >= 1 && arg0.mult_start <= arg0.mult_max, 8);
            assert!(arg0.mult_max <= 100, 8);
            assert!(arg0.mult_step <= arg0.mult_max, 8);
        } else {
            let v21 = if (arg0.fs_trigger == 0) {
                if (arg0.fs_award == 0) {
                    if (arg0.fs_retrigger == 0) {
                        arg0.fs_max_total == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v21, 7);
            let v22 = if (arg0.mult_start == 1) {
                if (arg0.mult_step == 0) {
                    arg0.mult_max == 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v22, 8);
        };
        assert!((1 + arg0.fs_max_total) * (v16 * v0 + v13) <= 4000, 12);
        assert!(arg0.max_win_mult >= 2 && arg0.max_win_mult <= 5000, 9);
        assert!(arg0.min_bet >= 1000000, 10);
        assert!(arg0.max_bet == 0 || arg0.max_bet >= arg0.min_bet, 10);
        assert!(arg0.rtp_bps >= 8000 && arg0.rtp_bps <= 9900, 13);
    }

    public fun wild(arg0: &SlotConfig) : u8 {
        arg0.wild
    }

    public fun with_max_win_mult(arg0: SlotConfig, arg1: u64) : SlotConfig {
        arg0.max_win_mult = arg1;
        validate(&arg0);
        arg0
    }

    // decompiled from Move bytecode v7
}

