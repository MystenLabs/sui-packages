module 0xccd6b59ef8ec09c0357edae5d5f7965927a4b81f852646194035e884c13856fa::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u8,
    }

    public entry fun xbridge_suiOfficial<T0>(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xb::bridge::Bridge, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, arg9);
        let v0 = if (arg1 == 1) {
            10
        } else {
            arg1
        };
        0xb::bridge::send_token<T0>(arg5, v0, arg6, arg7, arg10);
        let v1 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg10),
            _to        : arg3,
            _token     : arg4,
            _amount    : 0x2::coin::value<T0>(&arg7),
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v1);
    }

    public entry fun xbridge_suiOfficial_commission<T0>(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xb::bridge::Bridge, arg6: vector<u8>, arg7: &mut 0x2::coin::Coin<T0>, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: address, arg11: u64, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, arg10);
        let v0 = if (arg1 == 1) {
            10
        } else {
            arg1
        };
        0xb::bridge::send_token<T0>(arg5, v0, arg6, 0xccd6b59ef8ec09c0357edae5d5f7965927a4b81f852646194035e884c13856fa::commission::calculate_and_distribute_commission<T0>(arg7, arg11, arg12, arg8, arg13), arg13);
        let v1 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg13),
            _to        : arg3,
            _token     : arg4,
            _amount    : arg8,
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v1);
    }

    // decompiled from Move bytecode v6
}

