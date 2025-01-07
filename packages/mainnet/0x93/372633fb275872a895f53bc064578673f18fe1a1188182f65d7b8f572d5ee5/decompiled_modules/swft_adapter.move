module 0x93372633fb275872a895f53bc064578673f18fe1a1188182f65d7b8f572d5ee5::swft_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public entry fun xbridge_swft<T0>(arg0: 0x1::string::String, arg1: u32, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
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

    public entry fun xbridge_swft_withoutAmountIn<T0>(arg0: 0x1::string::String, arg1: u32, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2b0876f0b7034320ad6d2f378501fe92e41c8b4780bda7769094d2431170e532::Bridgers::swap<T0>(arg3, v0, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg9),
            _to        : arg7,
            _token     : arg4,
            _amount    : v0,
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v1);
    }

    // decompiled from Move bytecode v6
}

