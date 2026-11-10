module 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::vq_j {
    struct P has copy, drop {
        version: u64,
        freeze: u8,
        pool_type: u8,
        direction: u8,
        admin: u64,
        lp: u64,
        th: u64,
        x: u64,
        y: u64,
        x_admin: u64,
        y_admin: u64,
        x_th: u64,
        y_th: u64,
        bx: u64,
        by: u64,
        th_kind: u8,
    }

    fun amount(arg0: u128, arg1: u128, arg2: u128) : 0x1::option::Option<u128> {
        let v0 = arg1 + arg0;
        if (v0 == 0) {
            return 0x1::option::none<u128>()
        };
        let v1 = arg2 * arg0 / v0;
        if (v1 > 18446744073709551615) {
            return 0x1::option::none<u128>()
        };
        if (v0 * (arg2 - v1) < arg1 * arg2) {
            return 0x1::option::none<u128>()
        };
        0x1::option::some<u128>(v1)
    }

    public fun j<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = p(0x2::bcs::to_bytes<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>(arg1));
        let v1 = 0;
        while (v1 < 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::cn(arg0)) {
            let v2 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ra(arg0, v1);
            if (v2 > 0) {
                0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::sr(arg0, v1, o(&v0, arg2, v2));
            };
            v1 = v1 + 1;
        };
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::np(arg0, 0x2::object::id<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>(arg1), arg2);
    }

    fun o(arg0: &P, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg0.version != 0) {
            true
        } else if (arg0.freeze & 1 != 0) {
            true
        } else {
            arg0.pool_type != 100
        };
        if (v0) {
            return 0
        };
        let (v1, v2) = if (arg1) {
            ((arg0.x as u128), (arg0.y as u128))
        } else {
            ((arg0.y as u128), (arg0.x as u128))
        };
        let (v3, v4) = if (arg1) {
            ((arg0.x_admin as u128), (arg0.y_admin as u128))
        } else {
            ((arg0.y_admin as u128), (arg0.x_admin as u128))
        };
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = if (arg1) {
            ((arg0.x_th as u128), (arg0.y_th as u128))
        } else {
            ((arg0.y_th as u128), (arg0.x_th as u128))
        };
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = if (arg1) {
            ((arg0.bx as u128), (arg0.by as u128))
        } else {
            ((arg0.by as u128), (arg0.bx as u128))
        };
        let v13 = if (arg1) {
            200
        } else {
            201
        };
        let v14 = if (arg1) {
            201
        } else {
            200
        };
        let v15 = (arg2 as u128);
        let v16 = v15;
        if (arg0.direction == v13) {
            let v17 = partial((v15 as u64), arg0.admin);
            let v18 = v15 - v17;
            let v19 = partial((v18 as u64), arg0.th);
            v16 = v18 - v19;
            v6 = v3 + v17;
            v10 = v7 + v19;
        };
        let v20 = partial((v16 as u64), arg0.lp);
        let v21 = v16 - v20;
        let v22 = v1 + v11;
        let v23 = v2 + v12;
        let v24 = if (v22 > 18446744073709551615) {
            true
        } else if (v23 > 18446744073709551615) {
            true
        } else if (v22 == 0) {
            true
        } else {
            v23 == 0
        };
        if (v24) {
            return 0
        };
        let v25 = amount(v21, v22, v23);
        if (0x1::option::is_none<u128>(&v25)) {
            return 0
        };
        let v26 = 0x1::option::destroy_some<u128>(v25);
        if (v26 > v2) {
            return 0
        };
        let v27 = v26;
        if (arg0.direction == v14) {
            let v28 = partial((v26 as u64), arg0.admin);
            let v29 = v26 - v28;
            let v30 = partial((v29 as u64), arg0.th);
            v27 = v29 - v30;
            v5 = v4 + v28;
            v9 = v8 + v30;
        };
        let v31 = v1 + v21 + v20;
        let v32 = if (v31 > 18446744073709551615) {
            true
        } else if (v6 > 18446744073709551615) {
            true
        } else if (v5 > 18446744073709551615) {
            true
        } else if (v10 > 18446744073709551615) {
            true
        } else {
            v9 > 18446744073709551615
        };
        if (v32) {
            return 0
        };
        if (arg0.th_kind == 211) {
            let v33 = arg0.direction == v13;
            let (v34, v35, v36, v37, v38) = if (v33) {
                (v10, v31, v2 - v26, v11, v12)
            } else if (arg0.direction == v14) {
                (v9, v2 - v26, v31, v12, v11)
            } else {
                (0, 0, 0, 0, 0)
            };
            if (v34 > 0) {
                let v39 = v35 + v37;
                let v40 = v36 + v38;
                let v41 = if (v39 > 18446744073709551615) {
                    true
                } else if (v40 > 18446744073709551615) {
                    true
                } else if (v39 == 0) {
                    true
                } else {
                    v40 == 0
                };
                if (v41) {
                    return 0
                };
                let v42 = amount(v34, v39, v40);
                if (0x1::option::is_none<u128>(&v42)) {
                    return 0
                };
                let v43 = 0x1::option::destroy_some<u128>(v42);
                if (v43 > v36 || v35 + v34 > 18446744073709551615) {
                    return 0
                };
                let v44 = if (v33) {
                    v9
                } else {
                    v10
                };
                if (v44 + v43 > 18446744073709551615) {
                    return 0
                };
            };
        };
        (v27 as u64)
    }

    fun p(arg0: vector<u8>) : P {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(&mut v0)) {
            0x2::bcs::peel_u64(&mut v0);
            0x2::bcs::peel_u64(&mut v0);
            v1 = v1 + 1;
        };
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v2 = 0;
        while (v2 < 6) {
            0x2::bcs::peel_u128(&mut v0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 8) {
            0x2::bcs::peel_u64(&mut v0);
            v3 = v3 + 1;
        };
        0x2::bcs::peel_u128(&mut v0);
        0x2::bcs::peel_option_bool(&mut v0);
        0x2::bcs::peel_u256(&mut v0);
        0x2::bcs::peel_u256(&mut v0);
        0x2::bcs::peel_u256(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v4), 182);
        P{
            version   : 0x2::bcs::peel_u64(&mut v0),
            freeze    : 0x2::bcs::peel_u8(&mut v0),
            pool_type : 0x2::bcs::peel_u8(&mut v0),
            direction : 0x2::bcs::peel_u8(&mut v0),
            admin     : 0x2::bcs::peel_u64(&mut v0),
            lp        : 0x2::bcs::peel_u64(&mut v0),
            th        : 0x2::bcs::peel_u64(&mut v0),
            x         : 0x2::bcs::peel_u64(&mut v0),
            y         : 0x2::bcs::peel_u64(&mut v0),
            x_admin   : 0x2::bcs::peel_u64(&mut v0),
            y_admin   : 0x2::bcs::peel_u64(&mut v0),
            x_th      : 0x2::bcs::peel_u64(&mut v0),
            y_th      : 0x2::bcs::peel_u64(&mut v0),
            bx        : 0x2::bcs::peel_u64(&mut v0),
            by        : 0x2::bcs::peel_u64(&mut v0),
            th_kind   : 0x2::bcs::peel_u8(&mut v0),
        }
    }

    fun partial(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128) / 10000
    }

    // decompiled from Move bytecode v7
}

