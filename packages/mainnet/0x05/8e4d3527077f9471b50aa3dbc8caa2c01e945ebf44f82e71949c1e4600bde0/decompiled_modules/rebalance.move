module 0x58e4d3527077f9471b50aa3dbc8caa2c01e945ebf44f82e71949c1e4600bde0::rebalance {
    public fun cetus_add_liquidity<T0, T1>(arg0: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_core_clmm::PositionConfig, arg2: &mut 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_core_clmm::RebalanceReceipt, arg3: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::pyth::PythPriceInfo, arg4: &0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::debt_info::DebtInfo, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::position_core_clmm::lp_position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0));
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0x2::balance::value<T0>(&arg7), true);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0x2::balance::value<T1>(&arg8), false);
        let (v8, v9, v10) = if (v2 < v5) {
            (v2, v3, v4)
        } else {
            (v5, v6, v7)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg6, arg5, 0x2::balance::split<T0>(&mut arg7, v9), 0x2::balance::split<T1>(&mut arg8, v10), 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::cetus::rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v8, arg9));
        (arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

