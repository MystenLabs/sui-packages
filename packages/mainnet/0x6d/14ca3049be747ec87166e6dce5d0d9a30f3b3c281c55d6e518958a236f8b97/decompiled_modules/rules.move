module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules {
    struct CouponRules has copy, drop, store {
        length: 0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>,
        available_claims: 0x1::option::Option<u64>,
        user: 0x1::option::Option<address>,
        expiration: 0x1::option::Option<u64>,
        years: 0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>,
    }

    public fun assert_coupon_is_not_expired(arg0: &CouponRules, arg1: &0x2::clock::Clock) {
        assert!(!is_coupon_expired(arg0, arg1), 7);
    }

    public fun assert_coupon_valid_for_address(arg0: &CouponRules, arg1: address) {
        assert!(is_coupon_valid_for_address(arg0, arg1), 6);
    }

    public fun assert_coupon_valid_for_domain_size(arg0: &CouponRules, arg1: u8) {
        assert!(is_coupon_valid_for_domain_size(arg0, arg1), 2);
    }

    public fun assert_coupon_valid_for_domain_years(arg0: &CouponRules, arg1: u8) {
        assert!(is_coupon_valid_for_domain_years(arg0, arg1), 1);
    }

    public fun assert_is_valid_amount(arg0: u8, arg1: u64) {
        assert!(arg1 > 0, 4);
        if (arg0 == 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::constants::percentage_discount_type()) {
            assert!(arg1 <= 100, 4);
        };
    }

    public fun assert_is_valid_discount_type(arg0: u8) {
        let v0 = 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::constants::discount_rule_types();
        assert!(0x1::vector::contains<u8>(&v0, &arg0), 5);
    }

    public fun decrease_available_claims(arg0: &mut CouponRules) {
        if (0x1::option::is_some<u64>(&arg0.available_claims)) {
            assert!(has_available_claims(arg0), 3);
            0x1::option::swap<u64>(&mut arg0.available_claims, *0x1::option::borrow<u64>(&arg0.available_claims) - 1);
        };
    }

    public fun has_available_claims(arg0: &CouponRules) : bool {
        if (0x1::option::is_none<u64>(&arg0.available_claims)) {
            return true
        };
        *0x1::option::borrow<u64>(&arg0.available_claims) > 0
    }

    public fun is_coupon_expired(arg0: &CouponRules, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<u64>(&arg0.expiration)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) > *0x1::option::borrow<u64>(&arg0.expiration)
    }

    public fun is_coupon_valid_for_address(arg0: &CouponRules, arg1: address) : bool {
        if (0x1::option::is_none<address>(&arg0.user)) {
            return true
        };
        0x1::option::borrow<address>(&arg0.user) == &arg1
    }

    public fun is_coupon_valid_for_domain_size(arg0: &CouponRules, arg1: u8) : bool {
        if (0x1::option::is_none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(&arg0.length)) {
            return true
        };
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::is_in_range(0x1::option::borrow<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(&arg0.length), arg1)
    }

    public fun is_coupon_valid_for_domain_years(arg0: &CouponRules, arg1: u8) : bool {
        if (0x1::option::is_none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(&arg0.years)) {
            return true
        };
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::is_in_range(0x1::option::borrow<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(&arg0.years), arg1)
    }

    fun is_valid_length_range(arg0: &0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>) : bool {
        if (0x1::option::is_none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(arg0)) {
            return true
        };
        let v0 = 0x1::option::borrow<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(arg0);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::from(v0) >= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::min_domain_length() && 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::to(v0) <= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::max_domain_length()
    }

    fun is_valid_years_range(arg0: &0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>) : bool {
        if (0x1::option::is_none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(arg0)) {
            return true
        };
        let v0 = 0x1::option::borrow<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(arg0);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::from(v0) >= 1 && 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::to(v0) <= 5
    }

    public fun new_coupon_rules(arg0: 0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>) : CouponRules {
        assert!(is_valid_years_range(&arg4), 8);
        assert!(is_valid_length_range(&arg0), 0);
        assert!(0x1::option::is_none<u64>(&arg1) || *0x1::option::borrow<u64>(&arg1) > 0, 9);
        CouponRules{
            length           : arg0,
            available_claims : arg1,
            user             : arg2,
            expiration       : arg3,
            years            : arg4,
        }
    }

    public fun new_empty_rules() : CouponRules {
        CouponRules{
            length           : 0x1::option::none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(),
            available_claims : 0x1::option::none<u64>(),
            user             : 0x1::option::none<address>(),
            expiration       : 0x1::option::none<u64>(),
            years            : 0x1::option::none<0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range::Range>(),
        }
    }

    // decompiled from Move bytecode v6
}

