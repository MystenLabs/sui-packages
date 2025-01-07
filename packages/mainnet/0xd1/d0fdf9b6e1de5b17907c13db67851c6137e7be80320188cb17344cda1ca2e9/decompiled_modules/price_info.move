module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info {
    struct PriceInfo has copy, drop, store {
        price: u128,
        price_decimals: u64,
        is_negative: bool,
    }

    public fun calculate_amount_value(arg0: &PriceInfo, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::CoinInfo, arg2: u64) : u128 {
        if (arg0.is_negative) {
            arg0.price * (arg2 as u128) * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::power(10, ((9 - 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::decimals(arg1)) as u64)) as u128) / (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::power(10, arg0.price_decimals) as u128)
        } else {
            arg0.price * (arg2 as u128) * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::power(10, ((9 - 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::coin_info::decimals(arg1)) as u64)) as u128) * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::power(10, arg0.price_decimals) as u128)
        }
    }

    public(friend) fun new(arg0: u128, arg1: u64, arg2: bool) : PriceInfo {
        PriceInfo{
            price          : arg0,
            price_decimals : arg1,
            is_negative    : arg2,
        }
    }

    public fun price(arg0: &PriceInfo) : u128 {
        arg0.price
    }

    public fun price_decimals(arg0: &PriceInfo) : u64 {
        arg0.price_decimals
    }

    // decompiled from Move bytecode v6
}

