module 0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::price {
    public fun oracle_price<T0, T1, T2>(arg0: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::DaoFeePool<T0>, arg1: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::oracle_price<T0, T1, T2>(0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::borrow_pool<T0>(arg0), arg2)
    }

    public fun spot_price<T0, T1, T2>(arg0: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::DaoFeePool<T0>, arg1: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) : u128 {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::assert_interacting_with_most_up_to_date_package(arg1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::price::spot_price<T0, T1, T2>(0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::borrow_pool<T0>(arg0), arg2)
    }

    // decompiled from Move bytecode v6
}

