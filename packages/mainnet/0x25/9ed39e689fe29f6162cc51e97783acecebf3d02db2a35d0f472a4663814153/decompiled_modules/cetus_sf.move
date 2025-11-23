module 0x259ed39e689fe29f6162cc51e97783acecebf3d02db2a35d0f472a4663814153::cetus_sf {
    fun cswap_a2b(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg1, false, true, 0x2::coin::value<0x2::sui::SUI>(&arg2), 79226673515401279992447579055, arg4);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) >= arg3, 1);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(&v3), arg5)), v3);
        (0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4, arg5), arg2)
    }

    public entry fun execute_arbitrage_cetus<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg1, false, arg3);
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg10);
        0x2::balance::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0);
        let (v4, v5) = cswap_a2b(arg0, arg1, v3, arg4, arg8, arg10);
        let v6 = v4;
        let v7 = swap_on_turbos<T0>(arg2, v6, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6), arg5, arg6, arg7, arg8, arg9, v5, arg10);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        0x1::debug::print<u64>(&v8);
        0x1::debug::print<u64>(&arg3);
        let (v9, v10) = if (v8 > arg3) {
            let v11 = arg3 + arg3 / 100;
            if (v8 > v11) {
                (0x2::coin::split<0x2::sui::SUI>(&mut v7, v11, arg10), v7)
            } else {
                (v7, 0x2::coin::zero<0x2::sui::SUI>(arg10))
            }
        } else {
            (v7, 0x2::coin::zero<0x2::sui::SUI>(arg10))
        };
        let v12 = v10;
        let v13 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::coin::into_balance<0x2::sui::SUI>(v9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), v13, v2);
        if (0x2::coin::value<0x2::sui::SUI>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, arg6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v12);
        };
    }

    fun swap_on_turbos<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>();
        0x1::vector::push_back<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>(arg0, v0, arg2, arg3, 0, true, arg4, arg5, arg6, arg7, arg9);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, 0x2::tx_context::sender(arg9));
        0x2::coin::join<0x2::sui::SUI>(&mut v3, arg8);
        v3
    }

    // decompiled from Move bytecode v6
}

