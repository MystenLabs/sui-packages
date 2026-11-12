module 0x68a6da501db80c4acc8d1b42f69e244ff9f58f93c802cf15a95164c0e7d83236::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg5, arg6);
            return
        };
        let (v2, v3, v4) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap<T0, T1>(arg1, true, true, v1, 4295048017, arg2, arg3, arg6);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v2);
        let (v6, _) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap_receipt_debts(&v5);
        0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pay<T0, T1>(arg1, v5, 0x2::balance::split<T0>(&mut v0, v6), 0x2::balance::zero<T1>(), arg2, arg6);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, v0);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg5, arg6);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg5, arg6);
            return
        };
        let (v2, v3, v4) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap<T0, T1>(arg1, false, true, v1, 79226673515401279992447579054, arg2, arg3, arg6);
        let v5 = v4;
        0x2::balance::destroy_zero<T1>(v3);
        let (_, v7) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap_receipt_debts(&v5);
        0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pay<T0, T1>(arg1, v5, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v0, v7), arg2, arg6);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T1>(arg0, v0);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg5, arg6);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, v2);
    }

    public fun swap_registry<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg2: u64, arg3: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        swap<T0, T1>(arg0, v0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

