module 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::withdraw {
    public entry fun process_withdrawals<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::process_withdrawals<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_withdrawal<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::claim_withdrawal_as_user<T0, T1, T2>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1, T2>(arg0: &mut 0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5a84dfe56c993e8aeb70f9783a6d99c5277f276e94ee4b06ceb090c4f78e64d8::vault::add_withdraw_request_as_user<T0, T1, T2>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

