module 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::cetus_adapter {
    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
    }

    public fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, arg2, v0, true, true, arg3, 4295048016, arg4, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, arg2, false, true, arg3, 79226673515401279992447579054, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v2);
        v1
    }

    public fun swap_router<T0, T1>(arg0: &mut 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::PermissionedReceipt, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::RouterAcl, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::access(arg3);
        let v1 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, u8, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::borrow_data<vector<u8>, u8, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::unwrap(0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<u8, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::bag_value::Value, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"funds");
            0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"funds", swap_a2b<T0, T1>(arg2, arg1, v4, 0x2::coin::value<T0>(&v4), arg4, arg5));
        } else {
            let v5 = 0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"funds");
            0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"funds", swap_b2a<T0, T1>(arg2, arg1, v5, 0x2::coin::value<T1>(&v5), arg4, arg5));
        };
        0x4a662bf7584bd1ef774ae22db4d7a37bed7678df328a4290e1a8fd5f39adbdbb::receipt::add_data<vector<u8>, u8, 0x7d798502daf9e53a65b7a725c855de31c7887913227b6d155bc49508d757510f::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

