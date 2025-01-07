module 0x7ae555c9d178e192b8ca7cef793aef9427609e109c54349038f104fcb448cdbe::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public entry fun xbridge_suiOfficial<T0>(arg0: 0x1::string::String, arg1: u32, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xb::bridge::Bridge, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 1, 1);
        0xb::bridge::send_token<T0>(arg5, 10, arg6, arg7, arg8);
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

