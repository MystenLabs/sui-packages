module 0x9d0e07d2ce87e1e1bfedf336d4f02a02f8da0bdce337239916582caca45882c9::protocol_fee {
    struct ProtocolFeeInfo has copy, drop, store {
        protocol_fees: 0x1::uq32_32::UQ32_32,
        protocol_fee_recipient: address,
    }

    public fun fees(arg0: &ProtocolFeeInfo) : 0x1::uq32_32::UQ32_32 {
        arg0.protocol_fees
    }

    public(friend) fun new(arg0: u64, arg1: address) : ProtocolFeeInfo {
        ProtocolFeeInfo{
            protocol_fees          : 0x1::uq32_32::from_quotient(arg0, 10000),
            protocol_fee_recipient : arg1,
        }
    }

    public fun recipient(arg0: &ProtocolFeeInfo) : address {
        arg0.protocol_fee_recipient
    }

    // decompiled from Move bytecode v6
}

