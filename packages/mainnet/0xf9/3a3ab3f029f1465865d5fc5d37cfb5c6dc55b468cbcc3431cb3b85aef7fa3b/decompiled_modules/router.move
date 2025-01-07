module 0xf93a3ab3f029f1465865d5fc5d37cfb5c6dc55b468cbcc3431cb3b85aef7fa3b::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
    }

    struct OrderRecord2 has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    entry fun bluemove_stable_swap_exact_input<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
        let v1 = OrderRecord2{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<OrderRecord2>(v1);
    }

    entry fun bluemove_swap_exact_input<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
        let v1 = OrderRecord2{
            order_id   : arg4,
            decimal    : arg5,
            out_amount : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<OrderRecord2>(v1);
    }

    entry fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        0xf93a3ab3f029f1465865d5fc5d37cfb5c6dc55b468cbcc3431cb3b85aef7fa3b::cetus_adapter::swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg10);
        let v0 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        0xf93a3ab3f029f1465865d5fc5d37cfb5c6dc55b468cbcc3431cb3b85aef7fa3b::cetus_adapter::swap<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg10);
        let v0 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun suiswap_x_2_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = OrderRecord{
            order_id : arg5,
            decimal  : arg6,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun suiswap_y_2_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = OrderRecord{
            order_id : arg5,
            decimal  : arg6,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun turbos_swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg6);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg12));
        };
        let v4 = OrderRecord2{
            order_id   : arg10,
            decimal    : arg11,
            out_amount : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<OrderRecord2>(v4);
    }

    entry fun turbos_swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg6);
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg12));
        };
        let v4 = OrderRecord2{
            order_id   : arg10,
            decimal    : arg11,
            out_amount : 0x2::coin::value<T0>(&v3),
        };
        0x2::event::emit<OrderRecord2>(v4);
    }

    // decompiled from Move bytecode v6
}

