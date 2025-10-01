module 0xd4f403280fa2c05da6ec6e75c563e88b60326a0300ac71bfea91028772c12f85::endpoint_views {
    public fun initializable(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>) : bool {
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::initializable(arg0, arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg2))
    }

    public fun verifiable(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : bool {
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::verifiable(arg0, arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg2), arg3)
    }

    public fun executable(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : u8 {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg2);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::has_inbound_payload_hash(arg0, arg1, v0, arg3);
        if (!v1 && arg3 <= 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_lazy_inbound_nonce(arg0, arg1, v0)) {
            return 3
        };
        if (v1) {
            let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_inbound_payload_hash(arg0, arg1, v0, arg3);
            if (!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v2) && arg3 <= 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_inbound_nonce(arg0, arg1, v0)) {
                return 2
            };
            if (!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v2)) {
                return 1
            };
        };
        0
    }

    // decompiled from Move bytecode v6
}

