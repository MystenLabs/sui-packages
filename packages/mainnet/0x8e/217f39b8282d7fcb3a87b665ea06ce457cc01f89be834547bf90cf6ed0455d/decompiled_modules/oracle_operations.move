module 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle_operations {
    struct PriceRatioResult has copy, drop, store {
        price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
        expo: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
    }

    public fun get_expo(arg0: PriceRatioResult) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        arg0.expo
    }

    public fun get_price(arg0: PriceRatioResult) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        arg0.price
    }

    public fun calculate_price_ratio(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price, arg2: u64) : PriceRatioResult {
        let v0 = subtract_exponents(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg1));
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0)) {
            PriceRatioResult{price: divide_price_magnitudes(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg1), arg2), expo: v0}
        } else {
            let v2 = 0x1::u64::try_as_u8(get_magnitude(v0));
            let v3 = 0x1::u256::try_as_u64((get_magnitude(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0)) as u256) * 0x1::u256::pow(10, 0x1::option::extract<u8>(&mut v2)));
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0);
            PriceRatioResult{price: divide_price_magnitudes(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(0x1::option::extract<u64>(&mut v3), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg1), arg2), expo: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(0, false)}
        }
    }

    fun divide_price_magnitudes(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: u64) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(divide_safe(get_magnitude(arg0), get_magnitude(arg1), arg2), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0) != 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1))
    }

    public fun divide_safe(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 != 0, 0);
        let v0 = 0x1::u256::try_as_u64((arg2 as u256) * (arg0 as u256) / (arg1 as u256));
        assert!(0x1::option::is_some<u64>(&v0), 2);
        0x1::option::extract<u64>(&mut v0)
    }

    public fun get_magnitude(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg0)
        }
    }

    fun subtract_exponents(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        let v0 = get_magnitude(arg0);
        let v1 = get_magnitude(arg1);
        let (v2, v3) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0) == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1)) {
            if (v0 >= v1) {
                (v0 - v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0))
            } else {
                (v1 - v0, !0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0))
            }
        } else {
            (v0 + v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg0))
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v2, v3)
    }

    public fun transform_price_to_decimal_format(arg0: PriceRatioResult) : u64 {
        let v0 = get_price(arg0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0), 1);
        let v1 = get_expo(arg0);
        let v2 = 0x1::u64::try_as_u8(get_magnitude(get_expo(arg0)));
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            let v3 = 0x1::u256::try_as_u64((get_magnitude(get_price(arg0)) as u256) / 0x1::u256::pow(10, *0x1::option::borrow<u8>(&v2)));
            assert!(0x1::option::is_some<u64>(&v3), 2);
            return 0x1::option::extract<u64>(&mut v3)
        };
        let v4 = 0x1::u256::try_as_u64((get_magnitude(get_price(arg0)) as u256) * 0x1::u256::pow(10, *0x1::option::borrow<u8>(&v2)));
        assert!(0x1::option::is_some<u64>(&v4), 2);
        0x1::option::extract<u64>(&mut v4)
    }

    // decompiled from Move bytecode v6
}

