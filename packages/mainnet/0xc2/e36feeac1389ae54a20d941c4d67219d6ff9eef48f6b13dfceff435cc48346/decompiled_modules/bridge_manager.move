module 0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::bridge_manager {
    struct DepositEvent has copy, drop {
        sender: address,
        evm_address: vector<u8>,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        bridge_hash: vector<u8>,
        recipient: address,
        amount: u64,
    }

    public fun deposit<T0>(arg0: &0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::GlobalConfig, arg1: &mut 0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::treasury::Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::assert_active(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 201);
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::assert_deposit_amount(arg0, v0);
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::treasury::deposit<T0>(arg1, arg2);
        let v1 = DepositEvent{
            sender      : 0x2::tx_context::sender(arg4),
            evm_address : arg3,
            amount      : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::OperatorCap, arg1: &0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::GlobalConfig, arg2: &mut 0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::treasury::Treasury<T0>, arg3: &mut 0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::tx_status::TxStatus, arg4: address, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::assert_active(arg1);
        assert!(0x1::vector::length<u8>(&arg6) > 0, 202);
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::assert_withdraw_amount(arg1, arg5);
        0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::tx_status::record_hash(arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::treasury::withdraw<T0>(arg2, arg5, arg7), arg4);
        let v0 = WithdrawEvent{
            bridge_hash : arg6,
            recipient   : arg4,
            amount      : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

