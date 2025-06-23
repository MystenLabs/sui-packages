module 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot_swap_amm {
    public entry fun swap_a_to_b<T0, T1>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::Slot, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg6: u8, arg7: &0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::platform::Platform, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::dex_utils::not_base<T0>();
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::dex_utils::not_base<T1>();
        let v0 = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg7, arg8, arg9);
        let v1 = swap_coin_amm<T0, T1>(v0, arg2, arg4, arg5, arg6, arg9);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::swap_utils::repay_sponsor_gas_v2<T1>(&mut v1, arg4, arg5, arg6, arg3, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::platform::get_address(arg7), arg9);
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
    }

    public(friend) fun swap_base_amm_no_fees<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::dex_utils::check_amounts<0x2::sui::SUI, T0>(&arg0, &arg1);
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg8);
        let v1 = 0x2::coin::zero<T0>(arg8);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            if (arg6 == 2) {
                let (v2, v3) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::move_pump_protocol::swap<T0>(0x2::coin::zero<T0>(arg8), arg0, arg2, arg5, arg4, arg7, arg8);
                0x2::coin::join<0x2::sui::SUI>(&mut v0, v2);
                0x2::coin::join<T0>(&mut v1, v3);
            } else {
                0x2::coin::join<T0>(&mut v1, swap_coin_amm<0x2::sui::SUI, T0>(arg0, arg2, arg3, arg4, arg6, arg8));
            };
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            if (arg6 == 2) {
                let (v4, v5) = 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::move_pump_protocol::swap<T0>(arg1, 0x2::coin::zero<0x2::sui::SUI>(arg8), arg2, arg5, arg4, arg7, arg8);
                0x2::coin::join<0x2::sui::SUI>(&mut v0, v4);
                0x2::coin::join<T0>(&mut v1, v5);
            } else {
                0x2::coin::join<0x2::sui::SUI>(&mut v0, swap_coin_amm<T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg6, arg8));
            };
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        (v0, v1)
    }

    fun swap_coin_amm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg4 == 0) {
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::flow_x_amm_protocol::swap_a_to_b<T0, T1>(arg0, arg2, arg5)
        } else {
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::blue_move_protocol::swap_a_to_b<T0, T1>(arg0, arg1, arg3, arg5)
        }
    }

    public entry fun swap_with_base<T0>(arg0: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::Slot, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::bank::Bank, arg5: &mut 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::fee::FeeManager, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg10: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg11: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg12: u8, arg13: &0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::platform::Platform, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg15);
        let v1 = 0x2::coin::zero<T0>(arg15);
        if (arg3) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg0, arg1, arg13, arg14, arg15));
        } else {
            0x2::coin::join<T0>(&mut v1, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg13, arg14, arg15));
        };
        if (arg3) {
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::swap_utils::take_fee(arg4, arg5, &mut v0, arg6, arg7, arg15);
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v0, arg8, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::platform::get_address(arg13), arg15);
            let v2 = (0x2::coin::value<0x2::sui::SUI>(&v0) as u128) * (arg2 as u128) / (0x2::coin::value<0x2::sui::SUI>(&v0) as u128);
            arg2 = (v2 as u64);
        };
        let (v3, v4) = swap_base_amm_no_fees<T0>(v0, v1, arg2, arg9, arg10, arg11, arg12, arg14, arg15);
        let v5 = v3;
        if (!arg3) {
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::swap_utils::take_fee(arg4, arg5, &mut v5, arg6, arg7, arg15);
            0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v5, arg8, 0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::platform::get_address(arg13), arg15);
        };
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        0x8c42d1291f081d0daf6969c6e6031e0f97aeb4a83ef843c9999311ef8e0b4fd1::slot::add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
    }

    // decompiled from Move bytecode v6
}

