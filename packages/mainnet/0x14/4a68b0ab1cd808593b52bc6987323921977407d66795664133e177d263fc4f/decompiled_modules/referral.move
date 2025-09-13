module 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::referral {
    struct Referral has store {
        referrer: address,
        rebate_rate: 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::Rate,
    }

    public fun get_rebate_rate(arg0: &Referral) : 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::Rate {
        arg0.rebate_rate
    }

    public fun get_referrer(arg0: &Referral) : address {
        arg0.referrer
    }

    public(friend) fun new_referral(arg0: address, arg1: 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::Rate) : Referral {
        Referral{
            referrer    : arg0,
            rebate_rate : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

