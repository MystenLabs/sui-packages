module 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

