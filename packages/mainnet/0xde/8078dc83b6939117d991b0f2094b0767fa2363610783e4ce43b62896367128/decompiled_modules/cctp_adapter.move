module 0xde8078dc83b6939117d991b0f2094b0767fa2363610783e4ce43b62896367128::cctp_adapter {
    struct MyAuthStruct has drop {
        dummy_field: bool,
    }

    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public fun call_create_deposit_for_burn_ticket_xbridge_event<T0: drop>(arg0: 0x1::string::String, arg1: u32, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, MyAuthStruct> {
        let v0 = if (arg1 == 1) {
            0
        } else if (arg1 == 43114) {
            1
        } else if (arg1 == 10) {
            2
        } else if (arg1 == 42161) {
            3
        } else if (arg1 == 8453) {
            6
        } else if (arg1 == 137) {
            7
        } else {
            assert!(arg1 == 501, 1);
            5
        };
        let v1 = MyAuthStruct{dummy_field: false};
        let v2 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg7),
            _to        : arg3,
            _token     : arg4,
            _amount    : 0x2::coin::value<T0>(&arg5),
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v2);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, MyAuthStruct>(v1, arg5, v0, arg6)
    }

    // decompiled from Move bytecode v6
}

