module 0xc0881d061138b84fb629a6202436b0c954e3f55eefd84eb9f2d0b6bfbabb293a::router {
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

    public fun finalize_swap<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u16, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg5 > 0) {
            if (arg4) {
                let v0 = (((arg1 as u128) * (arg5 as u128) / 10000) as u64);
                if (v0 > 0) {
                    0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_commission(arg5, arg4, v0, arg6, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
                };
            } else {
                let v1 = (((0x2::coin::value<T1>(&arg0) as u128) * (arg5 as u128) / 10000) as u64);
                if (v1 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0, v1, arg8), arg6);
                    0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_commission(arg5, arg4, v1, arg6, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
                };
            };
        };
        let v2 = 0x2::coin::value<T1>(&arg0);
        0x8a40414be96f8b3f3fdcbfc3c7cc6174116cbaea171d96a781105692d777df6e::liquid_mesh_events::emit_swap_log(arg7, 0x2::tx_context::sender(arg8), arg1, arg2, arg3, v2, 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        assert!(v2 >= arg3, 0);
        arg0
    }

    public fun split_coin_with_weight<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64), arg2)
    }

    // decompiled from Move bytecode v6
}

