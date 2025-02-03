module 0x9d343304a2cf9d6e062024c42513cefe4901eb6e590d1bb4f982b5ced0b02a4c::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x9d343304a2cf9d6e062024c42513cefe4901eb6e590d1bb4f982b5ced0b02a4c::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x9d343304a2cf9d6e062024c42513cefe4901eb6e590d1bb4f982b5ced0b02a4c::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x9d343304a2cf9d6e062024c42513cefe4901eb6e590d1bb4f982b5ced0b02a4c::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

