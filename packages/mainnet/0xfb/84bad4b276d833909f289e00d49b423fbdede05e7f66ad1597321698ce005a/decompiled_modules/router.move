module 0xfb84bad4b276d833909f289e00d49b423fbdede05e7f66ad1597321698ce005a::router {
    public fun bluefin_spot_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), true, true, v0, 1, 4295048017);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg4);
        destroy_or_transfer<T0>(0x2::coin::from_balance<T0>(v1, arg4), arg4);
        0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_hop_log(0x1::string::utf8(b"bluefin_spot"), 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x1::type_name::into_string(0x1::type_name::get<T1>()), v0, 0x2::coin::value<T1>(&v3));
        v3
    }

    public fun bluefin_spot_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), false, true, v0, 1, 79226673515401279992447579054);
        let v3 = 0x2::coin::from_balance<T0>(v1, arg4);
        destroy_or_transfer<T1>(0x2::coin::from_balance<T1>(v2, arg4), arg4);
        0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_hop_log(0x1::string::utf8(b"bluefin_spot"), 0x1::type_name::into_string(0x1::type_name::get<T1>()), 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0, 0x2::coin::value<T0>(&v3));
        v3
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun finalize_swap<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u16, arg6: address, arg7: u16, arg8: u16, arg9: address, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        if (arg5 > 0) {
            if (arg4) {
                let v1 = (((arg1 as u128) * (arg5 as u128) / 10000) as u64);
                if (v1 > 0) {
                    0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_commission(arg5, arg4, v1, arg6, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
                };
            } else {
                let v2 = (((v0 as u128) * (arg5 as u128) / 10000) as u64);
                if (v2 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0, v2, arg11), arg6);
                    0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_commission(arg5, arg4, v2, arg6, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
                };
            };
        };
        let v3 = if (v0 > arg2) {
            if (arg7 > 0) {
                arg8 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let v4 = ((((v0 - arg2) as u128) * (arg7 as u128) / 10000) as u64);
            let v5 = v4;
            let v6 = (((v0 as u128) * (arg8 as u128) / 10000) as u64);
            if (v4 > v6) {
                v5 = v6;
            };
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0, v5, arg11), arg9);
                0x12d0c01a8d3cc114d8a68e7f78d9f1abf661c2f63b113377396c7eb987f913c5::liquid_mesh_pos_slip_events::emit_positive_slippage(arg10, 0x2::tx_context::sender(arg11), arg9, arg2, v0, v5, arg7, arg8, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
                0x2::coin::value<T1>(&arg0);
            };
        };
        let v7 = 0x2::coin::value<T1>(&arg0);
        0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_swap_log(arg10, 0x2::tx_context::sender(arg11), arg1, arg2, arg3, v7, 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        assert!(v7 >= arg3, 0);
        arg0
    }

    public fun split_coin_with_weight<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64), arg2)
    }

    // decompiled from Move bytecode v6
}

