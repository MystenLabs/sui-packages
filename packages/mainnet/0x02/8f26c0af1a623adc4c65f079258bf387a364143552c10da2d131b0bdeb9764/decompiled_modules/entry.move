module 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::entry {
    struct Fired has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    struct FiredFlash has copy, drop {
        pair_cetus: address,
        pair_bluefin: address,
        buy_on_cetus: bool,
        spread_bps: u64,
        size_b: u64,
        profit_b: u64,
    }

    fun a_to_b_units(arg0: u64, arg1: u128) : u64 {
        ((((arg0 as u256) * (arg1 as u256) >> 64) * (arg1 as u256) >> 64) as u64)
    }

    fun b_to_a_units(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256) * (arg1 as u256);
        if (v0 == 0) {
            return 18446744073709551615
        };
        (((((arg0 as u256) << 128) + v0 - 1) / v0) as u64)
    }

    fun bluefin_buy_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun bluefin_buy_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, arg2, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg2), 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun bluefin_sell_second<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), arg2, false, true, 0x2::balance::value<T1>(&arg2), 0, 79226673515401279992447579054);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun cetus_buy_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579054, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v3);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun cetus_sell_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048017, arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun payout<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun run_cetus_bluefin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        let v3 = if (v2 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v3) {
            return 0
        };
        let v4 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v5 = v0 < v1;
        let v6 = if (v5) {
            let v7 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v4, arg5), arg8);
            bluefin_sell_a<T0, T1>(arg2, arg3, v7, arg8)
        } else {
            let v8 = bluefin_buy_a<T0, T1>(arg2, arg3, 0x2::balance::split<T1>(v4, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v8, arg8)
        };
        let v9 = v6;
        let v10 = 0x2::balance::value<T1>(&v9);
        assert!(v10 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v4, v9);
        let v11 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v5,
            spread_bps   : v2,
            size_b       : arg5,
            profit_b     : v10 - arg5,
        };
        0x2::event::emit<Fired>(v11);
        v10 - arg5
    }

    public fun run_cetus_bluefin_flash<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v2 = spread_bps(v0, v1);
        if (v2 < arg5 || arg4 == 0) {
            return 0
        };
        let v3 = v0 < v1;
        let v4 = if (v3) {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v6);
            let v8 = bluefin_sell_a<T0, T1>(arg2, arg3, v5, arg7);
            assert!(0x2::balance::value<T1>(&v8) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v8, arg4), v7);
            payout<T1>(v8, arg8);
            0x2::balance::value<T1>(&v8)
        } else {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v12 = v11;
            0x2::balance::destroy_zero<T0>(v9);
            let v13 = bluefin_buy_a<T0, T1>(arg2, arg3, v10, arg7);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
            assert!(0x2::balance::value<T0>(&v13) >= v14 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::zero<T1>(), v12);
            payout<T0>(v13, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v13), v0)
        };
        let v15 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            buy_on_cetus : v3,
            spread_bps   : v2,
            size_b       : arg4,
            profit_b     : v4,
        };
        0x2::event::emit<FiredFlash>(v15);
        v4
    }

    public fun run_cetus_bluefin_flash_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        if (v3 < arg5 || arg4 == 0) {
            return 0
        };
        let v4 = v0 < v2;
        let v5 = if (v4) {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg4, 79226673515401279992447579054, arg7);
            0x2::balance::destroy_zero<T1>(v7);
            let v9 = bluefin_sell_second<T1, T0>(arg2, arg3, v6, arg7);
            assert!(0x2::balance::value<T1>(&v9) >= arg4 + arg6, 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v9, arg4), v8);
            payout<T1>(v9, arg8);
            0x2::balance::value<T1>(&v9)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, arg4, 4295048017, arg7);
            let v13 = v12;
            0x2::balance::destroy_zero<T0>(v10);
            let v14 = bluefin_buy_second<T1, T0>(arg2, arg3, v11, arg7);
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            assert!(0x2::balance::value<T0>(&v14) >= v15 + b_to_a_units(arg6, v0), 910);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v14, v15), 0x2::balance::zero<T1>(), v13);
            payout<T0>(v14, arg8);
            a_to_b_units(0x2::balance::value<T0>(&v14), v0)
        };
        let v16 = FiredFlash{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v4,
            spread_bps   : v3,
            size_b       : arg4,
            profit_b     : v5,
        };
        0x2::event::emit<FiredFlash>(v16);
        v5
    }

    public fun run_cetus_bluefin_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &mut 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::Vault<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            ((340282366920938463463374607431768211456 / (v1 as u256)) as u128)
        };
        let v3 = spread_bps(v0, v2);
        let v4 = if (v3 < arg6) {
            true
        } else if (0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::value<T1>(arg4) < arg5) {
            true
        } else {
            arg5 == 0
        };
        if (v4) {
            return 0
        };
        let v5 = 0xf5f7029970718c094119acdfc9cbc3b8c981a6cd2aa077ae30b68e85e1e870f::vault::borrow_mut<T1>(arg4);
        let v6 = v0 < v2;
        let v7 = if (v6) {
            let v8 = cetus_buy_a<T0, T1>(arg0, arg1, 0x2::balance::split<T1>(v5, arg5), arg8);
            bluefin_sell_second<T1, T0>(arg2, arg3, v8, arg8)
        } else {
            let v9 = bluefin_buy_second<T1, T0>(arg2, arg3, 0x2::balance::split<T1>(v5, arg5), arg8);
            cetus_sell_a<T0, T1>(arg0, arg1, v9, arg8)
        };
        let v10 = v7;
        let v11 = 0x2::balance::value<T1>(&v10);
        assert!(v11 >= arg5 + arg7, 910);
        0x2::balance::join<T1>(v5, v10);
        let v12 = Fired{
            pair_cetus   : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            pair_bluefin : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg3),
            buy_on_cetus : v6,
            spread_bps   : v3,
            size_b       : arg5,
            profit_b     : v11 - arg5,
        };
        0x2::event::emit<Fired>(v12);
        v11 - arg5
    }

    fun spread_bps(arg0: u128, arg1: u128) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg0 / 2 + arg1 / 2;
        if (v1 == 0) {
            return 0
        };
        ((v0 * 20000 / v1) as u64)
    }

    // decompiled from Move bytecode v7
}

