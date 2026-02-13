module 0x9b8da79d54be88924cf0b3157c6e041d9ec44134dcde779bc861ab1b8c1ca254::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreateVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct DepositEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        address: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct DepositSessionEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        domain: 0x1::ascii::String,
        rebate_type: 0x1::ascii::String,
        rebate_amount: u64,
        num_of_addresses: u64,
        epoch_start_timestamp_ms: u64,
        epoch_end_timestamp_ms: u64,
    }

    struct WithdrawRebateEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        types: vector<0x1::ascii::String>,
        amounts: vector<u64>,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_create_vault_event(arg0: 0x2::object::ID) {
        let v0 = CreateVaultEventV1{vault_id: arg0};
        emit<CreateVaultEventV1>(v0);
    }

    public(friend) fun emit_deposit_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = DepositEventV1{
            vault_id  : arg0,
            address   : arg1,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : arg2,
        };
        emit<DepositEventV1>(v0);
    }

    public(friend) fun emit_deposit_session_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = DepositSessionEventV1{
            vault_id                 : arg0,
            domain                   : arg1,
            rebate_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            rebate_amount            : arg2,
            num_of_addresses         : arg3,
            epoch_start_timestamp_ms : arg4,
            epoch_end_timestamp_ms   : arg5,
        };
        emit<DepositSessionEventV1>(v0);
    }

    public(friend) fun emit_withdraw_rebate_event(arg0: 0x2::object::ID, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>) {
        let v0 = WithdrawRebateEventV1{
            vault_id : arg0,
            sender   : arg1,
            types    : arg2,
            amounts  : arg3,
        };
        emit<WithdrawRebateEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

