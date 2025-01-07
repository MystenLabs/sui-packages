module 0xff16b049666596adfb470bc274cffa5b65fc26baa6ad678bd243ebce42655b77::swft_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u8,
    }

    entry fun xbridge_swft<T0>(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0x2b0876f0b7034320ad6d2f378501fe92e41c8b4780bda7769094d2431170e532::Bridgers::swap<T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v0 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg10),
            _to        : arg8,
            _token     : arg5,
            _amount    : arg4,
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v0);
    }

    // decompiled from Move bytecode v6
}

