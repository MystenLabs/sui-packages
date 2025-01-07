module 0x8168b97740fd0e62a3e9a32c34d3e1254be1f0b6b12ade289ed7dd6a6b50d772::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u8,
    }

    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        refel_address: address,
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

    public entry fun xbridge_suiOfficial_commission<T0>(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xb::bridge::Bridge, arg6: vector<u8>, arg7: &mut 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 <= 300, 1);
        let v0 = arg8 * arg9 / (10000 - arg9);
        assert!(0x2::coin::value<T0>(arg7) >= v0 + arg8, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg7, v0, arg11), arg10);
        let v1 = CommissionRecord{
            commission_amount : v0,
            refel_address     : arg10,
        };
        0x2::event::emit<CommissionRecord>(v1);
        let v2 = if (arg1 == 1) {
            10
        } else {
            arg1
        };
        0xb::bridge::send_token<T0>(arg5, v2, arg6, 0x2::coin::split<T0>(arg7, arg8, arg11), arg11);
        let v3 = LogBridgeTo{
            _adaptorId : arg2,
            _from      : 0x2::tx_context::sender(arg11),
            _to        : arg3,
            _token     : arg4,
            _amount    : arg8,
            _orderId   : arg0,
            _toChainId : arg1,
        };
        0x2::event::emit<LogBridgeTo>(v3);
    }

    // decompiled from Move bytecode v6
}

