module 0xce6a4384ceb1306efdb45cd0b093a7a49669a998749c59e614be8cfdf1352530::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0xce6a4384ceb1306efdb45cd0b093a7a49669a998749c59e614be8cfdf1352530::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0xce6a4384ceb1306efdb45cd0b093a7a49669a998749c59e614be8cfdf1352530::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0xce6a4384ceb1306efdb45cd0b093a7a49669a998749c59e614be8cfdf1352530::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

