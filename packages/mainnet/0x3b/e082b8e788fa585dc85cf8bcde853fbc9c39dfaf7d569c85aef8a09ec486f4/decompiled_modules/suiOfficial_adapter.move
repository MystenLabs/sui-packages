module 0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u32,
    }

    public entry fun xbridge_suiOfficial<T0>(arg0: &0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::init::Version, arg1: 0x1::string::String, arg2: u32, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0xb::bridge::Bridge, arg7: vector<u8>, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        0x3be082b8e788fa585dc85cf8bcde853fbc9c39dfaf7d569c85aef8a09ec486f4::init::check_dexrouter_version(arg0);
        assert!(arg2 == 1, 1);
        0xb::bridge::send_token<T0>(arg6, 10, arg7, arg8, arg9);
        let v0 = LogBridgeTo{
            _adaptorId : arg3,
            _from      : 0x2::tx_context::sender(arg9),
            _to        : arg4,
            _token     : arg5,
            _amount    : 0x2::coin::value<T0>(&arg8),
            _orderId   : arg1,
            _toChainId : arg2,
        };
        0x2::event::emit<LogBridgeTo>(v0);
    }

    // decompiled from Move bytecode v6
}

