module 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

