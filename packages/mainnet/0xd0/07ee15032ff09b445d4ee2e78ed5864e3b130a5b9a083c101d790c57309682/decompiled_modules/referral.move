module 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xd007ee15032ff09b445d4ee2e78ed5864e3b130a5b9a083c101d790c57309682::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

