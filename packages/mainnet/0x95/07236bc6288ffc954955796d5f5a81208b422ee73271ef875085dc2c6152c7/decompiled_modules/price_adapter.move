module 0x9507236bc6288ffc954955796d5f5a81208b422ee73271ef875085dc2c6152c7::price_adapter {
    struct PriceAdapter has drop {
        dummy_field: bool,
    }

    public fun set_debt_value<T0>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_policy::PricePolicyRegistry, arg3: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg4: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) {
        assert!(0x1::type_name::get<T0>() == 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::denom(arg1), 0);
        let (v0, _) = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::debt(arg1);
        let v2 = PriceAdapter{dummy_field: false};
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::set_debt_value<PriceAdapter>(v2, arg2, arg0, 0x1::type_name::get<T0>(), 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_usd_value<T0>(v0, arg3, arg4, arg5));
    }

    public fun set_token_value<T0>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_policy::PricePolicyRegistry, arg3: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg4: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) {
        let v0 = PriceAdapter{dummy_field: false};
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::set_asset_value<PriceAdapter>(v0, arg2, arg0, 0x1::type_name::get<0x2::balance::Balance<T0>>(), 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_usd_value<T0>(0x2::balance::value<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::borrow_asset<0x2::balance::Balance<T0>>(arg1)), arg3, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

