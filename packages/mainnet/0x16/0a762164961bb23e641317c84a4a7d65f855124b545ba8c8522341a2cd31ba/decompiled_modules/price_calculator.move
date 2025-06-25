module 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::price_calculator {
    struct PriceCalculator has drop {
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>,
    }

    public fun contains(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>(&arg0.prices, &arg1)
    }

    public fun coin_amount_to_usd(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg2), price(arg0, arg1)))
    }

    public fun coin_types(arg0: &PriceCalculator) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>(&arg0.prices)
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>) : PriceCalculator {
        PriceCalculator{prices: arg0}
    }

    public fun price(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>(&arg0.prices, &arg1), 0);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal>(&arg0.prices, &arg1);
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(v0), 1);
        *v0
    }

    public fun usd_to_coin_amount(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName, arg2: u64) : u64 {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg2), price(arg0, arg1)))
    }

    // decompiled from Move bytecode v6
}

