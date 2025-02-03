module 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x735b8878431e200b6928c5530b61a2a41f153399ca683bbbcc8f4aeff78c4c8d::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

