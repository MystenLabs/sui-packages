module 0xbde4ffcd90a9df2a5df5188a15d0a03f24bda92be3addde09615c39e0a9bfd23::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
        out_amount: u64,
    }

    struct DexType has copy, drop {
        dex_name: 0x1::string::String,
    }

    struct SwapParams has copy, drop {
        amount_in: u64,
        min_amount_out: u64,
        is_x_2_y: bool,
        order_id: u64,
        decimal: u8,
    }

    struct SuiswapParams has copy, drop {
        dummy_field: bool,
    }

    struct CetusParams has copy, drop {
        by_amount_in: bool,
        sqrt_price_limit: u128,
    }

    struct TurbosParams has copy, drop {
        sqrt_price_limit: u128,
        is_exact_in: bool,
        deadline: u64,
        recipient: address,
    }

    struct BluemoveParams has copy, drop {
        dummy_field: bool,
    }

    struct BluemoveStableParams has copy, drop {
        dummy_field: bool,
    }

    struct DexSpecificParams has copy, drop {
        suiswap: 0x1::option::Option<SuiswapParams>,
        cetus: 0x1::option::Option<CetusParams>,
        turbos: 0x1::option::Option<TurbosParams>,
        bluemove: 0x1::option::Option<BluemoveParams>,
        bluemove_stable: 0x1::option::Option<BluemoveStableParams>,
    }

    struct PoolInfo<phantom T0, phantom T1, phantom T2> {
        suiswap: 0x1::option::Option<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>,
        cetus: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>,
        turbos: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>,
    }

    struct DexConfig {
        cetus: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>,
        turbos: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>,
        bluemove: 0x1::option::Option<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>,
        bluemove_stable: 0x1::option::Option<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info>,
    }

    entry fun bluemove_stable_swap_exact_input<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = bluemove_stable_swap_exact_input_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun bluemove_stable_swap_exact_input_with_return<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v1,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    entry fun bluemove_swap_exact_input<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = bluemove_swap_exact_input_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun bluemove_swap_exact_input_with_return<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = OrderRecord{
            order_id   : arg4,
            decimal    : arg5,
            out_amount : v1,
        };
        0x2::event::emit<OrderRecord>(v2);
        (v0, v1)
    }

    entry fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = cetus_swap_a2b_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun cetus_swap_a2b_with_return<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = 0xbde4ffcd90a9df2a5df5188a15d0a03f24bda92be3addde09615c39e0a9bfd23::cetus_adapter::swapWithReturn<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = v1;
        destroy_or_transfer<T0>(v0, arg10);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = OrderRecord{
            order_id   : arg8,
            decimal    : arg9,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    entry fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = cetus_swap_b2a_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun cetus_swap_b2a_with_return<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0xbde4ffcd90a9df2a5df5188a15d0a03f24bda92be3addde09615c39e0a9bfd23::cetus_adapter::swapWithReturn<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg10);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg10);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = OrderRecord{
            order_id   : arg8,
            decimal    : arg9,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    fun destroy_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) {
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::destroy_zero<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun end_route_and_check_valid<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort 1
        };
        destroy_or_transfer<T0>(arg0, arg4);
        let v1 = OrderRecord{
            order_id   : arg2,
            decimal    : arg3,
            out_amount : v0,
        };
        0x2::event::emit<OrderRecord>(v1);
    }

    public fun split_with_percentage<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 * arg1 / 10000;
        (0x2::coin::split<T0>(arg0, v1, arg2), 0x2::coin::split<T0>(arg0, v0 - v1, arg2))
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 <= 300, 2);
        let (v0, v1) = split_with_percentage<T0>(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
        v1
    }

    entry fun suiswap_x_2_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = suiswap_x_2_y_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun suiswap_x_2_y_with_return<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, arg1, arg2, arg4, arg7);
        let v2 = v1;
        destroy_or_transfer<T0>(v0, arg7);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    entry fun suiswap_y_2_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = suiswap_y_2_x_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun suiswap_y_2_x_with_return<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, arg1, arg2, arg4, arg7);
        let v2 = v1;
        destroy_or_transfer<T1>(v0, arg7);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = OrderRecord{
            order_id   : arg5,
            decimal    : arg6,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    entry fun turbos_swap_a_b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = turbos_swap_a_b_with_return<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg6);
    }

    public fun turbos_swap_a_b_with_return<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v0;
        destroy_or_transfer<T0>(v1, arg12);
        let v3 = 0x2::coin::value<T1>(&v2);
        let v4 = OrderRecord{
            order_id   : arg10,
            decimal    : arg11,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    entry fun turbos_swap_b_a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = turbos_swap_b_a_with_return<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg6);
    }

    public fun turbos_swap_b_a_with_return<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: u64, arg11: u8, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg9);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = v0;
        destroy_or_transfer<T1>(v1, arg12);
        let v3 = 0x2::coin::value<T0>(&v2);
        let v4 = OrderRecord{
            order_id   : arg10,
            decimal    : arg11,
            out_amount : v3,
        };
        0x2::event::emit<OrderRecord>(v4);
        (v2, v3)
    }

    public fun universal_swap<T0, T1, T2>(arg0: 0x1::string::String, arg1: 0x1::option::Option<vector<0x2::coin::Coin<T0>>>, arg2: 0x1::option::Option<vector<0x2::coin::Coin<T1>>>, arg3: SwapParams, arg4: DexSpecificParams, arg5: &mut PoolInfo<T0, T1, T2>, arg6: &mut DexConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<vector<0x2::coin::Coin<T0>>>(&arg1)) {
            0x1::option::extract<vector<0x2::coin::Coin<T0>>>(&mut arg1)
        } else {
            0x1::vector::empty<0x2::coin::Coin<T0>>()
        };
        let v1 = v0;
        let v2 = if (0x1::option::is_some<vector<0x2::coin::Coin<T1>>>(&arg2)) {
            0x1::option::extract<vector<0x2::coin::Coin<T1>>>(&mut arg2)
        } else {
            0x1::vector::empty<0x2::coin::Coin<T1>>()
        };
        let v3 = v2;
        if (arg0 == 0x1::string::utf8(b"SUISWAP")) {
            let v4 = 0x1::option::borrow_mut<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>(&mut arg5.suiswap);
            0x1::option::borrow_mut<SuiswapParams>(&mut arg4.suiswap);
            if (arg3.is_x_2_y) {
                let (v5, _) = suiswap_x_2_y_with_return<T0, T1>(v4, v1, arg3.amount_in, arg3.min_amount_out, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg8));
                destroy_coins<T1>(v3);
            } else {
                let (v7, _) = suiswap_y_2_x_with_return<T0, T1>(v4, v3, arg3.amount_in, arg3.min_amount_out, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg8));
                destroy_coins<T0>(v1);
            };
        } else if (arg0 == 0x1::string::utf8(b"CETUS")) {
            let v9 = 0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&mut arg5.cetus);
            let v10 = 0x1::option::borrow_mut<CetusParams>(&mut arg4.cetus);
            if (arg3.is_x_2_y) {
                let (v11, _) = cetus_swap_a2b_with_return<T0, T1>(0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(&mut arg6.cetus), v9, v1, v10.by_amount_in, arg3.amount_in, arg3.min_amount_out, v10.sqrt_price_limit, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, 0x2::tx_context::sender(arg8));
                destroy_coins<T1>(v3);
            } else {
                let (v13, _) = cetus_swap_b2a_with_return<T0, T1>(0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(&mut arg6.cetus), v9, v3, v10.by_amount_in, arg3.amount_in, arg3.min_amount_out, v10.sqrt_price_limit, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, 0x2::tx_context::sender(arg8));
                destroy_coins<T0>(v1);
            };
        } else if (arg0 == 0x1::string::utf8(b"TURBOS")) {
            let v15 = 0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&mut arg5.turbos);
            let v16 = 0x1::option::borrow_mut<TurbosParams>(&mut arg4.turbos);
            if (arg3.is_x_2_y) {
                let (v17, _) = turbos_swap_a_b_with_return<T0, T1, T2>(v15, v1, arg3.amount_in, arg3.min_amount_out, v16.sqrt_price_limit, v16.is_exact_in, v16.recipient, v16.deadline, arg7, 0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(&mut arg6.turbos), arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, v16.recipient);
                destroy_coins<T1>(v3);
            } else {
                let (v19, _) = turbos_swap_b_a_with_return<T0, T1, T2>(v15, v3, arg3.amount_in, arg3.min_amount_out, v16.sqrt_price_limit, v16.is_exact_in, v16.recipient, v16.deadline, arg7, 0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned>(&mut arg6.turbos), arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v16.recipient);
                destroy_coins<T0>(v1);
            };
        } else if (arg0 == 0x1::string::utf8(b"BLUEMOVE")) {
            let v21 = 0x1::option::borrow_mut<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(&mut arg6.bluemove);
            if (0x1::option::is_some<vector<0x2::coin::Coin<T0>>>(&arg1)) {
                let (v22, _) = bluemove_swap_exact_input_with_return<T0, T1>(arg3.amount_in, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v1), arg3.min_amount_out, v21, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v22, 0x2::tx_context::sender(arg8));
                destroy_coins<T1>(v3);
                destroy_coins<T0>(v1);
            } else {
                let (v24, _) = bluemove_swap_exact_input_with_return<T1, T0>(arg3.amount_in, 0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut v3), arg3.min_amount_out, v21, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v24, 0x2::tx_context::sender(arg8));
                destroy_coins<T0>(v1);
                destroy_coins<T1>(v3);
            };
        } else if (arg0 == 0x1::string::utf8(b"BLUEMOVE_STABLE")) {
            let v26 = 0x1::option::borrow_mut<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info>(&mut arg6.bluemove_stable);
            if (0x1::option::is_some<vector<0x2::coin::Coin<T0>>>(&arg1)) {
                let (v27, _) = bluemove_stable_swap_exact_input_with_return<T0, T1>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v1), arg3.amount_in, arg3.min_amount_out, v26, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v27, 0x2::tx_context::sender(arg8));
                destroy_coins<T1>(v3);
                destroy_coins<T0>(v1);
            } else {
                let (v29, _) = bluemove_stable_swap_exact_input_with_return<T1, T0>(0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut v3), arg3.amount_in, arg3.min_amount_out, v26, arg7, arg3.order_id, arg3.decimal, arg8);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v29, 0x2::tx_context::sender(arg8));
                destroy_coins<T0>(v1);
                destroy_coins<T1>(v3);
            };
        } else {
            destroy_coins<T0>(v1);
            destroy_coins<T1>(v3);
            abort 3
        };
        0x1::option::destroy_none<vector<0x2::coin::Coin<T0>>>(arg1);
        0x1::option::destroy_none<vector<0x2::coin::Coin<T1>>>(arg2);
    }

    // decompiled from Move bytecode v6
}

