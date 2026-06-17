module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::watermark {
    struct Watermark has copy, drop, store {
        drop_bps: u64,
        spike_apy_e9: u64,
        cumulative_apy_e9: u64,
        window_start_index: u128,
        window_start_ms: u64,
        window_ms: u64,
    }

    public fun check_and_update(arg0: &mut Watermark, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u8 {
        let v0 = check_single_step(arg1, arg2, arg3, arg4, arg0);
        if (v0 != 0) {
            return v0
        };
        if (arg0.window_start_ms == 0 || arg4 > arg0.window_start_ms + arg0.window_ms) {
            arg0.window_start_index = arg2;
            arg0.window_start_ms = arg4;
            return 0
        };
        if (arg2 > arg0.window_start_index && arg4 > arg0.window_start_ms) {
            if (0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::is_spike_violation(arg2 - arg0.window_start_index, arg0.window_start_index, arg4 - arg0.window_start_ms, arg0.cumulative_apy_e9)) {
                return 3
            };
        };
        0
    }

    public fun check_single_step(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: &Watermark) : u8 {
        if (arg2 == 0) {
            return 0
        };
        if (arg1 < arg0) {
            if (arg1 < 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::mul_div_down_u128(arg0, ((10000 - arg4.drop_bps) as u128), 10000)) {
                return 1
            };
            return 0
        };
        if (arg1 > arg0 && arg3 > arg2) {
            if (0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::math_ext::is_spike_violation(arg1 - arg0, arg0, arg3 - arg2, arg4.spike_apy_e9)) {
                return 2
            };
        };
        0
    }

    public fun cumulative_apy_e9(arg0: &Watermark) : u64 {
        arg0.cumulative_apy_e9
    }

    public fun default() : Watermark {
        Watermark{
            drop_bps           : 10,
            spike_apy_e9       : 2000000000,
            cumulative_apy_e9  : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::max_apy_e9(),
            window_start_index : 0,
            window_start_ms    : 0,
            window_ms          : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::cumulative_window_ms(),
        }
    }

    public fun drop_bps(arg0: &Watermark) : u64 {
        arg0.drop_bps
    }

    public fun max_cumulative_apy_e9() : u64 {
        440000000
    }

    public fun max_drop_bps() : u64 {
        9999
    }

    public fun max_spike_apy_e9() : u64 {
        10000000000
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64) : Watermark {
        assert!(arg0 <= 9999, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        assert!(arg1 <= 10000000000, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        assert!(arg2 <= 440000000, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        Watermark{
            drop_bps           : arg0,
            spike_apy_e9       : arg1,
            cumulative_apy_e9  : arg2,
            window_start_index : 0,
            window_start_ms    : 0,
            window_ms          : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::cumulative_window_ms(),
        }
    }

    public fun reset_window(arg0: &mut Watermark, arg1: u64, arg2: u128) {
        arg0.window_start_index = arg2;
        arg0.window_start_ms = arg1;
    }

    public fun set_cumulative_apy_e9(arg0: &mut Watermark, arg1: u64) {
        assert!(arg1 <= 440000000, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        arg0.cumulative_apy_e9 = arg1;
    }

    public fun set_drop_bps(arg0: &mut Watermark, arg1: u64) {
        assert!(arg1 <= 9999, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        arg0.drop_bps = arg1;
    }

    public fun set_spike_apy_e9(arg0: &mut Watermark, arg1: u64) {
        assert!(arg1 <= 10000000000, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        arg0.spike_apy_e9 = arg1;
    }

    public(friend) fun set_window_ms(arg0: &mut Watermark, arg1: u64) {
        assert!(arg1 > 0, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_watermark_param_out_of_range());
        arg0.window_ms = arg1;
    }

    public fun spike_apy_e9(arg0: &Watermark) : u64 {
        arg0.spike_apy_e9
    }

    public fun violation_cumulative() : u8 {
        3
    }

    public fun violation_drop() : u8 {
        1
    }

    public fun violation_none() : u8 {
        0
    }

    public fun violation_spike() : u8 {
        2
    }

    public fun window_ms(arg0: &Watermark) : u64 {
        arg0.window_ms
    }

    public fun window_start_index(arg0: &Watermark) : u128 {
        arg0.window_start_index
    }

    public fun window_start_ms(arg0: &Watermark) : u64 {
        arg0.window_start_ms
    }

    // decompiled from Move bytecode v7
}

