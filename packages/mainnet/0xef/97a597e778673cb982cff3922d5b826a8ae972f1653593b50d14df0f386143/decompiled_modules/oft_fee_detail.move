module 0xef97a597e778673cb982cff3922d5b826a8ae972f1653593b50d14df0f386143::oft_fee_detail {
    struct OFTFeeDetail has copy, drop, store {
        fee_amount_ld: u64,
        is_reward: bool,
        description: 0x1::ascii::String,
    }

    public(friend) fun create(arg0: u64, arg1: bool, arg2: 0x1::ascii::String) : OFTFeeDetail {
        OFTFeeDetail{
            fee_amount_ld : arg0,
            is_reward     : arg1,
            description   : arg2,
        }
    }

    public fun description(arg0: &OFTFeeDetail) : &0x1::ascii::String {
        &arg0.description
    }

    public fun fee_amount_ld(arg0: &OFTFeeDetail) : (u64, bool) {
        (arg0.fee_amount_ld, arg0.is_reward)
    }

    // decompiled from Move bytecode v6
}

