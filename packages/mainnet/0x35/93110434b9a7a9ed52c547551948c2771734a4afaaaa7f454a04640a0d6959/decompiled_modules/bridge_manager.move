module 0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager {
    struct DepositEvent has copy, drop {
        sender: address,
        permit_signer: vector<u8>,
        amount: u64,
    }

    struct PermitEvent has copy, drop {
        sender: address,
        permit_signer: vector<u8>,
        amount: u64,
        deadline: u64,
        v: u64,
        r: vector<u8>,
        s: vector<u8>,
    }

    struct WithdrawEvent has copy, drop {
        bridge_hash: vector<u8>,
        recipient: address,
        amount: u64,
    }

    fun check_action_enabled(arg0: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config::BridgeManagerConfig) {
        if (0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config::action_enabled(arg0) == false) {
            abort 0
        };
    }

    public fun deposit<T0>(arg0: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config::BridgeManagerConfig, arg1: &mut 0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::treasury::Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        check_action_enabled(arg0);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::treasury::deposit_balance<T0>(arg1, v0);
        let v1 = DepositEvent{
            sender        : 0x2::tx_context::sender(arg4),
            permit_signer : arg3,
            amount        : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun permit(arg0: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config::BridgeManagerConfig, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        check_action_enabled(arg0);
        let v0 = PermitEvent{
            sender        : 0x2::tx_context::sender(arg7),
            permit_signer : arg1,
            amount        : arg2,
            deadline      : arg3,
            v             : arg4,
            r             : arg5,
            s             : arg6,
        };
        0x2::event::emit<PermitEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::bridge_manager_config::BridgeManagerConfig, arg1: &0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::operator_cap::OperatorCap, arg2: &mut 0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::treasury::Treasury<T0>, arg3: &mut 0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::tx_status::TxStatus, arg4: address, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        check_action_enabled(arg0);
        if (0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::tx_status::get_status(arg3, arg6)) {
            abort 1
        };
        let v0 = WithdrawEvent{
            bridge_hash : arg6,
            recipient   : arg4,
            amount      : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::tx_status::set_status(arg1, arg3, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x3593110434b9a7a9ed52c547551948c2771734a4afaaaa7f454a04640a0d6959::treasury::withdraw_balance<T0>(arg2, arg5), arg7), arg4);
    }

    // decompiled from Move bytecode v6
}

