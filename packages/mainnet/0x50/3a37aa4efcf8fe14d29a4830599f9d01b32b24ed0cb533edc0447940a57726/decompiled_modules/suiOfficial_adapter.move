module 0x503a37aa4efcf8fe14d29a4830599f9d01b32b24ed0cb533edc0447940a57726::suiOfficial_adapter {
    struct LogBridgeTo has copy, drop {
        _adaptorId: u8,
        _from: address,
        _to: 0x1::string::String,
        _token: 0x1::string::String,
        _amount: u64,
        _orderId: 0x1::string::String,
        _toChainId: u8,
    }

    // decompiled from Move bytecode v6
}

