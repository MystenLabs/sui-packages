module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::cctp_adapter {
    struct CctpAuthStruct has drop {
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

    public fun call_create_deposit_for_burn_ticket_xbridge_event<T0: drop>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: 0x1::string::String, arg2: u32, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnTicket<T0, CctpAuthStruct> {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        let v0 = if (arg2 == 1) {
            0
        } else if (arg2 == 43114) {
            1
        } else if (arg2 == 10) {
            2
        } else if (arg2 == 42161) {
            3
        } else if (arg2 == 8453) {
            6
        } else if (arg2 == 137) {
            7
        } else {
            assert!(arg2 == 501, 1);
            5
        };
        let v1 = CctpAuthStruct{dummy_field: false};
        let v2 = LogBridgeTo{
            _adaptorId : arg3,
            _from      : 0x2::tx_context::sender(arg8),
            _to        : arg4,
            _token     : arg5,
            _amount    : 0x2::coin::value<T0>(&arg6),
            _orderId   : arg1,
            _toChainId : arg2,
        };
        0x2::event::emit<LogBridgeTo>(v2);
        0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, CctpAuthStruct>(v1, arg6, v0, arg7)
    }

    // decompiled from Move bytecode v6
}

