module 0xc35bf7ed9aec79405a678e87f248072955c46af4036f186bee5d5935e139ea62::a {
    public fun ab<T0>(arg0: &0x6ee87742e673749a97f5fbe576b92d8dd294a482307d3a3fb2c6f73a56b906a0::pyth_rule::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x50a859ff33f5d82bc131f21b8a544a1e48cd61c88652f65c5ce7c6a6b091f98::supra_rule::Config, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::aggregator::PriceAggregator<T0>, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg8: 0x2::balance::Balance<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB> {
        let v0 = price<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10);
        let v1 = 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>();
        0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg7, &v0, 0x2::coin::from_balance<T0>(arg8, arg10), &v1, arg10))
    }

    public fun ba<T0>(arg0: &0x6ee87742e673749a97f5fbe576b92d8dd294a482307d3a3fb2c6f73a56b906a0::pyth_rule::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x50a859ff33f5d82bc131f21b8a544a1e48cd61c88652f65c5ce7c6a6b091f98::supra_rule::Config, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::aggregator::PriceAggregator<T0>, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg8: 0x2::balance::Balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = price<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg10);
        let v1 = 0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>();
        0x2::coin::into_balance<T0>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg6, arg7, &v0, 0x2::coin::from_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg8, arg10), &v1, arg10))
    }

    fun price<T0>(arg0: &0x6ee87742e673749a97f5fbe576b92d8dd294a482307d3a3fb2c6f73a56b906a0::pyth_rule::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x50a859ff33f5d82bc131f21b8a544a1e48cd61c88652f65c5ce7c6a6b091f98::supra_rule::Config, arg4: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::aggregator::PriceAggregator<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0> {
        assert!(0x2::tx_context::sender(arg7) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
        let v0 = 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::new<T0>();
        0x6ee87742e673749a97f5fbe576b92d8dd294a482307d3a3fb2c6f73a56b906a0::pyth_rule::feed<T0>(&mut v0, arg0, arg6, arg1, arg2);
        0x50a859ff33f5d82bc131f21b8a544a1e48cd61c88652f65c5ce7c6a6b091f98::supra_rule::feed<T0>(&mut v0, arg3, arg6, arg4);
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::aggregator::aggregate<T0>(arg5, v0)
    }

    // decompiled from Move bytecode v7
}

