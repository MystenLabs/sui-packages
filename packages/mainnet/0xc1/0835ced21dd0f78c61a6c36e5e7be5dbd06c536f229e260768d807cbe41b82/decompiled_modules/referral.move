module 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

