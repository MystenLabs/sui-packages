module 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::Vault<T0, T1, T2>, arg1: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::assert_current_version(arg1);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::assert_current_version(arg2);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1, arg3);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::Vault<T0, T1, T2>, arg1: &0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::version::assert_current_version(arg1);
        0x490dd5a009f8e15e5e56033d1734525e88a1abda724a3dada61fab54980f7d5::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

