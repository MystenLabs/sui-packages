module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::ca_withdraw_collateral {
    public fun withdraw_collateral<T0: store>(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::Market, arg1: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg3: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg4: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry, arg5: &0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::KriyaOracle, arg6: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::denom(arg1), 0);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::accrue_interest<T0>(arg0, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::accrue_interest(arg1, 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::oracle_utils::get_amount(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::account_value_usd(arg1, arg3, arg4), v0, arg5, arg6, arg7), 0);
        let v1 = 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::add_asset<0x2::balance::Balance<T0>>(v1, arg1);
        assert!(!0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::is_unhealthy(arg1, arg3, arg4), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, arg8), arg9)
    }

    // decompiled from Move bytecode v6
}

