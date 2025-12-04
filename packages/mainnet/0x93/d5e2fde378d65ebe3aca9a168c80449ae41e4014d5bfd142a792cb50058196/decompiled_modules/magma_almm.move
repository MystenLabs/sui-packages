module 0x28d548c72cf8271667c6282b6988f0af6f66fca4bb33778cf1d9d43fed7a52d7::magma_almm {
    struct MagmaSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        partner_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun swap<T0, T1>(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg8) {
            assert!(0x2::coin::value<T1>(&arg5) == 0, 13906834500760895487);
        } else {
            assert!(0x2::coin::value<T0>(&arg4) == 0, 13906834509350830079);
        };
        let (v0, v1, v2) = if (0x2::object::id_address<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg3) == @0x62ffdbc74413b9d1544d9c91fa068f4fa3fd4c47c1f92f3c8d4c817e1591cad9) {
            0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg2, arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
        } else {
            0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap_with_partner<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
        };
        let v3 = v2;
        let v4 = MagmaSwapEvent{
            pool         : 0x2::object::id<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>>(arg2),
            amount_in    : arg6,
            amount_out   : 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::amounts_out(&v3),
            a2b          : arg8,
            by_amount_in : true,
            partner_id   : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg3),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MagmaSwapEvent>(v4);
        (0x2::coin::from_balance<T0>(v0, arg11), 0x2::coin::from_balance<T1>(v1, arg11))
    }

    public fun swap_a2b<T0, T1>(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let (v2, v3) = swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, 0x2::coin::value<T0>(&arg4), 1, true, v1, arg5, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        v3
    }

    public fun swap_b2a<T0, T1>(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let (v2, v3) = swap<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, 0x2::coin::value<T1>(&arg4), 1, false, v1, arg5, arg6);
        0x2::coin::destroy_zero<T1>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

