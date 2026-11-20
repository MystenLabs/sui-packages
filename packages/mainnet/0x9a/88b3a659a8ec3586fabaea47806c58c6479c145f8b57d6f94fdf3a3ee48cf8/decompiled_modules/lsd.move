module 0xc913799f65cd81ed346b26ae9669c9e14430cbf9d9c7bbbc64b53bc82b1add74::lsd {
    public fun swap<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg6, arg7);
            return
        };
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg7), arg5, arg7), arg7)));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg6, arg7);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg6, arg7);
            return
        };
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T1, T0>(arg3, 0x2::coin::from_balance<T1>(v0, arg7), arg7), arg5, arg7)));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

