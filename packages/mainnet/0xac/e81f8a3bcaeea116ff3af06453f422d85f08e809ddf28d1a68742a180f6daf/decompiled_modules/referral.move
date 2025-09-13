module 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xace81f8a3bcaeea116ff3af06453f422d85f08e809ddf28d1a68742a180f6daf::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

