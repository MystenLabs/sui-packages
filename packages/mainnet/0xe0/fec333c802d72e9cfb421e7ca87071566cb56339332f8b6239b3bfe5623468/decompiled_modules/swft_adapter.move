module 0xe0fec333c802d72e9cfb421e7ca87071566cb56339332f8b6239b3bfe5623468::swft_adapter {
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

    entry fun test_event() {
        let v0 = TestEvent{_adaptorId: 11};
        0x2::event::emit<TestEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

