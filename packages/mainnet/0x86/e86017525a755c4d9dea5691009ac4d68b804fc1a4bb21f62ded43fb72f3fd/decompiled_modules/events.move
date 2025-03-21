module 0x7e57bff579e24d8d109fc16c14320fdb6a0c23159e7ae52b3dcd908ec2a5d481::events {
    struct CreatedOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        user_pk: vector<u8>,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        frequency_ms: u64,
        start_timestamp_ms: u64,
        amount_per_trade: u64,
        max_allowable_slippage_bps: u16,
        min_amount_out: u64,
        max_amount_out: u64,
        remaining_trades: u8,
    }

    struct CreatedOrderEventV2 has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        user_pk: vector<u8>,
        input_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        frequency_ms: u64,
        start_timestamp_ms: u64,
        amount_per_trade: u64,
        max_allowable_slippage_bps: u16,
        min_amount_out: u64,
        max_amount_out: u64,
        remaining_trades: u8,
        integrator_fee_bps: u16,
        integrator_fee_recipient: address,
    }

    struct ClosedOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        remaining_amount: u64,
        input_type: vector<u8>,
        output_type: vector<u8>,
        gas_amount: u64,
        frequency_ms: u64,
        last_trade_timestamp_ms: u64,
        amount_per_trade: u64,
        max_allowable_slippage_bps: u16,
        min_amount_out: u64,
        max_amount_out: u64,
        remaining_trades: u8,
    }

    struct ExecutedTradeEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        recipient: address,
        input_amount: u64,
        input_type: vector<u8>,
        output_amount: u64,
        output_type: vector<u8>,
    }

    public(friend) fun emit_closed_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: u64, arg10: u64, arg11: u8) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = ClosedOrderEvent{
            order_id                   : arg0,
            user                       : arg1,
            recipient                  : arg2,
            remaining_amount           : arg3,
            input_type                 : *0x1::ascii::as_bytes(&v0),
            output_type                : *0x1::ascii::as_bytes(&v1),
            gas_amount                 : arg4,
            frequency_ms               : arg5,
            last_trade_timestamp_ms    : arg6,
            amount_per_trade           : arg7,
            max_allowable_slippage_bps : arg8,
            min_amount_out             : arg9,
            max_amount_out             : arg10,
            remaining_trades           : arg11,
        };
        0x2::event::emit<ClosedOrderEvent>(v2);
    }

    public(friend) fun emit_created_order_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u16, arg10: u64, arg11: u64, arg12: u8, arg13: u16, arg14: address) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = CreatedOrderEventV2{
            order_id                   : arg0,
            user                       : arg1,
            recipient                  : arg2,
            user_pk                    : arg3,
            input_amount               : arg4,
            input_type                 : *0x1::ascii::as_bytes(&v0),
            output_type                : *0x1::ascii::as_bytes(&v1),
            gas_amount                 : arg5,
            frequency_ms               : arg6,
            start_timestamp_ms         : arg7,
            amount_per_trade           : arg8,
            max_allowable_slippage_bps : arg9,
            min_amount_out             : arg10,
            max_amount_out             : arg11,
            remaining_trades           : arg12,
            integrator_fee_bps         : arg13,
            integrator_fee_recipient   : arg14,
        };
        0x2::event::emit<CreatedOrderEventV2>(v2);
    }

    public(friend) fun emit_executed_trade_event<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
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
        };
        0x2::event::emit<ExecutedTradeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

