module 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot_swap_turbos {
    public entry fun swap_turbos<T0, T1, T2>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::platform::Platform, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T1>();
        let v0 = 0x2::coin::zero<T0>(arg8);
        let v1 = 0x2::coin::zero<T1>(arg8);
        if (arg2) {
            0x2::coin::join<T0>(&mut v0, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg6, arg7, arg8));
        } else {
            0x2::coin::join<T1>(&mut v1, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_permission<T1>(arg0, arg1, arg6, arg7, arg8));
        };
        let (v2, v3) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::turbos_clmm_protocol::swap<T0, T1, T2>(arg4, v0, v1, arg5, arg7, arg8);
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg0, arg3, arg6, arg7, arg8), 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::platform::get_address(arg6));
        };
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
    }

    public entry fun swap_with_base<T0, T1>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: bool, arg3: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::bank::Bank, arg4: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::fee::FeeManager, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::platform::Platform, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg12);
        let v1 = 0x2::coin::zero<T0>(arg12);
        if (arg2) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg0, arg1, arg10, arg11, arg12));
        } else {
            0x2::coin::join<T0>(&mut v1, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg10, arg11, arg12));
        };
        if (arg2) {
            0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::swap_utils::take_fee(arg3, arg4, &mut v0, arg5, arg6, arg12);
            0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v0, arg7, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::platform::get_address(arg10), arg12);
        };
        let (v2, v3) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::turbos_clmm_protocol::swap<T0, 0x2::sui::SUI, T1>(arg8, v1, v0, arg9, arg11, arg12);
        let v4 = v3;
        if (!arg2) {
            0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::swap_utils::take_fee(arg3, arg4, &mut v4, arg5, arg6, arg12);
            0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::swap_utils::repay_sponsor_gas<0x2::sui::SUI>(&mut v4, arg7, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::platform::get_address(arg10), arg12);
        };
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
    }

    // decompiled from Move bytecode v6
}

