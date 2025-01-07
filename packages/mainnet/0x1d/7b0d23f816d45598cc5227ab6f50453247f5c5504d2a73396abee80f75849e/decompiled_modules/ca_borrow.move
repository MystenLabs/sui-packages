module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::ca_borrow {
    public fun borrow<T0>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::Market, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg3: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::OwnerKey, arg4: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry, arg5: &0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle::KriyaOracle, arg6: &0x6f8b4b9e08f73fac834d603c29cba18892de780f642d5e7ab2a7e798452413b4::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::assert_owner(arg2, arg3);
        assert!(0x1::type_name::get<T0>() == 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::denom(arg2), 0);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::accrue_interest(arg2, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle_utils::get_amount<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::account_value::max_borrow_amount_usd(arg2, arg1, arg4), arg5, arg6, arg7), 0);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::increase_debt(arg2, arg8);
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::ca_deposit_collateral::deposit_collateral_new<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::market::handle_borrow<T0>(arg0, arg8, 0x2::clock::timestamp_ms(arg7) / 1000), arg9));
        assert!(!0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::account_value::is_unhealthy(arg2, arg1, arg4), 0);
    }

    // decompiled from Move bytecode v6
}

