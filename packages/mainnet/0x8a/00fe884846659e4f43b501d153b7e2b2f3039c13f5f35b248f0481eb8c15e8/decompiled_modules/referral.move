module 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

