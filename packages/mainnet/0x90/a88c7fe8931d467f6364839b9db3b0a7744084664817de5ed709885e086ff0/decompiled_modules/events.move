module 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct Withdraw<phantom T0> has copy, drop {
        amount: u64,
    }

    struct Inflow<phantom T0, phantom T1: drop> has copy, drop {
        amount: u64,
    }

    struct Outflow<phantom T0, phantom T1: drop> has copy, drop {
        amount: u64,
    }

    struct SetReferrer has copy, drop {
        player: address,
        referrer: address,
    }

    struct EarnPlayingRebate<phantom T0, phantom T1: drop> has copy, drop {
        player: address,
        amount: u64,
    }

    struct EarnReferralRebate<phantom T0, phantom T1: drop> has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct ClaimRebate<phantom T0> has copy, drop {
        user: address,
        amount: u64,
    }

    public(friend) fun emit_claim_rebate<T0>(arg0: address, arg1: u64) {
        if (arg1 > 0) {
            let v0 = ClaimRebate<T0>{
                user   : arg0,
                amount : arg1,
            };
            0x2::event::emit<ClaimRebate<T0>>(v0);
        };
    }

    public(friend) fun emit_deposit<T0>(arg0: u64) {
        if (arg0 > 0) {
            let v0 = Deposit<T0>{amount: arg0};
            0x2::event::emit<Deposit<T0>>(v0);
        };
    }

    public(friend) fun emit_earn_playing_rebate<T0, T1: drop>(arg0: address, arg1: u64) {
        if (arg1 > 0) {
            let v0 = EarnPlayingRebate<T0, T1>{
                player : arg0,
                amount : arg1,
            };
            0x2::event::emit<EarnPlayingRebate<T0, T1>>(v0);
        };
    }

    public(friend) fun emit_earn_referral_rebate<T0, T1: drop>(arg0: address, arg1: u64) {
        if (arg1 > 0) {
            let v0 = EarnReferralRebate<T0, T1>{
                referrer : arg0,
                amount   : arg1,
            };
            0x2::event::emit<EarnReferralRebate<T0, T1>>(v0);
        };
    }

    public(friend) fun emit_inflow<T0, T1: drop>(arg0: u64) {
        if (arg0 > 0) {
            let v0 = Inflow<T0, T1>{amount: arg0};
            0x2::event::emit<Inflow<T0, T1>>(v0);
        };
    }

    public(friend) fun emit_outflow<T0, T1: drop>(arg0: u64) {
        if (arg0 > 0) {
            let v0 = Outflow<T0, T1>{amount: arg0};
            0x2::event::emit<Outflow<T0, T1>>(v0);
        };
    }

    public(friend) fun emit_set_referrer(arg0: address, arg1: address) {
        let v0 = SetReferrer{
            player   : arg0,
            referrer : arg1,
        };
        0x2::event::emit<SetReferrer>(v0);
    }

    public(friend) fun emit_withdraw<T0>(arg0: u64) {
        if (arg0 > 0) {
            let v0 = Withdraw<T0>{amount: arg0};
            0x2::event::emit<Withdraw<T0>>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

