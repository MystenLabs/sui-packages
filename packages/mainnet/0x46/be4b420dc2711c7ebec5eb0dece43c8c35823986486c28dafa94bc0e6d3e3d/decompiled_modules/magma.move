module 0x46be4b420dc2711c7ebec5eb0dece43c8c35823986486c28dafa94bc0e6d3e3d::magma {
    struct A has key {
        id: 0x2::object::UID,
        a: 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::linked_table::LinkedTable<address, u128>,
    }

    public fun atob<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 4295048016, arg4);
        let v3 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        let v4 = 0x46be4b420dc2711c7ebec5eb0dece43c8c35823986486c28dafa94bc0e6d3e3d::help::merge_all<T0>(arg2, arg5);
        0x46be4b420dc2711c7ebec5eb0dece43c8c35823986486c28dafa94bc0e6d3e3d::help::transfer<T0>(v4, 0x2::tx_context::sender(arg5));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, arg3, arg5)), 0x2::balance::zero<T1>(), v2);
        (0x2::coin::from_balance<T1>(v3, arg5), 0x2::balance::value<T1>(&v3))
    }

    public fun atob1<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = atob<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun btoa<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, 79226673515401279992447579055, arg4);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x46be4b420dc2711c7ebec5eb0dece43c8c35823986486c28dafa94bc0e6d3e3d::help::merge_all<T1>(arg2, arg5);
        0x46be4b420dc2711c7ebec5eb0dece43c8c35823986486c28dafa94bc0e6d3e3d::help::transfer<T1>(v4, 0x2::tx_context::sender(arg5));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, arg3, arg5)), v2);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::balance::value<T0>(&v3))
    }

    public fun btoa1<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = btoa<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v7
}

