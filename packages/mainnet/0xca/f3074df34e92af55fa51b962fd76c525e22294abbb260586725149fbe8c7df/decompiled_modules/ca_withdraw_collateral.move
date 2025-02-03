module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::ca_withdraw_collateral {
    public fun withdraw_collateral<T0: store>(arg0: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::Market, arg1: &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::CreditAccount, arg2: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::OwnerKey, arg3: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::price_receipt::PriceReceipt, arg4: &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry::TierRegistry, arg5: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg6: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::assert_owner(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::denom(arg1), 0);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::accrue_interest<T0>(arg0, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::accrue_interest(arg1, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle_utils::get_amount<T0>(0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::account_value::account_value_usd(arg1, arg3, arg4), arg5, arg6, arg7), 0);
        let v0 = 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::credit_account::add_asset<0x2::balance::Balance<T0>>(v0, arg1);
        assert!(!0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::account_value::is_unhealthy(arg1, arg3, arg4), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, arg8), arg9)
    }

    // decompiled from Move bytecode v6
}

