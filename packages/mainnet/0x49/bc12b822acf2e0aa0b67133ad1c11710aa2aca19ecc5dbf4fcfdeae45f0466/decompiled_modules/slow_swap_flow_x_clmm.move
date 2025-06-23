module 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slow_swap_flow_x_clmm {
    public fun swap_flow_x<T0, T1>(arg0: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::Slot, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::Pool<T0, T1>, arg5: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::versioned::Versioned, arg7: &0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::Platform, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::dex_utils::not_base<T0>();
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::dex_utils::not_base<T1>();
        let v0 = 0x2::coin::zero<T0>(arg9);
        let v1 = 0x2::coin::zero<T1>(arg9);
        if (arg2) {
            0x2::coin::join<T0>(&mut v0, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg7, arg8, arg9));
        } else {
            0x2::coin::join<T1>(&mut v1, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::take_from_balance_with_permission<T1>(arg0, arg1, arg7, arg8, arg9));
        };
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_utils::repay_sponsor_gas_flow_x_clmm<T0>(arg5, &mut v0, arg3, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::get_address(arg7), arg6, arg8, arg9);
        let (v2, v3) = 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::flow_x_clmm_protocol::swap<T0, T1>(arg4, v0, v1, arg6, arg8, arg9);
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    public fun swap_with_base<T0>(arg0: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::Slot, arg1: u64, arg2: bool, arg3: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::bank::Bank, arg4: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::fee::FeeManager, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::pool::Pool<T0, 0x2::sui::SUI>, arg9: &mut 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::versioned::Versioned, arg10: &0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::Platform, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg12);
        let v1 = 0x2::coin::zero<T0>(arg12);
        if (arg2) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg0, arg1, arg10, arg11, arg12));
        } else {
            0x2::coin::join<T0>(&mut v1, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg10, arg11, arg12));
        };
        if (arg2) {
            0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_utils::take_fee(arg3, arg4, &mut v0, arg5, arg6, arg12);
            0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v0, arg7, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::get_address(arg10), arg12);
        };
        let (v2, v3) = 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::flow_x_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg8, v1, v0, arg9, arg11, arg12);
        let v4 = v3;
        if (!arg2) {
            0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_utils::take_fee(arg3, arg4, &mut v4, arg5, arg6, arg12);
            0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v4, arg7, 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::get_address(arg10), arg12);
        };
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot::add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
    }

    // decompiled from Move bytecode v6
}

