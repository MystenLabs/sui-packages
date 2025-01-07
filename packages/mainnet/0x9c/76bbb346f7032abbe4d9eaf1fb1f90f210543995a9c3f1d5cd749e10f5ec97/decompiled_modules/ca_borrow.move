module 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::ca_borrow {
    public fun borrow<T0: store>(arg0: &mut 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::market::Market, arg1: &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::price_receipt::PriceReceipt, arg2: &mut 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::CreditAccount, arg3: &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::OwnerKey, arg4: &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::tier_registry::TierRegistry, arg5: &0x8b1ad0a46da6dffe84a7bdd8d4beb39c965daeb3b833a4723428ba7c05da7527::oracle::KriyaOracle, arg6: &0x44f1677c61a905ae78e245d89b4cb7dffbb8bf4022a89f2b2e55ec18cbc6003c::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::assert_owner(arg2, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::denom(arg2), 0);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::accrue_interest(arg2, 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::oracle_utils::get_amount(0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::account_value::max_borrow_amount_usd(arg2, arg1, arg4), v0, arg5, arg6, arg7), 0);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::increase_debt(arg2, arg8);
        0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::ca_deposit_collateral::deposit_collateral<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::market::handle_borrow<T0>(arg0, arg8, 0x2::clock::timestamp_ms(arg7) / 1000), arg9));
        assert!(!0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::account_value::is_unhealthy(arg2, arg1, arg4), 0);
    }

    // decompiled from Move bytecode v6
}

