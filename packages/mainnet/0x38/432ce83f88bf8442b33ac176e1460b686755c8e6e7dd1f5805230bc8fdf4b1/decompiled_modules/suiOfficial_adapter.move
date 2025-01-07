module 0x38432ce83f88bf8442b33ac176e1460b686755c8e6e7dd1f5805230bc8fdf4b1::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u8,
    }

    entry fun xbridge_suiOfficial<T0>(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xb::bridge::Bridge, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        0xb::bridge::send_token<T0>(arg5, arg1, arg6, arg7, arg8);
        let v0 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg8),
            _to        : arg3,
            _token     : arg4,
            _amount    : 0x2::coin::value<T0>(&arg7),
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v0);
    }

    // decompiled from Move bytecode v6
}

