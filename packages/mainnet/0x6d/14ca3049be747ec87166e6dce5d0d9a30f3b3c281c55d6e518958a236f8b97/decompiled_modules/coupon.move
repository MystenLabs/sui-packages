module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon {
    struct Coupon has copy, drop, store {
        kind: u8,
        amount: u64,
        rules: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules,
    }

    public(friend) fun calculate_sale_price(arg0: &Coupon, arg1: u64) : u64 {
        if (arg0.kind == 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::constants::fixed_price_discount_type()) {
            if (arg0.amount > arg1) {
                return 0
            };
            return arg1 - arg0.amount
        };
        arg1 - (((arg1 as u128) * (arg0.amount as u128) / 100) as u64)
    }

    public(friend) fun new(arg0: u8, arg1: u64, arg2: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules, arg3: &mut 0x2::tx_context::TxContext) : Coupon {
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_is_valid_amount(arg0, arg1);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_is_valid_discount_type(arg0);
        Coupon{
            kind   : arg0,
            amount : arg1,
            rules  : arg2,
        }
    }

    public(friend) fun rules(arg0: &Coupon) : &0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules {
        &arg0.rules
    }

    public(friend) fun rules_mut(arg0: &mut Coupon) : &mut 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules {
        &mut arg0.rules
    }

    // decompiled from Move bytecode v6
}

