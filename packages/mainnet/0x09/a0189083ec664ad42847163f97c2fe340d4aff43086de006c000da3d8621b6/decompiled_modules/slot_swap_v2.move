module 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot_swap_v2 {
    public entry fun buy_with_base<T0>(arg0: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::bank::Bank, arg1: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::Slot, arg5: u64, arg6: u64, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<0x2::sui::SUI>(arg4, arg5, true, arg12);
        let v1 = calc_and_transfer_fees(arg0, arg1, v0, arg2, arg3, arg12);
        let v2 = 0x2::coin::zero<0x2::sui::SUI>(arg12);
        let v3 = 0x2::coin::zero<T0>(arg12);
        if (arg10 == 0) {
            0x2::coin::join<T0>(&mut v3, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::flow_x_protocol::swap_exact_input<0x2::sui::SUI, T0>(arg7, v1, arg12));
        } else if (arg10 == 1) {
            0x2::coin::join<T0>(&mut v3, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::blue_move_protocol::swap_exact_input<0x2::sui::SUI, T0>(v1, arg6, arg8, arg12));
        } else {
            let (v4, v5) = 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::move_pump_protocol::sui_to_coin<T0>(arg9, arg8, v1, arg6, arg11, arg12);
            0x2::coin::join<0x2::sui::SUI>(&mut v2, v4);
            0x2::coin::join<T0>(&mut v3, v5);
        };
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v3));
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
    }

    public(friend) fun calc_and_transfer_fees(arg0: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::bank::Bank, arg1: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::fee::FeeManager, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg2) as u128) * (arg4 as u128) / 100000) as u64);
        let v1 = (((v0 as u128) * (arg3 as u128) / 100000) as u64);
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::bank::add_to_bank(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg5), arg5);
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::fee::add_fee(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0 - v1, arg5));
        arg2
    }

    public entry fun sell_with_base<T0>(arg0: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::bank::Bank, arg1: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::Slot, arg5: u64, arg6: u64, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg12);
        if (arg10 == 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut v1, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::flow_x_protocol::swap_exact_input<T0, 0x2::sui::SUI>(arg7, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<T0>(arg4, arg5, true, arg12), arg12));
        } else if (arg10 == 1) {
            0x2::coin::join<0x2::sui::SUI>(&mut v1, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::blue_move_protocol::swap_exact_input<T0, 0x2::sui::SUI>(0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<T0>(arg4, arg5, true, arg12), arg6, arg8, arg12));
        } else {
            let (v2, v3) = 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::move_pump_protocol::sui_from_coin<T0>(arg9, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<T0>(arg4, arg5, true, arg12), arg6, arg11, arg12);
            0x2::coin::join<T0>(&mut v0, v3);
            0x2::coin::join<0x2::sui::SUI>(&mut v1, v2);
        };
        let v4 = v1;
        v1 = calc_and_transfer_fees(arg0, arg1, v4, arg2, arg3, arg12);
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v0));
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::Slot, arg1: u64, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::utils::is_base<T0>(), 0);
        assert!(!0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::utils::is_base<T1>(), 0);
        let v0 = 0x2::coin::zero<T1>(arg6);
        if (arg5 == 0) {
            0x2::coin::join<T1>(&mut v0, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::flow_x_protocol::swap_exact_input<T0, T1>(arg3, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<T0>(arg0, arg1, true, arg6), arg6));
        } else {
            0x2::coin::join<T1>(&mut v0, 0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::blue_move_protocol::swap_exact_input<T0, T1>(0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::take_from_balance<T0>(arg0, arg1, true, arg6), arg2, arg4, arg6));
        };
        0x9a0189083ec664ad42847163f97c2fe340d4aff43086de006c000da3d8621b6::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v0));
    }

    // decompiled from Move bytecode v6
}

