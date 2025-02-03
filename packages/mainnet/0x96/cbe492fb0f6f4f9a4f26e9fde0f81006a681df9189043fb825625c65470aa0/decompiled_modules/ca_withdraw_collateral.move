module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::ca_withdraw_collateral {
    public fun withdraw_collateral<T0: store>(arg0: &mut 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::Market, arg1: &mut 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::CreditAccount, arg2: &0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::OwnerKey, arg3: &0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::price_receipt::PriceReceipt, arg4: &0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::tier_registry::TierRegistry, arg5: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg6: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::assert_owner(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::denom(arg1), 0);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::accrue_interest<T0>(arg0, 0x2::clock::timestamp_ms(arg7) / 1000);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::accrue_interest(arg1, 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::oracle_utils::get_amount(0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::account_value::account_value_usd(arg1, arg3, arg4), v0, arg5, arg6, arg7), 0);
        let v1 = 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::add_asset<0x2::balance::Balance<T0>>(v1, arg1);
        assert!(!0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::account_value::is_unhealthy(arg1, arg3, arg4), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, arg8), arg9)
    }

    // decompiled from Move bytecode v6
}

