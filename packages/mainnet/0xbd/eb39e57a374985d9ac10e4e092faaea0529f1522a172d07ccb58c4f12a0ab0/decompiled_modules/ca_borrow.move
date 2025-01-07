module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::ca_borrow {
    public fun borrow<T0: store>(arg0: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::Market, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &mut 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg3: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::OwnerKey, arg4: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry, arg5: &0x3044608c4c51724de685e38002d4d4f3a2e26f598c8f4200a40ae269b6a771bf::oracle::KriyaOracle, arg6: &0x7b83dc51fa2817c4de720db442bd3088a33c8b408aecd21bb5bfa52dcc7b356d::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assert_owner(arg2, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::denom(arg2), 0);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::accrue_interest(arg2, 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::oracle_utils::get_amount(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::max_borrow_amount_usd(arg2, arg1, arg4), v0, arg5, arg6, arg7), 0);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::increase_debt(arg2, arg8);
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::ca_deposit_collateral::deposit_collateral<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::market::handle_borrow<T0>(arg0, arg8, 0x2::clock::timestamp_ms(arg7) / 1000), arg9));
        assert!(!0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value::is_unhealthy(arg2, arg1, arg4), 0);
    }

    // decompiled from Move bytecode v6
}

