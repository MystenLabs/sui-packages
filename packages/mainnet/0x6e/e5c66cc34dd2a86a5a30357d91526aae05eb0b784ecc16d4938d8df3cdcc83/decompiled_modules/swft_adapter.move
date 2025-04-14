module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::swft_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public entry fun xbridge_swft<T0>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: 0x1::string::String, arg2: u32, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        0x2b0876f0b7034320ad6d2f378501fe92e41c8b4780bda7769094d2431170e532::Bridgers::swap<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = LogBridgeTo{
            _adaptorId : arg3,
            _from      : 0x2::tx_context::sender(arg11),
            _to        : arg9,
            _token     : arg6,
            _amount    : arg5,
            _orderId   : arg1,
            _toChainId : arg2,
        };
        0x2::event::emit<LogBridgeTo>(v0);
    }

    public entry fun xbridge_swft_withoutAmountIn<T0>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: 0x1::string::String, arg2: u32, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        0x2b0876f0b7034320ad6d2f378501fe92e41c8b4780bda7769094d2431170e532::Bridgers::swap<T0>(arg4, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = LogBridgeTo{
            _adaptorId : arg3,
            _from      : 0x2::tx_context::sender(arg10),
            _to        : arg8,
            _token     : arg5,
            _amount    : v0,
            _orderId   : arg1,
            _toChainId : arg2,
        };
        0x2::event::emit<LogBridgeTo>(v1);
    }

    // decompiled from Move bytecode v6
}

