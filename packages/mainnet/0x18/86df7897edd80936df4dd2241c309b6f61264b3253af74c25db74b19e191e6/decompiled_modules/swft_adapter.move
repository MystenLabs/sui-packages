module 0x1886df7897edd80936df4dd2241c309b6f61264b3253af74c25db74b19e191e6::swft_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: 0x1::string::String,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: 0x1::string::String,
    }

    struct LogSwapAndBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: 0x1::string::String,
        _to: 0x1::string::String,
        _fromToken: 0x1::string::String,
        _fromAmount: 0x1::string::String,
        _toToken: 0x1::string::String,
        _toAmount: 0x1::string::String,
    }

    struct TestEvent has copy, drop {
        _adaptorId: u8,
    }

    fun test_event() {
        let v0 = TestEvent{_adaptorId: 11};
        0x2::event::emit<TestEvent>(v0);
    }

    entry fun xbridge_swft<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0xc5ed6cc658e92632dcbd32d943c78dd2a47c082fbd26f7e68eb00e11fce161e3::Bridgers::swap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

