module 0x18edda85608fd4134dea7bdcfb519b2161814cb04c3c4ba3021be5cd390e3c3e::withdraw {
    public fun withdraw_if_non_zero<T0, T1, T2>(arg0: &mut 0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_manager::MarginManager<T0, T1>, arg1: &0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_registry::MarginRegistry, arg2: &0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_pool::MarginPool<T0>, arg3: &0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_pool::MarginPool<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x4626eeeb99b797e25ba1766861336145b393f346b47db2942f79c703a85572c8::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        if (arg7 == 0) {
            return 0x2::coin::zero<T2>(arg9)
        };
        0x467d6ef98e999e183c5dfc58e2af57859fd20caaf417771a295bc9fa84871904::margin_manager::withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

