module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events {
    struct DepositEvent has copy, drop {
        vault_id: address,
        user: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: address,
        user: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct TransferEvent has copy, drop {
        from_vault: address,
        to_vault: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct SwapEvent has copy, drop {
        user: address,
        input_amount: u64,
        input_coin_type: 0x1::type_name::TypeName,
        output_coin_type: 0x1::type_name::TypeName,
        walrus_blob_id: vector<u8>,
    }

    public(friend) fun emit_deposit<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = DepositEvent{
            vault_id  : arg0,
            user      : arg1,
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_swap<T0, T1>(arg0: address, arg1: u64, arg2: vector<u8>) {
        let v0 = SwapEvent{
            user             : arg0,
            input_amount     : arg1,
            input_coin_type  : 0x1::type_name::get<T0>(),
            output_coin_type : 0x1::type_name::get<T1>(),
            walrus_blob_id   : arg2,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public(friend) fun emit_transfer<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = TransferEvent{
            from_vault : arg0,
            to_vault   : arg1,
            amount     : arg2,
            coin_type  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public(friend) fun emit_withdraw<T0>(arg0: address, arg1: address, arg2: u64) {
        let v0 = WithdrawEvent{
            vault_id  : arg0,
            user      : arg1,
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

