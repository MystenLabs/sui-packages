module 0xb4bf74f8a235152b55ebf126d777bfffd237053cdbadbac53256213dde6df665::perp_arb {
    struct ArbEvent has copy, drop {
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        profit_ratio: u64,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg6: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg7: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg1, arg3, true, v1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            let v3 = if (arg3) {
                4295048016
            } else {
                79226673515401279992447579055
            };
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg1, arg3, true, v1, v3, arg4);
            let v7 = 0x2::object::new(arg9);
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v7, b"IN_TOKEN", v0);
            let (v8, v9, v10) = if (arg3) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T2>>(&mut v7, b"OUT_TOKEN", v5);
                0x2::balance::destroy_zero<T1>(v4);
                (0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T1>>(&mut v7, b"IN_TOKEN"), 0x2::balance::zero<T2>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v7, b"OUT_TOKEN"))
            } else {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v7, b"OUT_TOKEN", v4);
                0x2::balance::destroy_zero<T2>(v5);
                (0x2::balance::zero<T1>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T2>>(&mut v7, b"IN_TOKEN"), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v7, b"OUT_TOKEN"))
            };
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg1, v8, v9, v6);
            0x2::object::delete(v7);
            let v11 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::swap<T3, T0>(arg5, arg6, 0, arg7, arg8, 0x2::coin::from_balance<T3>(v10, arg9), v1, arg4, arg9);
            let v12 = 0x2::coin::value<T0>(&v11);
            let v13 = v12 - v1;
            let v14 = ArbEvent{
                amount_in    : v1,
                amount_out   : v12,
                profit       : v13,
                profit_ratio : 10000 * v13 / v1,
            };
            0x2::event::emit<ArbEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, 0x2::tx_context::sender(arg9));
        };
    }

    // decompiled from Move bytecode v6
}

