module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::ca_withdraw_collateral {
    public fun withdraw_collateral<T0: store>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::Market, arg1: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::OwnerKey, arg3: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg4: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry, arg5: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg6: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::assert_owner(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::denom(arg1), 0);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::accrue_interest<T0>(arg0, 0x2::clock::timestamp_ms(arg7) / 1000);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::accrue_interest(arg1, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_amount<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::account_value::account_value_usd(arg1, arg3, arg4), arg5, arg6, arg7), 0);
        let v0 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg1);
        assert!(!0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::account_value::is_unhealthy(arg1, arg3, arg4), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, arg8), arg9)
    }

    // decompiled from Move bytecode v6
}

