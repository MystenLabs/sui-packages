module 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg1);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg2);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1, arg3);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::Vault<T0, T1, T2>, arg1: &0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::version::assert_current_version(arg1);
        0xee813bb28106ed341c7d1e23ee3d4ab347bcde65275c326b9a90e45e87dc62ce::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

