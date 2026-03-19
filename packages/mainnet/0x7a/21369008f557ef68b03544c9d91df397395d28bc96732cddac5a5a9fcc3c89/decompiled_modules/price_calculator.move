module 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator {
    struct PriceCalculator has drop {
        coins: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>,
    }

    public fun contains(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins, &arg1)
    }

    public fun decimals(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins, &arg1), 0);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::decimals(0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins, &arg1))
    }

    public fun price(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins, &arg1), 0);
        let v0 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::price(0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins, &arg1));
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&v0), 1);
        v0
    }

    public fun coin_amount_to_usd(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName, arg2: u64) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg2), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, decimals(arg0, arg1)))), price(arg0, arg1))
    }

    public fun coin_types(arg0: &PriceCalculator) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&arg0.coins)
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>) : PriceCalculator {
        PriceCalculator{coins: arg0}
    }

    public fun usd_to_coin_amount(arg0: &PriceCalculator, arg1: 0x1::type_name::TypeName, arg2: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) : u64 {
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(arg2, price(arg0, arg1)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1::u64::pow(10, decimals(arg0, arg1)))))
    }

    // decompiled from Move bytecode v6
}

