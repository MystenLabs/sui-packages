module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params {
    struct Params has copy, drop, store {
        max_leverage: u64,
        buffer_wad: u64,
        deadband_wad: u64,
        haircut_b_wad: u64,
        haircut_h_wad: u64,
        loss_fee_wad: u64,
        win_fee_wad: u64,
        close_fee_wad: u64,
        team_loss_fee_share_wad: u64,
        team_win_fee_share_wad: u64,
        team_overflow_share_wad: u64,
        pool_cap: u64,
        min_sweep: u64,
        paper_rate: u64,
        paper_threshold: u64,
        paper_decay_s: u64,
        max_position_notional: u64,
        max_user_notional: u64,
        min_margin: u64,
        ref_bonus_wad: u64,
        ref_bonus2_wad: u64,
    }

    public fun bps() : u64 {
        100000000000000
    }

    public fun buffer_wad(arg0: &Params) : u64 {
        arg0.buffer_wad
    }

    public fun close_fee_wad(arg0: &Params) : u64 {
        arg0.close_fee_wad
    }

    public fun deadband_wad(arg0: &Params) : u64 {
        arg0.deadband_wad
    }

    public fun haircut_b_wad(arg0: &Params) : u64 {
        arg0.haircut_b_wad
    }

    public fun haircut_h_wad(arg0: &Params) : u64 {
        arg0.haircut_h_wad
    }

    public fun launch() : Params {
        Params{
            max_leverage            : 1000,
            buffer_wad              : 7 * 100000000000000,
            deadband_wad            : 1000000000000000000 / 50000,
            haircut_b_wad           : 1000000000000000000 / 10,
            haircut_h_wad           : 819861605565531,
            loss_fee_wad            : 1000000000000000000 / 50,
            win_fee_wad             : 1000000000000000000 / 20,
            close_fee_wad           : 100000000000000 / 2,
            team_loss_fee_share_wad : 1000000000000000000 / 2,
            team_win_fee_share_wad  : 1000000000000000000,
            team_overflow_share_wad : 1000000000000000000 / 2,
            pool_cap                : 500000 * 1000000,
            min_sweep               : 10 * 1000000,
            paper_rate              : 100,
            paper_threshold         : 200000 * 1000000,
            paper_decay_s           : 12000000 * 1000000,
            max_position_notional   : 500000 * 1000000,
            max_user_notional       : 1000000 * 1000000,
            min_margin              : 1000000,
            ref_bonus_wad           : 1000000000000000000 / 10,
            ref_bonus2_wad          : 1000000000000000000 / 100,
        }
    }

    public fun loss_fee_wad(arg0: &Params) : u64 {
        arg0.loss_fee_wad
    }

    public fun max_leverage(arg0: &Params) : u64 {
        arg0.max_leverage
    }

    public fun max_position_notional(arg0: &Params) : u64 {
        arg0.max_position_notional
    }

    public fun max_user_notional(arg0: &Params) : u64 {
        arg0.max_user_notional
    }

    public fun min_margin(arg0: &Params) : u64 {
        arg0.min_margin
    }

    public fun min_sweep(arg0: &Params) : u64 {
        arg0.min_sweep
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64) : Params {
        let v0 = Params{
            max_leverage            : arg0,
            buffer_wad              : arg1,
            deadband_wad            : arg2,
            haircut_b_wad           : arg3,
            haircut_h_wad           : arg4,
            loss_fee_wad            : arg5,
            win_fee_wad             : arg6,
            close_fee_wad           : arg7,
            team_loss_fee_share_wad : arg8,
            team_win_fee_share_wad  : arg9,
            team_overflow_share_wad : arg10,
            pool_cap                : arg11,
            min_sweep               : arg12,
            paper_rate              : arg13,
            paper_threshold         : arg14,
            paper_decay_s           : arg15,
            max_position_notional   : arg16,
            max_user_notional       : arg17,
            min_margin              : arg18,
            ref_bonus_wad           : arg19,
            ref_bonus2_wad          : arg20,
        };
        validate(&v0);
        v0
    }

    public fun paper_decay_s(arg0: &Params) : u64 {
        arg0.paper_decay_s
    }

    public fun paper_rate(arg0: &Params) : u64 {
        arg0.paper_rate
    }

    public fun paper_threshold(arg0: &Params) : u64 {
        arg0.paper_threshold
    }

    public fun pool_cap(arg0: &Params) : u64 {
        arg0.pool_cap
    }

    public fun ref_bonus2_wad(arg0: &Params) : u64 {
        arg0.ref_bonus2_wad
    }

    public fun ref_bonus_wad(arg0: &Params) : u64 {
        arg0.ref_bonus_wad
    }

    public fun team_loss_fee_share_wad(arg0: &Params) : u64 {
        arg0.team_loss_fee_share_wad
    }

    public fun team_overflow_share_wad(arg0: &Params) : u64 {
        arg0.team_overflow_share_wad
    }

    public fun team_win_fee_share_wad(arg0: &Params) : u64 {
        arg0.team_win_fee_share_wad
    }

    public fun usdc() : u64 {
        1000000
    }

    public fun validate(arg0: &Params) {
        assert!(arg0.max_leverage >= 1 && arg0.max_leverage <= 1000, 0);
        assert!(arg0.buffer_wad <= 20 * 100000000000000 && arg0.buffer_wad < 1000000000000000000 / arg0.max_leverage, 0);
        assert!(arg0.deadband_wad <= 5 * 100000000000000, 0);
        assert!(arg0.haircut_b_wad <= 1000000000000000000 / 2, 0);
        assert!(arg0.haircut_h_wad <= 20 * 100000000000000, 0);
        assert!(arg0.loss_fee_wad <= 1000000000000000000 / 10, 0);
        assert!(arg0.win_fee_wad <= 1000000000000000000 / 10, 0);
        assert!(arg0.close_fee_wad <= 2 * 100000000000000, 0);
        assert!(arg0.team_loss_fee_share_wad <= 1000000000000000000, 0);
        assert!(arg0.team_win_fee_share_wad <= 1000000000000000000, 0);
        assert!(arg0.team_overflow_share_wad <= 1000000000000000000, 0);
        assert!(arg0.pool_cap >= 10000 * 1000000 && arg0.pool_cap <= 50000000 * 1000000, 0);
        assert!(arg0.min_sweep >= 1000000 / 100 && arg0.min_sweep <= 10000 * 1000000, 0);
        assert!(arg0.paper_rate >= 1 && arg0.paper_rate <= 1000, 0);
        assert!(arg0.paper_threshold <= arg0.pool_cap, 0);
        assert!(arg0.paper_decay_s >= 100000 * 1000000 && arg0.paper_decay_s <= 10000000000 * 1000000, 0);
        assert!(arg0.max_position_notional >= 1 && arg0.max_position_notional <= 10000000 * 1000000, 0);
        assert!(arg0.max_user_notional <= 20000000 * 1000000 && arg0.max_user_notional >= arg0.max_position_notional, 0);
        assert!(arg0.min_margin >= 1000000 / 100, 0);
        assert!(arg0.ref_bonus_wad + arg0.ref_bonus2_wad <= 1000000000000000000 / 4, 0);
    }

    public fun win_fee_wad(arg0: &Params) : u64 {
        arg0.win_fee_wad
    }

    // decompiled from Move bytecode v7
}

