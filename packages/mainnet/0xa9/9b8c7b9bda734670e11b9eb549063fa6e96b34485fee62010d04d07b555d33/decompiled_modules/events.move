module 0xa99b8c7b9bda734670e11b9eb549063fa6e96b34485fee62010d04d07b555d33::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreatedOrderEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        user_pk: vector<u8>,
        recipient: address,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        encrypted_fields: vector<u8>,
        integrator_fee_bps: u16,
        integrator_fee_recipient: address,
    }

    struct ClosedOrderEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        remaining_amount: u64,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        encrypted_fields: vector<u8>,
    }

    struct ExecutedTradeEventV1 has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        trade_type: u8,
        input_amount: u64,
        input_type: vector<u8>,
        output_amount: u64,
        output_type: vector<u8>,
        gas_amount: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_closed_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = ClosedOrderEventV1{
            order_id         : arg0,
            user             : arg1,
            recipient        : arg3,
            remaining_amount : arg2,
            input_amount     : arg4,
            input_type       : *0x1::ascii::as_bytes(&v0),
            output_type      : *0x1::ascii::as_bytes(&v1),
            gas_amount       : arg5,
            encrypted_fields : arg6,
        };
        emit<ClosedOrderEventV1>(v2);
    }

    public(friend) fun emit_created_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u16, arg8: address) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = CreatedOrderEventV1{
            order_id                 : arg0,
            user                     : arg1,
            user_pk                  : arg2,
            recipient                : arg3,
            input_amount             : arg4,
            input_type               : *0x1::ascii::as_bytes(&v0),
            output_type              : *0x1::ascii::as_bytes(&v1),
            gas_amount               : arg5,
            encrypted_fields         : arg6,
            integrator_fee_bps       : arg7,
            integrator_fee_recipient : arg8,
        };
        emit<CreatedOrderEventV1>(v2);
    }

    public(friend) fun emit_executed_trade_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = ExecutedTradeEventV1{
            order_id      : arg0,
            user          : arg1,
            recipient     : arg2,
            trade_type    : arg3,
            input_amount  : arg4,
            input_type    : *0x1::ascii::as_bytes(&v0),
            output_amount : arg5,
            output_type   : *0x1::ascii::as_bytes(&v1),
            gas_amount    : arg6,
        };
        emit<ExecutedTradeEventV1>(v2);
    }

    // decompiled from Move bytecode v6
}

