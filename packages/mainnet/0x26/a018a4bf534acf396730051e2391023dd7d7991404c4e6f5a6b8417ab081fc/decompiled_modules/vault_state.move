module 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg1);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg2);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::Vault<T0, T1, T2>, arg1: &0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::Version, arg2: &0x2::clock::Clock) {
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::version::assert_current_version(arg1);
        0x26a018a4bf534acf396730051e2391023dd7d7991404c4e6f5a6b8417ab081fc::vault::start_strategy<T0, T1, T2>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

