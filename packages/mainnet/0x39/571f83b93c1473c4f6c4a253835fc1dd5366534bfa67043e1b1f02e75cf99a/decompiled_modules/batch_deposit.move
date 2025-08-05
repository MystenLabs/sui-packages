module 0x39571f83b93c1473c4f6c4a253835fc1dd5366534bfa67043e1b1f02e75cf99a::batch_deposit {
    struct UserDepositData has copy, drop {
        deposit_id: u256,
        account_id: u256,
        signature: vector<u8>,
        expired_at_ms: u64,
    }

    public fun batch_user_deposit<T0>(arg0: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg1: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u256>, arg4: vector<u256>, arg5: vector<vector<u8>>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u256>(&arg3);
        let v1 = 0x1::vector::length<u256>(&arg4);
        let v2 = 0x1::vector::length<vector<u8>>(&arg5);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0, 60004);
        assert!(v0 == v1, 60004);
        assert!(v1 == v2, 60004);
        assert!(v2 == 0x1::vector::length<u64>(&arg6), 60004);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet::user_deposit<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2)), 0x1::vector::pop_back<u256>(&mut arg3), 0x1::vector::pop_back<u256>(&mut arg4), 0x1::vector::pop_back<vector<u8>>(&mut arg5), 0x1::vector::pop_back<u64>(&mut arg6), arg7);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x1::vector::destroy_empty<u256>(arg3);
        0x1::vector::destroy_empty<u256>(arg4);
        0x1::vector::destroy_empty<vector<u8>>(arg5);
        0x1::vector::destroy_empty<u64>(arg6);
    }

    // decompiled from Move bytecode v6
}

