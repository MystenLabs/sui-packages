module 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

