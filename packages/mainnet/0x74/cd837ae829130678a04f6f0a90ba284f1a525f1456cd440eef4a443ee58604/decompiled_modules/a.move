module 0x74cd837ae829130678a04f6f0a90ba284f1a525f1456cd440eef4a443ee58604::a {
    public fun xl<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, arg3, arg4);
        let v4 = v1;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v3);
        if (0x2::balance::value<T0>(&v4) == 0) {
            0x2::balance::destroy_zero<T0>(v4);
        } else {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v4, arg5), arg5);
        };
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun yl<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 101);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, arg3, arg4);
        let v4 = v2;
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v3);
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v4, arg5), arg5);
        };
        0x2::coin::from_balance<T0>(v1, arg5)
    }

    // decompiled from Move bytecode v6
}

