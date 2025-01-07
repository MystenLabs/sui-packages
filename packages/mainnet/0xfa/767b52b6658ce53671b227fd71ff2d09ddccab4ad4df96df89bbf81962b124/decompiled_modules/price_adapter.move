module 0xfa767b52b6658ce53671b227fd71ff2d09ddccab4ad4df96df89bbf81962b124::price_adapter {
    struct PriceAdapter has drop {
        dummy_field: bool,
    }

    public fun set_debt_value<T0>(arg0: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt::PriceReceipt, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::CreditAccount, arg2: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry, arg3: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg4: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) {
        assert!(0x1::type_name::get<T0>() == 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::denom(arg1), 0);
        let (v0, _) = 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::debt(arg1);
        let v2 = PriceAdapter{dummy_field: false};
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt::set_debt_value<PriceAdapter>(v2, arg2, arg0, 0x1::type_name::get<T0>(), 0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle_utils::get_usd_value<T0>(v0, arg3, arg4, arg5));
    }

    public fun set_token_value<T0>(arg0: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt::PriceReceipt, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::CreditAccount, arg2: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_policy::PricePolicyRegistry, arg3: &0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle::KriyaOracle, arg4: &0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry::CoinDecimalsRegistry, arg5: &0x2::clock::Clock) {
        let v0 = PriceAdapter{dummy_field: false};
        0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::price_receipt::set_asset_value<PriceAdapter>(v0, arg2, arg0, 0x1::type_name::get<T0>(), 0x393593e5410eb150d9ce8ae33a46d23a6030798823819474393206d27aa9ddee::oracle_utils::get_usd_value<T0>(0x2::balance::value<T0>(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::borrow_asset<0x2::balance::Balance<T0>>(arg1)), arg3, arg4, arg5));
    }

    // decompiled from Move bytecode v6
}

