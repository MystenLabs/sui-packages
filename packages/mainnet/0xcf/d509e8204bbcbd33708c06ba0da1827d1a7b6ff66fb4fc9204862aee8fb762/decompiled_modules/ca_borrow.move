module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::ca_borrow {
    public fun borrow<T0>(arg0: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::Market, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt::PriceReceipt, arg2: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::CreditAccount, arg3: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::OwnerKey, arg4: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg5: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg6: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::assert_owner(arg2, arg3);
        assert!(0x1::type_name::get<T0>() == 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::denom(arg2), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::accrue_interest(arg2, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::get_coin_interest_config<T0>(arg0));
        assert!(arg8 <= 0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle_utils::get_amount<T0>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::account_value::max_borrow_amount_usd(arg2, arg1, arg4), arg5, arg6, arg7), 0);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::increase_debt(arg2, arg8);
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::ca_deposit_collateral::deposit_collateral_new<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::market::handle_borrow<T0>(arg0, arg8, 0x2::clock::timestamp_ms(arg7) / 1000), arg9));
        assert!(!0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::account_value::is_unhealthy(arg2, arg1, arg4), 0);
    }

    // decompiled from Move bytecode v6
}

