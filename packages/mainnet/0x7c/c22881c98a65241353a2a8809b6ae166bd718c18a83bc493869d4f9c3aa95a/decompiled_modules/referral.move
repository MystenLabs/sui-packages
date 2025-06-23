module 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x7cc22881c98a65241353a2a8809b6ae166bd718c18a83bc493869d4f9c3aa95a::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

