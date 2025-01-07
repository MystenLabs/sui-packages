module 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0, arg1);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::start_strategy<T0, T1, T2>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

