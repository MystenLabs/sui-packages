module 0x22ef6cf7afced707ad269b6552fc360bb000154f028fecb2ac225639d9ffa933::arb {
    public fun anchor_integer_mate() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero()
    }

    public fun bf_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295128739);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v3, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v3, 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun bf_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579053);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut v3, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun cetus_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), 4295128739, arg3);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v3, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v3, 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun cetus_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg3);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut v3, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun check_profit(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 > arg0 + arg2, 0);
    }

    public fun db_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, arg3);
        v1
    }

    public fun db_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, arg3);
        v0
    }

    public fun fxa_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg2)
    }

    public fun fxa_b2a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, arg1, arg2)
    }

    public fun fxc_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_x_to_y<T0, T1>(arg0, arg1, 4295128739, arg2, arg3, arg4), arg4)
    }

    public fun fxc_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_y_to_x<T0, T1>(arg0, arg1, 79226673515401279992447579055, arg2, arg3, arg4), arg4)
    }

    public fun mmt_a2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::coin::value<T0>(&arg2), 4295128739, arg3, arg1, arg4);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v3, v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, v3, 0x2::balance::zero<T1>(), arg1, arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun mmt_b2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg3, arg1, arg4);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::join<T1>(&mut v3, v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), v3, arg1, arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public entry fun r2_ba2b_ca2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ba2b_cb2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ba2b_da2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ba2b_db2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ba2b_ma2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ba2b_mb2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ba2b_ta2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ba2b_tb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_ca2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_cb2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_da2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_bb2a_db2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_bb2a_ma2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_mb2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_ta2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_bb2a_tb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_ba2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_bb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_da2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ca2b_db2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ca2b_ma2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_mb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ca2b_tb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_ba2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_bb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_da2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_cb2a_db2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_cb2a_ma2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_mb2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = mmt_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_ta2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_cb2a_tb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_da2b_ba2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = bf_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_bb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = bf_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_ca2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = cetus_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_cb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = cetus_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_ma2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = mmt_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_mb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = mmt_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_ta2b<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = turbos_a2b<T1, T0, T2>(arg1, v1, 0x2::coin::value<T1>(&v1), v2, 18446744073709551615, arg3, arg2, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v3), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_da2b_tb2a<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_a2b<T0, T1>(arg0, arg4, arg3, v0, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = turbos_b2a<T0, T1, T2>(arg1, v1, 0x2::coin::value<T1>(&v1), v2, 18446744073709551615, arg3, arg2, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v3), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_ba2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = bf_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_bb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = bf_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_ca2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = cetus_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_cb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = cetus_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_ma2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = mmt_a2b<T1, T0>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_mb2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = mmt_b2a<T0, T1>(arg1, arg2, v1, arg3, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_db2a_tb2a<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = db_b2a<T1, T0>(arg0, arg4, arg3, v0, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = turbos_b2a<T0, T1, T2>(arg1, v1, 0x2::coin::value<T1>(&v1), v2, 18446744073709551615, arg3, arg2, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v3), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ma2b_ba2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ma2b_bb2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ma2b_ca2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ma2b_cb2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ma2b_da2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ma2b_db2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ma2b_ta2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ma2b_tb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_ba2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_bb2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = bf_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_ca2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_a2b<T1, T0>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_cb2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = cetus_b2a<T0, T1>(arg2, arg3, v0, arg4, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v1), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_da2b<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_a2b<T1, T0>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_mb2a_db2a<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg4, arg3, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = db_b2a<T0, T1>(arg2, v0, arg3, v1, arg6);
        check_profit(0x2::coin::value<T0>(&arg4), 0x2::coin::value<T0>(&v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_mb2a_ta2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T1, T0, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_mb2a_tb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg5, arg4, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T0, T1, T2>(arg2, v0, 0x2::coin::value<T1>(&v0), v1, 18446744073709551615, arg4, arg3, arg7);
        check_profit(0x2::coin::value<T0>(&arg5), 0x2::coin::value<T0>(&v2), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_ba2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = bf_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_bb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = bf_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_ca2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = cetus_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_cb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = cetus_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_da2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg4, v0, v1, 18446744073709551615, arg3, arg1, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = db_a2b<T1, T0>(arg2, v2, arg3, v3, arg6);
        check_profit(v0, 0x2::coin::value<T0>(&v4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ta2b_db2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg4, v0, v1, 18446744073709551615, arg3, arg1, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = db_b2a<T0, T1>(arg2, v2, arg3, v3, arg6);
        check_profit(v0, 0x2::coin::value<T0>(&v4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_ta2b_ma2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = mmt_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_ta2b_mb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_a2b<T0, T1, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = mmt_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_ba2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = bf_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_bb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = bf_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_ca2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = cetus_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_cb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = cetus_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_da2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg4, v0, v1, 18446744073709551615, arg3, arg1, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = db_a2b<T1, T0>(arg2, v2, arg3, v3, arg6);
        check_profit(v0, 0x2::coin::value<T0>(&v4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_tb2a_db2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg4, v0, v1, 18446744073709551615, arg3, arg1, arg6);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = db_b2a<T0, T1>(arg2, v2, arg3, v3, arg6);
        check_profit(v0, 0x2::coin::value<T0>(&v4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
    }

    public entry fun r2_tb2a_ma2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = mmt_a2b<T1, T0>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r2_tb2a_mb2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = turbos_b2a<T1, T0, T2>(arg0, arg5, v0, v1, 18446744073709551615, arg4, arg1, arg7);
        let v3 = mmt_b2a<T0, T1>(arg2, arg3, v2, arg4, arg7);
        check_profit(v0, 0x2::coin::value<T0>(&v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg7));
    }

    public entry fun r3_ba2b_ca2b_ma2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ba2b_ca2b_mb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ba2b_cb2a_ma2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ba2b_cb2a_mb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_bb2a_ca2b_ma2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_bb2a_ca2b_mb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_bb2a_cb2a_ma2b<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_bb2a_cb2a_mb2a<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = bf_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = cetus_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = mmt_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ca2b_ma2b_ba2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ca2b_ma2b_bb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ca2b_mb2a_ba2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ca2b_mb2a_bb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_cb2a_ma2b_ba2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_cb2a_ma2b_bb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_cb2a_mb2a_ba2b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_cb2a_mb2a_bb2a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = cetus_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = mmt_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = bf_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ma2b_ba2b_ca2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ma2b_ba2b_cb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ma2b_bb2a_ca2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_ma2b_bb2a_cb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_a2b<T0, T1>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_mb2a_ba2b_ca2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_mb2a_ba2b_cb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_a2b<T1, T2>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_mb2a_bb2a_ca2b<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_a2b<T2, T0>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun r3_mb2a_bb2a_cb2a<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = mmt_b2a<T1, T0>(arg0, arg1, arg7, arg6, arg9);
        let v1 = bf_b2a<T2, T1>(arg2, arg3, v0, arg6, arg9);
        let v2 = cetus_b2a<T0, T2>(arg4, arg5, v1, arg6, arg9);
        check_profit(0x2::coin::value<T0>(&arg7), 0x2::coin::value<T0>(&v2), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg9));
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, arg2, 0, 4295128739, true, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        v1
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg1);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, arg2, 0, 79226673515401279992447579055, true, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        if (0x2::coin::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
        v1
    }

    // decompiled from Move bytecode v6
}

