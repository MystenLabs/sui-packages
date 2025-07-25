module 0xeb387672f9f976dba37660610c364fcdf3a7b287411c1902597ee7807d63a71b::use_tide {
    public fun quote<T0, T1>(arg0: &mut 0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : (u64, u64, u64) {
        0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::quote<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

