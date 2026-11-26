module 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook_account {
    fun withdraw_all<T0>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<T0>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account(arg0), arg1, arg2);
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0x2::coin::into_balance<T0>(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw_funds<T0>(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg3), v0, arg1, arg2, arg3))
    }

    fun deposit<T0>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x2::accumulator::AccumulatorRoot, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit_funds<T0>(arg0, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg4), 0x2::coin::from_balance<T0>(arg2, arg4), arg1, arg3);
    }

    fun fill<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T2>, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        deposit<T2>(arg2, arg3, arg4, arg8, arg9);
        0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::deepbook_core_account::place_market_order<T0, T1>(arg0, arg1, arg2, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::generate_auth(arg9), 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, price_limit(arg6), arg6, arg7, arg3, arg8, arg9);
        let v0 = withdraw_all<T0>(arg2, arg3, arg8, arg9);
        (v0, withdraw_all<T1>(arg2, arg3, arg8, arg9))
    }

    fun lend_deep(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1, 0x2::balance::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), arg3, arg4);
    }

    public(friend) fun price_limit(arg0: bool) : u64 {
        if (arg0) {
            18446744073709551615
        } else {
            0
        }
    }

    fun reclaim_deep(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1, arg3, arg4));
    }

    public fun swap_base_for_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T0>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = swap_base_for_quote_with_leftover<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T0>(v1, arg5);
        v0
    }

    public fun swap_base_for_quote_deep_fee<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = swap_base_for_quote_deep_fee_with_leftover<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T0>(v1, arg6);
        v0
    }

    public fun swap_base_for_quote_deep_fee_with_leftover<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook::lot_floor<T0, T1>(arg0, 0x2::balance::value<T0>(&arg4));
        lend_deep(arg2, arg3, arg5, arg6, arg7);
        let (v1, v2) = fill<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, v0, false, true, arg6, arg7);
        reclaim_deep(arg2, arg3, arg5, arg6, arg7);
        (v2, v1)
    }

    public fun swap_base_for_quote_with_leftover<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook::lot_floor<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(0x2::balance::value<T0>(&arg4), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook::input_fee_rate<T0, T1>(arg0)));
        let (v1, v2) = fill<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, v0, false, false, arg5, arg6);
        (v2, v1)
    }

    public fun swap_quote_for_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T1>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = swap_quote_for_base_with_leftover<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T1>(v1, arg5);
        v0
    }

    public fun swap_quote_for_base_deep_fee<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = swap_quote_for_base_deep_fee_with_leftover<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement::settle<T1>(v1, arg6);
        v0
    }

    public fun swap_quote_for_base_deep_fee_with_leftover<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg4), arg6);
        let v3 = 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook::lot_floor<T0, T1>(arg0, v0);
        lend_deep(arg2, arg3, arg5, arg6, arg7);
        let (v4, v5) = fill<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, v3, true, true, arg6, arg7);
        reclaim_deep(arg2, arg3, arg5, arg6, arg7);
        (v4, v5)
    }

    public fun swap_quote_for_base_with_leftover<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg3: &0x2::accumulator::AccumulatorRoot, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg4), arg5);
        let v3 = 0xc645fb3109f94568b2caaba140d8ef7fcb1c29bc1dfaf12f7c39a45b14748ae7::deepbook::lot_floor<T0, T1>(arg0, v0);
        fill<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, v3, true, false, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

