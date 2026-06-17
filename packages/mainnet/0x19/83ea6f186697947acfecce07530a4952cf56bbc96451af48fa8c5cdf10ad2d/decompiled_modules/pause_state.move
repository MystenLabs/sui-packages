module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pause_state {
    struct PauseState has copy, drop, store {
        lock_kind: u8,
        locked_at_ms: u64,
        ttl_ms: u64,
    }

    fun assert_can_apply_expiring_lock(arg0: &PauseState, arg1: u64) {
        assert!(arg0.lock_kind != 3, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_kind_mismatch());
        assert!(!is_paused(arg0, arg1), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_already_paused());
    }

    public(friend) fun clear(arg0: &mut PauseState) {
        arg0.lock_kind = 0;
        arg0.locked_at_ms = 0;
        arg0.ttl_ms = 0;
    }

    public fun is_paused(arg0: &PauseState, arg1: u64) : bool {
        if (arg0.lock_kind == 0) {
            return false
        };
        if (arg0.ttl_ms == 0) {
            return true
        };
        arg1 < saturating_add(arg0.locked_at_ms, arg0.ttl_ms)
    }

    public fun lock_global() : u8 {
        1
    }

    public fun lock_hard_cap() : u8 {
        3
    }

    public fun lock_kind(arg0: &PauseState) : u8 {
        arg0.lock_kind
    }

    public fun lock_none() : u8 {
        0
    }

    public fun lock_scoped() : u8 {
        2
    }

    public fun lock_watermark() : u8 {
        4
    }

    public fun locked_at_ms(arg0: &PauseState) : u64 {
        arg0.locked_at_ms
    }

    public fun new() : PauseState {
        PauseState{
            lock_kind    : 0,
            locked_at_ms : 0,
            ttl_ms       : 0,
        }
    }

    fun saturating_add(arg0: u64, arg1: u64) : u64 {
        if (18446744073709551615 - arg0 < arg1) {
            18446744073709551615
        } else {
            arg0 + arg1
        }
    }

    public(friend) fun set_global(arg0: &mut PauseState, arg1: u64, arg2: u64) {
        assert_can_apply_expiring_lock(arg0, arg2);
        assert!(arg1 > 0, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_ttl_too_long());
        assert!(arg1 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::max_global_pause_ttl_ms(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_ttl_too_long());
        arg0.lock_kind = 1;
        arg0.locked_at_ms = arg2;
        arg0.ttl_ms = arg1;
    }

    public(friend) fun set_hard_cap(arg0: &mut PauseState, arg1: u64) {
        arg0.lock_kind = 3;
        arg0.locked_at_ms = arg1;
        arg0.ttl_ms = 0;
    }

    public(friend) fun set_scoped(arg0: &mut PauseState, arg1: u64, arg2: u64) {
        assert_can_apply_expiring_lock(arg0, arg2);
        assert!(arg1 > 0, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_ttl_too_long());
        assert!(arg1 <= 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::max_scoped_pause_ttl_ms(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_pause_ttl_too_long());
        arg0.lock_kind = 2;
        arg0.locked_at_ms = arg2;
        arg0.ttl_ms = arg1;
    }

    public(friend) fun set_watermark(arg0: &mut PauseState, arg1: u64) : bool {
        if (arg0.lock_kind == 3) {
            return false
        };
        if (is_paused(arg0, arg1)) {
            return false
        };
        arg0.lock_kind = 4;
        arg0.locked_at_ms = arg1;
        arg0.ttl_ms = 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::constants::max_global_pause_ttl_ms();
        true
    }

    public(friend) fun try_auto_expire(arg0: &mut PauseState, arg1: u64) : (bool, u8) {
        if (arg0.lock_kind == 0) {
            return (false, 0)
        };
        if (arg0.ttl_ms == 0) {
            return (false, arg0.lock_kind)
        };
        if (arg1 >= saturating_add(arg0.locked_at_ms, arg0.ttl_ms)) {
            arg0.lock_kind = 0;
            arg0.locked_at_ms = 0;
            arg0.ttl_ms = 0;
            return (true, arg0.lock_kind)
        };
        (false, arg0.lock_kind)
    }

    public fun ttl_ms(arg0: &PauseState) : u64 {
        arg0.ttl_ms
    }

    // decompiled from Move bytecode v7
}

