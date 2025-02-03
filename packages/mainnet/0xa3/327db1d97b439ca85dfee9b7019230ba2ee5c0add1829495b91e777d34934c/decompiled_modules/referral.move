module 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xa3327db1d97b439ca85dfee9b7019230ba2ee5c0add1829495b91e777d34934c::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

