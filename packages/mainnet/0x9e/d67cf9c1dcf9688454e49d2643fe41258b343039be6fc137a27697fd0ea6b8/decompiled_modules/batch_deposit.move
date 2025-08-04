module 0x9ed67cf9c1dcf9688454e49d2643fe41258b343039be6fc137a27697fd0ea6b8::batch_deposit {
    struct UserDepositData has copy, drop {
        deposit_id: u256,
        account_id: u256,
        signature: vector<u8>,
        expired_at_ms: u64,
    }

    public fun batch_user_deposit<T0>(arg0: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<UserDepositData>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0x1::vector::length<UserDepositData>(&arg3), 60004);
        batch_user_deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun batch_user_deposit_internal<T0>(arg0: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<UserDepositData>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
            0x1::vector::destroy_empty<UserDepositData>(arg3);
            return
        };
        let v0 = 0x1::vector::pop_back<UserDepositData>(&mut arg3);
        0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet::user_deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2)), v0.deposit_id, v0.account_id, v0.signature, v0.expired_at_ms, arg4);
        batch_user_deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

