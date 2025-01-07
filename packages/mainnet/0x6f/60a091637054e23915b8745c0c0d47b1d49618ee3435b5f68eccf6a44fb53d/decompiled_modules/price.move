module 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::price {
    public fun oracle_price<T0, T1, T2>(arg0: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::oracle_price<T0, T1, T2>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_pool<T0>(arg0), arg2)
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::spot_price<T0, T1, T2>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_pool<T0>(arg0), arg2)
    }

    // decompiled from Move bytecode v6
}

