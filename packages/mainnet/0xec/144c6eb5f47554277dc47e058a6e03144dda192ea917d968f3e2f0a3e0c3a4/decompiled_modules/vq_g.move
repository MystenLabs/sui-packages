module 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::vq_g {
    public fun g<T0, T1>(arg0: &mut 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::Ht, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::checked_package_version(arg1);
        let v0 = 0;
        while (v0 < 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::cn(arg0)) {
            let v1 = 0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::ra(arg0, v0);
            if (v1 > 0) {
                let v2 = if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg2)) {
                    0
                } else {
                    o<T0, T1>(arg2, arg3, v1)
                };
                0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::sr(arg0, v0, v2);
            };
            v0 = v0 + 1;
        };
        0xec144c6eb5f47554277dc47e058a6e03144dda192ea917d968f3e2f0a3e0c3a4::hz::np(arg0, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg2), arg3);
    }

    public(friend) fun o<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        if (arg1) {
            if (v1 <= v0) {
                return 0
            };
        } else if (v1 >= v0) {
            return 0
        };
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_magma_distribution_staked_liquidity<T0, T1>(arg0);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v6 = arg2;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v6 > 0 && v1 != v0) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v5)) {
                return 0
            };
            let (v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v4, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v5), arg1);
            v5 = v11;
            let v12 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v10);
            let v13 = if (arg1) {
                if (v0 > v12) {
                    v0
                } else {
                    v12
                }
            } else if (v0 < v12) {
                v0
            } else {
                v12
            };
            if (v2 > 0) {
                if (arg1) {
                    if (v1 < v13) {
                        return 0
                    };
                } else if (v1 >= v13) {
                    return 0
                };
            };
            let (v14, v15, v16, v17) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v1, v13, v2, v6, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            if (v14 != 0 || v17 != 0) {
                if (v6 < v14) {
                    return 0
                };
                let v18 = v6 - v14;
                if (v18 < v17) {
                    return 0
                };
                v6 = v18 - v17;
                let v19 = v7 + (v14 as u128);
                v7 = v19;
                let v20 = v8 + (v15 as u128);
                v8 = v20;
                let v21 = v9 + (v17 as u128);
                v9 = v21;
                let v22 = if (v19 > 18446744073709551615) {
                    true
                } else if (v20 > 18446744073709551615) {
                    true
                } else {
                    v21 > 18446744073709551615
                };
                if (v22) {
                    return 0
                };
            };
            if (v16 == v12) {
                v1 = v13;
                let (v23, v24) = if (arg1) {
                    (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v10)), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v10)))
                } else {
                    (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v10), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v10))
                };
                let v25 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v23);
                let v26 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v24);
                if (!0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v23)) {
                    if (340282366920938463463374607431768211455 - v2 < v25 || 340282366920938463463374607431768211455 - v3 < v26) {
                        return 0
                    };
                    v2 = v2 + v25;
                    continue
                };
                if (v2 < v25 || v3 < v26) {
                    return 0
                };
                v2 = v2 - v25;
                continue
            };
            if (v1 != v16) {
                v1 = v16;
            };
        };
        if (v6 > 0) {
            return 0
        };
        if (v8 == 0) {
            return 0
        };
        let (v27, v28) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg0);
        let v29 = if (arg1) {
            v28
        } else {
            v27
        };
        if (v8 > (v29 as u128)) {
            return 0
        };
        (v8 as u64)
    }

    // decompiled from Move bytecode v7
}

