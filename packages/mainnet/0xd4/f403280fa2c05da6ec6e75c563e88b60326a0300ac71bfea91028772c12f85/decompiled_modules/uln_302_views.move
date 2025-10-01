module 0xd4f403280fa2c05da6ec6e75c563e88b60326a0300ac71bfea91028772c12f85::uln_302_views {
    public fun verifiable(arg0: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302, arg1: &0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::receive_uln::Verification, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: vector<u8>) : u8 {
        let v0 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::decode_header(arg4);
        let v1 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::src_eid(&v0);
        let v2 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::sender(&v0);
        let v3 = 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::receiver(&v0);
        if (!0xd4f403280fa2c05da6ec6e75c563e88b60326a0300ac71bfea91028772c12f85::endpoint_views::initializable(arg3, v1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v2))) {
            return 3
        };
        if (!endpoint_verifiable(arg3, v1, v2, 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec::nonce(&v0), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_address(&v3), arg5)) {
            return 2
        };
        if (0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::verifiable(arg0, arg1, arg2, arg4, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg5))) {
            return 1
        };
        0
    }

    fun endpoint_verifiable(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: address, arg5: vector<u8>) : bool {
        if (!0xd4f403280fa2c05da6ec6e75c563e88b60326a0300ac71bfea91028772c12f85::endpoint_views::verifiable(arg0, arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg2), arg3)) {
            return false
        };
        if (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::has_inbound_payload_hash(arg0, arg1, arg2, arg3)) {
            if (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_inbound_payload_hash(arg0, arg1, arg2, arg3) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(arg5)) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

