module 0x967ab8535f05a034c0f0f218f4165122a3a22d53894e45c0220b642e017e8482::estimate_fee {
    struct EstimateFeeParam has copy, drop, store {
        dst_eid: u32,
        call_data_size: u64,
        gas: u256,
    }

    struct EstimateFeeResult has copy, drop, store {
        fee: u128,
        price_ratio: u128,
        price_ratio_denominator: u128,
        native_price_usd: u128,
    }

    public fun call_data_size(arg0: &EstimateFeeParam) : u64 {
        arg0.call_data_size
    }

    public fun create_param(arg0: u32, arg1: u64, arg2: u256) : EstimateFeeParam {
        EstimateFeeParam{
            dst_eid        : arg0,
            call_data_size : arg1,
            gas            : arg2,
        }
    }

    public fun create_result(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : EstimateFeeResult {
        EstimateFeeResult{
            fee                     : arg0,
            price_ratio             : arg1,
            price_ratio_denominator : arg2,
            native_price_usd        : arg3,
        }
    }

    public fun dst_eid(arg0: &EstimateFeeParam) : u32 {
        arg0.dst_eid
    }

    public fun fee(arg0: &EstimateFeeResult) : u128 {
        arg0.fee
    }

    public fun gas(arg0: &EstimateFeeParam) : u256 {
        arg0.gas
    }

    public fun native_price_usd(arg0: &EstimateFeeResult) : u128 {
        arg0.native_price_usd
    }

    public fun price_ratio(arg0: &EstimateFeeResult) : u128 {
        arg0.price_ratio
    }

    public fun price_ratio_denominator(arg0: &EstimateFeeResult) : u128 {
        arg0.price_ratio_denominator
    }

    // decompiled from Move bytecode v6
}

