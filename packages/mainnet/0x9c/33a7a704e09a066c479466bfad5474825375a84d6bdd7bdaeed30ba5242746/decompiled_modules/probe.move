module 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::probe {
    struct ProbeFired has copy, drop {
        pool_a: address,
        pool_b: address,
        buy_on_a: bool,
        x: u64,
        expected_out: u64,
        realized_out: u64,
        probes: u8,
    }

    fun bank<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun cetus_sell_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048017, arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    fun fired(arg0: address, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u8) {
        let v0 = ProbeFired{
            pool_a       : arg0,
            pool_b       : arg1,
            buy_on_a     : arg2,
            x            : arg3,
            expected_out : arg4,
            realized_out : arg5,
            probes       : arg6,
        };
        0x2::event::emit<ProbeFired>(v0);
    }

    fun kk(arg0: u8) : u8 {
        if (arg0 > 5) {
            5
        } else {
            arg0
        }
    }

    fun live(arg0: &0x2::clock::Clock, arg1: u64) : bool {
        arg1 == 0 || 0x2::clock::timestamp_ms(arg0) <= arg1
    }

    fun mmt_sell_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579054, arg3, arg1, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), arg2, arg1, arg4);
        v0
    }

    public fun probe_cetus_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (!live(arg9, arg8)) {
            return
        };
        let (v0, v1) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::gap::same(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), arg7);
        if (!v0) {
            return
        };
        let v2 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::new(arg3, arg4, kk(arg5));
        loop {
            let v3 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::next(&mut v2);
            if (v3 == 0) {
                break
            };
            let v4 = if (v1) {
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg2, true, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, false, v3))
            } else {
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, true, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg2, false, v3))
            };
            0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::record(&mut v2, v3, v4);
        };
        let (v5, v6, v7) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::result(&v2);
        if (v5 == 0 || v6 < v5 + arg6) {
            return
        };
        let v8 = if (v1) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v5, 79226673515401279992447579054, arg9);
            let v12 = v11;
            0x2::balance::destroy_zero<T1>(v10);
            let v13 = cetus_sell_a<T0, T1>(arg0, arg2, v9, arg9);
            let v14 = 0x2::balance::value<T1>(&v13);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(v14 >= v15 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v13, v15), v12);
            bank<T1>(v13, arg10);
            v14
        } else {
            let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg2, false, true, v5, 79226673515401279992447579054, arg9);
            let v19 = v18;
            0x2::balance::destroy_zero<T1>(v17);
            let v20 = cetus_sell_a<T0, T1>(arg0, arg1, v16, arg9);
            let v21 = 0x2::balance::value<T1>(&v20);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v19);
            assert!(v21 >= v22 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v20, v22), v19);
            bank<T1>(v20, arg10);
            v21
        };
        fired(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), v1, v5, v6, v8, v7);
    }

    public fun probe_cetus_momentum<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (!live(arg10, arg9)) {
            return
        };
        let (v0, v1) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::gap::flip(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg2), arg8);
        if (!v0) {
            return
        };
        let v2 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::new(arg4, arg5, kk(arg6));
        loop {
            let v3 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::next(&mut v2);
            if (v3 == 0) {
                break
            };
            let v4 = if (v1) {
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::momentum_out<T1, T0>(arg2, false, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, false, v3))
            } else {
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, true, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::momentum_out<T1, T0>(arg2, true, v3))
            };
            0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::record(&mut v2, v3, v4);
        };
        let (v5, v6, v7) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::result(&v2);
        if (v5 == 0 || v6 < v5 + arg7) {
            return
        };
        let v8 = if (v1) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v5, 79226673515401279992447579054, arg10);
            let v12 = v11;
            0x2::balance::destroy_zero<T1>(v10);
            let v13 = mmt_sell_y<T1, T0>(arg2, arg3, v9, arg10, arg11);
            let v14 = 0x2::balance::value<T1>(&v13);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(v14 >= v15 + arg7, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v13, v15), v12);
            bank<T1>(v13, arg11);
            v14
        } else {
            let (v16, v17, v18) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg2, true, true, v5, 4295048017, arg10, arg3, arg11);
            0x2::balance::destroy_zero<T1>(v16);
            let v19 = cetus_sell_a<T0, T1>(arg0, arg1, v17, arg10);
            let v20 = 0x2::balance::value<T1>(&v19);
            assert!(v20 >= v5 + arg7, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg2, v18, 0x2::balance::split<T1>(&mut v19, v5), 0x2::balance::zero<T0>(), arg3, arg11);
            bank<T1>(v19, arg11);
            v20
        };
        fired(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg2), v1, v5, v6, v8, v7);
    }

    public fun probe_cetus_turbos<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (!live(arg10, arg9)) {
            return
        };
        let (v0, v1) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::gap::same(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), arg8);
        if (!v0) {
            return
        };
        let v2 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::new(arg4, arg5, kk(arg6));
        loop {
            let v3 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::next(&mut v2);
            if (v3 == 0) {
                break
            };
            let v4 = if (v1) {
                let (v5, _) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg2, true, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, false, v3));
                v5
            } else {
                let (v7, _) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg2, false, v3);
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::cetus_out<T0, T1>(arg1, true, v7)
            };
            0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::record(&mut v2, v3, v4);
        };
        let (v9, v10, v11) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::result(&v2);
        if (v9 == 0 || v10 < v9 + arg7) {
            return
        };
        let (v12, v13) = if (v1) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v9, 79226673515401279992447579054, arg10);
            let v17 = v16;
            0x2::balance::destroy_zero<T1>(v15);
            let v18 = turbos_sell_a<T0, T1, T2>(arg2, arg3, v14, arg10, arg11);
            let v19 = 0x2::balance::value<T1>(&v18);
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17);
            assert!(v19 >= v20 + arg7, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v18, v20), v17);
            bank<T1>(v18, arg11);
            (v19, v20)
        } else {
            let (_, v22) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg2, false, v9);
            if (v22 == 0) {
                return
            };
            let (v23, v24, v25) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, @0x0, false, (v9 as u128), true, v22, arg10, arg3, arg11);
            let v26 = v25;
            0x2::coin::destroy_zero<T1>(v24);
            let (_, _, v29) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v26);
            let v30 = cetus_sell_a<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v23), arg10);
            let v31 = 0x2::balance::value<T1>(&v30);
            assert!(v31 >= v29 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, 0x2::coin::zero<T0>(arg11), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v30, v29), arg11), v26, arg3);
            bank<T1>(v30, arg11);
            (v31, v29)
        };
        fired(0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), v1, v13, v10, v12, v11);
    }

    public fun probe_turbos_momentum<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (!live(arg10, arg9)) {
            return
        };
        let (v0, v1) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::gap::flip(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg2), arg8);
        if (!v0) {
            return
        };
        let v2 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::new(arg4, arg5, kk(arg6));
        loop {
            let v3 = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::next(&mut v2);
            if (v3 == 0) {
                break
            };
            let v4 = if (v1) {
                let (v5, _) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg0, false, v3);
                0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::momentum_out<T1, T0>(arg2, false, v5)
            } else {
                let (v7, _) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg0, true, 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::momentum_out<T1, T0>(arg2, true, v3));
                v7
            };
            0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::record(&mut v2, v3, v4);
        };
        let (v9, v10, v11) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::search::result(&v2);
        if (v9 == 0 || v10 < v9 + arg7) {
            return
        };
        let (v12, v13) = if (v1) {
            let (_, v15) = 0x9c33a7a704e09a066c479466bfad5474825375a84d6bdd7bdaeed30ba5242746::q::turbos_step<T0, T1, T2>(arg0, false, v9);
            if (v15 == 0) {
                return
            };
            let (v16, v17, v18) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, false, (v9 as u128), true, v15, arg10, arg1, arg11);
            let v19 = v18;
            0x2::coin::destroy_zero<T1>(v17);
            let (_, _, v22) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v19);
            let v23 = mmt_sell_y<T1, T0>(arg2, arg3, 0x2::coin::into_balance<T0>(v16), arg10, arg11);
            let v24 = 0x2::balance::value<T1>(&v23);
            assert!(v24 >= v22 + arg7, 910);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg11), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v23, v22), arg11), v19, arg1);
            bank<T1>(v23, arg11);
            (v24, v22)
        } else {
            let (v25, v26, v27) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg2, true, true, v9, 4295048017, arg10, arg3, arg11);
            0x2::balance::destroy_zero<T1>(v25);
            let v28 = turbos_sell_a<T0, T1, T2>(arg0, arg1, v26, arg10, arg11);
            let v29 = 0x2::balance::value<T1>(&v28);
            assert!(v29 >= v9 + arg7, 910);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg2, v27, 0x2::balance::split<T1>(&mut v28, v9), 0x2::balance::zero<T0>(), arg3, arg11);
            bank<T1>(v28, arg11);
            (v29, v9)
        };
        fired(0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0), 0x2::object::id_address<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg2), v1, v13, v10, v12, v11);
    }

    fun turbos_sell_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, @0x0, true, (0x2::coin::value<T0>(&v0) as u128), true, 4295048017, arg3, arg1, arg4);
        0x2::coin::destroy_zero<T0>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v0, 0x2::coin::zero<T1>(arg4), v3, arg1);
        0x2::coin::into_balance<T1>(v2)
    }

    // decompiled from Move bytecode v7
}

