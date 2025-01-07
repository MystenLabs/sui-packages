module 0xa1bd20591f15e4bb45b182795d6900ea30fcf8a921b85230ec3b78c69da7f6ea::events {
    struct CreatedOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        user_pk: vector<u8>,
        recipient: address,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        encrypted_fields: vector<u8>,
    }

    struct ClosedOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        encrypted_fields: vector<u8>,
    }

    struct ExecutedTradeEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        input_amount: u64,
        input_type: vector<u8>,
        output_amount: u64,
        output_type: vector<u8>,
        gas_amount: u64,
    }

    public(friend) fun emit_closed_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = ClosedOrderEvent{
            order_id         : arg0,
            user             : arg1,
            recipient        : arg2,
            input_amount     : arg3,
            input_type       : *0x1::ascii::as_bytes(&v0),
            output_type      : *0x1::ascii::as_bytes(&v1),
            gas_amount       : arg4,
            encrypted_fields : arg5,
        };
        0x2::event::emit<ClosedOrderEvent>(v2);
    }

    public(friend) fun emit_created_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = CreatedOrderEvent{
            order_id         : arg0,
            user             : arg1,
            user_pk          : arg2,
            recipient        : arg3,
            input_amount     : arg4,
            input_type       : *0x1::ascii::as_bytes(&v0),
            output_type      : *0x1::ascii::as_bytes(&v1),
            gas_amount       : arg5,
            encrypted_fields : arg6,
        };
        0x2::event::emit<CreatedOrderEvent>(v2);
    }

    public(friend) fun emit_executed_trade_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = ExecutedTradeEvent{
            order_id      : arg0,
            user          : arg1,
            recipient     : arg2,
            input_amount  : arg3,
            input_type    : *0x1::ascii::as_bytes(&v0),
            output_amount : arg4,
            output_type   : *0x1::ascii::as_bytes(&v1),
            gas_amount    : arg5,
        };
        0x2::event::emit<ExecutedTradeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

