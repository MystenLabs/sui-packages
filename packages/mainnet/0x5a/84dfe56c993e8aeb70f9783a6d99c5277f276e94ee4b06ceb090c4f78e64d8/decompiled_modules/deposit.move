module 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::deposit {
    public entry fun add_liquidity<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::add_deposit_request_as_user<T0, T1, T2>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun process_deposits<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::process_deposits<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

