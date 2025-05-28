module 0xe09270b54c10ce7d914c19faa549f6e0a8f846ebfcf9b596f88b8fc2df3a724e::t {
    struct F____ has store, key {
        id: 0x2::object::UID,
    }

    struct P____________ has copy, drop {
        c0: u8,
        c1: u8,
        po: u8,
    }

    public fun c_m_b_h<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg3: &0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::oracle_driven_pool::Pool<T6, T7>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T8, T9>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T10, T11>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u128, arg9: u64, arg10: u64, arg11: bool, arg12: 0x1::option::Option<vector<u64>>, arg13: &F____, arg14: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = l_______(arg8);
        let v2 = v1;
        let v3 = 0;
        let v4 = true;
        let v5 = vector[];
        let v6 = 0x1::option::borrow_with_default<vector<u64>>(&arg12, &v5);
        let v7 = 0;
        let v8 = 0;
        let v9 = v8;
        while (v4 || v7 < 0x1::vector::length<u64>(v6)) {
            let v10 = if (v4) {
                arg9
            } else {
                let v11 = *0x1::vector::borrow<u64>(v6, v7);
                v7 = v7 + 1;
                v11
            };
            let v12 = v10;
            let v13 = 0;
            let v14 = v0;
            while (v13 < 0x1::vector::length<P____________>(&v2)) {
                let v15 = 0x1::vector::borrow<P____________>(&v2, v13);
                let v16 = (v13 as u8);
                v13 = v13 + 1;
                let v17 = v14 == v15.c0;
                if (v16 == 0x1::vector::borrow<P____________>(&v2, 0).po) {
                    let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, v17, true, v12);
                    v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v18);
                } else if (v16 == 0x1::vector::borrow<P____________>(&v2, 1).po) {
                    let v19 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T2, T3>(arg1, v17, true, sqrt_price_limit(v17), v12);
                    v12 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v19);
                } else if (v16 == 0x1::vector::borrow<P____________>(&v2, 5).po) {
                    let v20 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T10, T11>(arg5, v17, true, sqrt_price_limit(v17), v12);
                    v12 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v20);
                } else if (v16 == 0x1::vector::borrow<P____________>(&v2, 2).po) {
                    let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T4, T5>(arg2, v17, true, v12, sqrt_price_limit(v17));
                    v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v21);
                } else if (v16 == 0x1::vector::borrow<P____________>(&v2, 4).po) {
                    let v22 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T8, T9>(arg4, v17, true, v12, sqrt_price_limit(v17));
                    v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v22);
                } else if (v16 == 0x1::vector::borrow<P____________>(&v2, 3).po) {
                    if (v17) {
                        v12 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_base_coin<T6, T7>(arg3, arg14, arg6, arg7, v12);
                    } else {
                        v12 = 0xa0e3b011012b80af4957afa30e556486eb3da0a7d96eeb733cf16ccd3aec32e0::trader::query_sell_quote_coin<T6, T7>(arg3, arg14, arg6, arg7, v12);
                    };
                } else {
                    continue
                };
                if (v17) {
                    v14 = v15.c1;
                    continue
                };
                v14 = v15.c0;
            };
            if (v4) {
                v4 = false;
                if (v12 > arg9 && v12 >= arg9 + arg10) {
                    v3 = v12;
                    v9 = v12 - arg9;
                    break
                } else {
                    continue
                };
            };
            if (v12 > v12 && v12 >= v12 + arg10) {
                let v23 = v12 - v12;
                if (v23 > v8) {
                    v9 = v23;
                    v3 = v12;
                    if (arg11) {
                        break
                    };
                };
            };
        };
        assert!(v3 > 0, 1);
        assert!(v9 >= arg10, 2);
        (v3, v9)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = F____{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<F____>(v0, 0x2::tx_context::sender(arg0));
    }

    fun l_______(arg0: u128) : (u8, vector<P____________>) {
        let v0 = 0x1::vector::empty<P____________>();
        let v1 = 0;
        let v2 = arg0 >> 6;
        while (v1 < arg0 >> 3 & 7) {
            let v3 = ((v2 & 15) as u8);
            let v4 = v2 >> 4;
            let v5 = v4 >> 3;
            v2 = v5 >> 3;
            let v6 = P____________{
                c0 : ((v4 & 7) as u8),
                c1 : ((v5 & 7) as u8),
                po : v3,
            };
            0x1::vector::push_back<P____________>(&mut v0, v6);
            v1 = v1 + 1;
        };
        (((arg0 & 7) as u8), v0)
    }

    fun sqrt_price_limit(arg0: bool) : u128 {
        if (arg0) {
            4295048016
        } else {
            79226673515401279992447579055
        }
    }

    // decompiled from Move bytecode v6
}

