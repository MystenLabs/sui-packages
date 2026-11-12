module 0x47a511a6cc30bc5d0cb26c334937494c6fe0ef64c8335f850a103a21bfe92ab5::bonding_curve {
    public fun swap<T0>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x2::sui::SUI>(arg0, arg4, arg5);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), v1, 0, true, arg2, arg5);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<0x2::sui::SUI>(arg0, arg4, arg5);
    }

    fun swap_b2a<T0>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg4, arg5);
            return
        };
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), v1, 0, true, arg2, arg5);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

