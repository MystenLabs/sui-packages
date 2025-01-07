module 0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::price {
    public fun oracle_price<T0, T1, T2>(arg0: &0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::pool::DaoFeePool<T0>, arg1: &0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::oracle_price<T0, T1, T2>(0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::pool::borrow_pool<T0>(arg0), arg2)
    }

    public fun spot_price<T0, T1, T2>(arg0: &0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::pool::DaoFeePool<T0>, arg1: &0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::spot_price<T0, T1, T2>(0xa62f1c2f162b342ec142286f752f96e50c1b633addb8fbf9fee89763c3a5053c::pool::borrow_pool<T0>(arg0), arg2)
    }

    // decompiled from Move bytecode v6
}

