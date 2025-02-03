module 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::swap_router {
    public(friend) fun calc_and_transfer_fees(arg0: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::Bank, arg1: &mut 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::FeeManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg2) as u128) * (arg4 as u128) / 100000) as u64);
        let v1 = (((v0 as u128) * (arg3 as u128) / 100000) as u64);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::bank::add_to_bank(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg5), arg5);
        0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::fee::add_fee(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0 - v1, arg5));
        arg2
    }

    public(friend) fun check_and_transfer_sponsor_gas(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg2)) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), 0x1::option::destroy_some<address>(arg2));
        };
    }

    public(friend) fun swap_base_v2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg0) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 1);
        if (0x2::coin::value<T0>(&arg0) > 0 && 0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            abort 2
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            let v2 = 0x2::coin::zero<T0>(arg8);
            let v3 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
            if (arg6 == 2) {
                let (v4, v5) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::move_pump_protocol::sui_from_coin<T0>(arg5, arg0, arg2, arg7, arg8);
                0x2::coin::join<T0>(&mut v2, v5);
                0x2::coin::join<0x2::sui::SUI>(&mut v3, v4);
            } else {
                0x2::coin::join<0x2::sui::SUI>(&mut v3, swap_v2<T0, 0x2::sui::SUI>(arg0, arg2, arg3, arg4, arg6, arg8));
            };
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
            (v3, v2)
        } else {
            let v6 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
            let v7 = 0x2::coin::zero<T0>(arg8);
            if (arg6 == 2) {
                let (v8, v9) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::move_pump_protocol::sui_to_coin<T0>(arg5, arg4, arg1, arg2, arg7, arg8);
                0x2::coin::join<0x2::sui::SUI>(&mut v6, v8);
                0x2::coin::join<T0>(&mut v7, v9);
            } else {
                0x2::coin::join<T0>(&mut v7, swap_v2<0x2::sui::SUI, T0>(arg1, arg2, arg3, arg4, arg6, arg8));
            };
            0x2::coin::destroy_zero<T0>(arg0);
            (v6, v7)
        }
    }

    public(friend) fun swap_v2<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        if (arg4 == 0) {
            0x2::coin::join<T1>(&mut v0, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::flow_x_protocol::swap_exact_input<T0, T1>(arg2, arg0, arg5));
        } else {
            0x2::coin::join<T1>(&mut v0, 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::blue_move_protocol::swap_exact_input<T0, T1>(arg0, arg1, arg3, arg5));
        };
        v0
    }

    public(friend) fun swap_v3_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) > 0 || 0x2::coin::value<T1>(&arg1) > 0, 1);
        if (0x2::coin::value<T0>(&arg0) > 0 && 0x2::coin::value<T0>(&arg0) > 0) {
            abort 2
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::coin::destroy_zero<T1>(arg1);
            0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::cetus_clmm_protocol::swap_a_to_b<T0, T1>(arg2, arg3, arg0, arg4, arg5)
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
            0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::cetus_clmm_protocol::swap_b_to_a<T0, T1>(arg2, arg3, arg1, arg4, arg5)
        }
    }

    public(friend) fun swap_v3_turbos<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg0) > 0 || 0x2::coin::value<T1>(&arg1) > 0, 1);
        if (0x2::coin::value<T0>(&arg0) > 0 && 0x2::coin::value<T0>(&arg0) > 0) {
            abort 2
        };
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::zero<T1>(arg5);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            let (v2, v3) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::turbos_clmm_protocol::swap_a_to_b<T0, T1, T2>(arg2, arg0, arg4, arg3, arg5);
            0x2::coin::join<T1>(&mut v1, v2);
            0x2::coin::join<T0>(&mut v0, v3);
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            let (v4, v5) = 0x3e54f42fc703c301a8a301a45887648b396082cc5d859e5d21f7f3c4604ffdfa::turbos_clmm_protocol::swap_b_to_a<T0, T1, T2>(arg2, arg1, arg4, arg3, arg5);
            0x2::coin::join<T0>(&mut v0, v4);
            0x2::coin::join<T1>(&mut v1, v5);
            0x2::coin::destroy_zero<T0>(arg0);
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

