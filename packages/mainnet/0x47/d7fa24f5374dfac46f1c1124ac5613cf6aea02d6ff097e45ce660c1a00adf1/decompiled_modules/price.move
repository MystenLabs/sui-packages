module 0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::price {
    public fun oracle_price<T0, T1, T2>(arg0: &0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::pool::DaoFeePool<T0>, arg1: &0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::oracle_price<T0, T1, T2>(0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::pool::borrow_pool<T0>(arg0), arg2)
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::pool::DaoFeePool<T0>, arg1: &0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::spot_price<T0, T1, T2>(0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::pool::borrow_pool<T0>(arg0), arg2)
    }

    // decompiled from Move bytecode v6
}

