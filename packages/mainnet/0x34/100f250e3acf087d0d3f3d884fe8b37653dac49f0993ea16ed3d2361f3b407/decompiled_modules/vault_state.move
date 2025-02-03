module 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg1);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg2);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1, arg3);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::Vault<T0, T1, T2>, arg1: &0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::version::assert_current_version(arg1);
        0x34100f250e3acf087d0d3f3d884fe8b37653dac49f0993ea16ed3d2361f3b407::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

