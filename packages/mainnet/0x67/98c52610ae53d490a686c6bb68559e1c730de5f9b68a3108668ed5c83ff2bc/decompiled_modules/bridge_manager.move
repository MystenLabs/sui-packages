module 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::bridge_manager {
    struct DepositEvent has copy, drop {
        sender: address,
        evm_address: vector<u8>,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct WithdrawEvent has copy, drop {
        bridge_hash: vector<u8>,
        recipient: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct WithdrawToBridgeEvent has copy, drop {
        requester: address,
        recipient: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct DepositToPoolEvent has copy, drop {
        sender: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun deposit<T0>(arg0: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::GlobalConfig, arg1: &mut 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_active(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 201);
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_deposit_amount(arg0, v0);
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::deposit<T0>(arg1, arg2);
        let v1 = DepositEvent{
            sender      : 0x2::tx_context::sender(arg4),
            evm_address : arg3,
            amount      : v0,
            coin_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun deposit_to_pool<T0>(arg0: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::OperatorCap, arg1: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::GlobalConfig, arg2: &mut 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_active(arg1);
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::deposit<T0>(arg2, arg3);
        let v0 = DepositToPoolEvent{
            sender    : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<T0>(&arg3),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositToPoolEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::OperatorCap, arg1: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::GlobalConfig, arg2: &mut 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::Treasury<T0>, arg3: &mut 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::tx_status::TxStatus, arg4: address, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_active(arg1);
        assert!(0x1::vector::length<u8>(&arg6) > 0, 202);
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_withdraw_amount(arg1, arg5);
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::tx_status::record_hash(arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::withdraw<T0>(arg2, arg5, arg7), arg4);
        let v0 = WithdrawEvent{
            bridge_hash : arg6,
            recipient   : arg4,
            amount      : arg5,
            coin_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public fun withdraw_to_bridge<T0>(arg0: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::OperatorCap, arg1: &0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::GlobalConfig, arg2: &mut 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::Treasury<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::assert_active(arg1);
        let v0 = 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config::bridge_wallet(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::treasury::withdraw<T0>(arg2, arg3, arg4), v0);
        let v1 = WithdrawToBridgeEvent{
            requester : 0x2::tx_context::sender(arg4),
            recipient : v0,
            amount    : arg3,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WithdrawToBridgeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

