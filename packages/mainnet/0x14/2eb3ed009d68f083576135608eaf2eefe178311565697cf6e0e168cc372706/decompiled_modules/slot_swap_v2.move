module 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot_swap_v2 {
    public entry fun buy_with_base<T0>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: u64, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg10: u8, arg11: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_base_v2<T0>(0x2::coin::zero<T0>(arg13), 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<0x2::sui::SUI>(arg4, arg5, arg11, arg12, arg13), arg2, arg3, arg13), arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v1));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
    }

    public entry fun sell_with_base<T0>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::bank::Bank, arg1: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::fee::FeeManager, arg2: u64, arg3: u64, arg4: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg5: u64, arg6: u64, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg10: u8, arg11: u64, arg12: 0x1::option::Option<address>, arg13: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_base_v2<T0>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg4, arg5, arg13, arg14, arg15), 0x2::coin::zero<0x2::sui::SUI>(arg15), arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        let v2 = v0;
        let v3 = v2;
        v2 = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::calc_and_transfer_fees(arg0, arg1, v3, arg2, arg3, arg15);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::check_and_transfer_sponsor_gas(&mut v2, arg11, arg12, arg15);
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<0x2::sui::SUI>(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T0>(arg4, 0x2::coin::into_balance<T0>(v1));
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::Slot, arg1: u64, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u8, arg6: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T1>();
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::add_to_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v2<T0, T1>(0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot::take_from_balance_with_permission<T0>(arg0, arg1, arg6, arg7, arg8), arg2, arg3, arg4, arg5, arg8)));
    }

    // decompiled from Move bytecode v6
}

