module 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events {
    struct StartSuperAdminTransfer has copy, drop {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        pos0: address,
    }

    struct NewAdmin has copy, drop {
        pos0: address,
    }

    struct RevokeAdmin has copy, drop {
        pos0: address,
    }

    struct Deposit has copy, drop {
        fee_taken: u64,
        coin_in_amount: u64,
        sam_amount: u64,
        sender: address,
        sam_coin: 0x1::type_name::TypeName,
        coin_in: 0x1::type_name::TypeName,
    }

    struct Withdraw has copy, drop {
        fee_taken: u64,
        sam_amount: u64,
        coin_in_amount: u64,
        sender: address,
        sam_coin: 0x1::type_name::TypeName,
        coin_in: 0x1::type_name::TypeName,
        protocols: vector<0x1::type_name::TypeName>,
        protocol_amounts: vector<u64>,
        direct_withdraw_amount: u64,
    }

    struct ProtocolWithdraw has copy, drop {
        fee_taken: u64,
        coin_in_amount: u64,
        sender: address,
        sam_coin: 0x1::type_name::TypeName,
        coin_in: 0x1::type_name::TypeName,
        protocol: 0x1::type_name::TypeName,
        protocol_amount: u64,
    }

    struct Earnings has copy, drop {
        fee_taken: u64,
        earnings_value: u64,
        earnings_coin: 0x1::type_name::TypeName,
    }

    struct Rebalance has copy, drop {
        from_protocols: vector<0x1::option::Option<0x1::type_name::TypeName>>,
        to_protocols: vector<0x1::option::Option<0x1::type_name::TypeName>>,
        amounts: vector<u64>,
        rebalancer: address,
    }

    struct NewState has copy, drop {
        id: 0x2::object::ID,
        coin_in: 0x1::type_name::TypeName,
        sam_coin: 0x1::type_name::TypeName,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
    }

    public(friend) fun deposit<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: address) {
        let v0 = Deposit{
            fee_taken      : arg0,
            coin_in_amount : arg1,
            sam_amount     : arg2,
            sender         : arg3,
            sam_coin       : 0x1::type_name::get<T1>(),
            coin_in        : 0x1::type_name::get<T0>(),
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<Deposit>(v0);
    }

    public(friend) fun earnings<T0>(arg0: u64, arg1: u64) {
        let v0 = Earnings{
            fee_taken      : arg0,
            earnings_value : arg1,
            earnings_coin  : 0x1::type_name::get<T0>(),
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<Earnings>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun new_state<T0, T1>(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::ascii::String) {
        let v0 = NewState{
            id       : arg0,
            coin_in  : 0x1::type_name::get<T0>(),
            sam_coin : 0x1::type_name::get<T1>(),
            decimals : arg1,
            name     : arg2,
            symbol   : arg3,
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<NewState>(v0);
    }

    public(friend) fun protocol_withdraw<T0, T1>(arg0: u64, arg1: u64, arg2: address, arg3: 0x1::type_name::TypeName, arg4: u64) {
        let v0 = ProtocolWithdraw{
            fee_taken       : arg0,
            coin_in_amount  : arg1,
            sender          : arg2,
            sam_coin        : 0x1::type_name::get<T1>(),
            coin_in         : 0x1::type_name::get<T0>(),
            protocol        : arg3,
            protocol_amount : arg4,
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<ProtocolWithdraw>(v0);
    }

    public(friend) fun rebalance(arg0: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<u64>, arg3: address) {
        let v0 = Rebalance{
            from_protocols : arg0,
            to_protocols   : arg1,
            amounts        : arg2,
            rebalancer     : arg3,
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<Rebalance>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    public(friend) fun withdraw<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: vector<0x1::type_name::TypeName>, arg5: vector<u64>, arg6: u64) {
        let v0 = Withdraw{
            fee_taken              : arg0,
            sam_amount             : arg1,
            coin_in_amount         : arg2,
            sender                 : arg3,
            sam_coin               : 0x1::type_name::get<T1>(),
            coin_in                : 0x1::type_name::get<T0>(),
            protocols              : arg4,
            protocol_amounts       : arg5,
            direct_withdraw_amount : arg6,
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::event_wrapper::emit_event<Withdraw>(v0);
    }

    // decompiled from Move bytecode v7
}

