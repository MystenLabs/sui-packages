module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

