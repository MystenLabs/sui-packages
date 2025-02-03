module 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

