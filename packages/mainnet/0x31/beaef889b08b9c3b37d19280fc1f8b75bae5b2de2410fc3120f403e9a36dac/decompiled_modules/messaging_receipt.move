module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt {
    struct MessagingReceipt has copy, drop, store {
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        nonce: u64,
        messaging_fee: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee,
    }

    public fun messaging_fee(arg0: &MessagingReceipt) : &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee {
        &arg0.messaging_fee
    }

    public(friend) fun create(arg0: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg1: u64, arg2: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee) : MessagingReceipt {
        MessagingReceipt{
            guid          : arg0,
            nonce         : arg1,
            messaging_fee : arg2,
        }
    }

    public fun guid(arg0: &MessagingReceipt) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.guid
    }

    public fun nonce(arg0: &MessagingReceipt) : u64 {
        arg0.nonce
    }

    // decompiled from Move bytecode v6
}

