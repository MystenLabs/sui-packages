module 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x64182982c50031168b58d899c0c87eb19d78f9a842bc390db7b5a6f8774fc38d::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

