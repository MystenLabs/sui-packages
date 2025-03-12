module 0x7bde136732b70c6cb3240d2c0136644c259ebdb5648cac86b0e4a37a1525c0bb::cetus_clmm_protocol {
    public(friend) fun swap<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x7bde136732b70c6cb3240d2c0136644c259ebdb5648cac86b0e4a37a1525c0bb::dex_utils::check_amounts<T0, T1>(&arg1, &arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = if (v0 > 0) {
            0x2::coin::value<T0>(&arg1)
        } else {
            v0
        };
        let v2 = if (v0 > 0) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg3, arg0, arg1, arg2, v0 > 0, true, v1, v2, false, arg4, arg5)
    }

    public(friend) fun get_required_coin_amount<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg0, true, false, arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0)
    }

    // decompiled from Move bytecode v6
}

