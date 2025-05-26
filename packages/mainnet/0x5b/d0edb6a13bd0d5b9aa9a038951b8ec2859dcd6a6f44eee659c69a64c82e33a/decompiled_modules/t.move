module 0x5bd0edb6a13bd0d5b9aa9a038951b8ec2859dcd6a6f44eee659c69a64c82e33a::t {
    struct C has copy, drop, store {
        dummy_field: bool,
    }

    struct V has copy, drop, store {
        dummy_field: bool,
    }

    struct Path has copy, drop {
        c0: u8,
        c1: u8,
        path_order: u8,
    }

    public fun c_m_b<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T5>, arg3: u128, arg4: u64) : u64 {
        let (v0, v1) = decode_path(arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = arg4;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Path>(&v2)) {
            let v6 = 0x1::vector::borrow<Path>(&v2, v5);
            let v7 = (v5 as u8);
            v5 = v5 + 1;
            let v8 = if (v3 == v6.c0) {
                v3 = v6.c1;
                true
            } else {
                v3 = v6.c0;
                false
            };
            if (v7 == 0x1::vector::borrow<Path>(&v2, 0).path_order) {
                sqrt_price_limit(v8);
                let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, v8, true, v4);
                v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v9);
                continue
            };
            if (v7 == 0x1::vector::borrow<Path>(&v2, 1).path_order) {
                let v10 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T2, T3>(arg1, v8, true, sqrt_price_limit(v8), v4);
                v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v10);
                continue
            };
            if (v7 == 0x1::vector::borrow<Path>(&v2, 2).path_order) {
                let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T4, T5>(arg2, v8, true, v4, sqrt_price_limit(v8));
                v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v11);
            };
        };
        v4
    }

    fun decode_path(arg0: u128) : (u8, vector<Path>) {
        let v0 = 0x1::vector::empty<Path>();
        let v1 = 0;
        let v2 = arg0 >> 6;
        while (v1 < arg0 >> 3 & 7) {
            let v3 = ((v2 & 15) as u8);
            let v4 = v2 >> 4;
            let v5 = v4 >> 3;
            v2 = v5 >> 3;
            let v6 = Path{
                c0         : ((v4 & 7) as u8),
                c1         : ((v5 & 7) as u8),
                path_order : v3,
            };
            0x1::vector::push_back<Path>(&mut v0, v6);
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

