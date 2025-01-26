module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::user_state {
    struct UserState has copy, drop, store {
        unit: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float,
        holders_reward: u64,
        referral_reward: u64,
    }

    public(friend) fun claim(arg0: &mut UserState, arg1: u64) : (u64, u64) {
        if (total_reward(arg0) < arg1) {
            err_not_enough_to_claim();
        };
        if (holders_reward(arg0) >= arg1) {
            arg0.holders_reward = holders_reward(arg0) - arg1;
        } else {
            arg0.holders_reward = 0;
            arg0.referral_reward = referral_reward(arg0) - arg1 - holders_reward(arg0);
        };
        (holders_reward(arg0), referral_reward(arg0))
    }

    fun err_not_enough_to_claim() {
        abort 0
    }

    public fun holders_reward(arg0: &UserState) : u64 {
        arg0.holders_reward
    }

    public(friend) fun new(arg0: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float) : UserState {
        UserState{
            unit            : arg0,
            holders_reward  : 0,
            referral_reward : 0,
        }
    }

    public(friend) fun rebate(arg0: &mut UserState, arg1: u64) : u64 {
        let v0 = referral_reward(arg0) + arg1;
        arg0.referral_reward = v0;
        v0
    }

    public fun referral_reward(arg0: &UserState) : u64 {
        arg0.referral_reward
    }

    public(friend) fun set_unit(arg0: &mut UserState, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float) {
        arg0.unit = arg1;
    }

    public(friend) fun settle(arg0: &mut UserState, arg1: u64) : u64 {
        let v0 = holders_reward(arg0) + arg1;
        arg0.holders_reward = v0;
        v0
    }

    public fun total_reward(arg0: &UserState) : u64 {
        holders_reward(arg0) + referral_reward(arg0)
    }

    public fun unit(arg0: &UserState) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float {
        arg0.unit
    }

    // decompiled from Move bytecode v6
}

