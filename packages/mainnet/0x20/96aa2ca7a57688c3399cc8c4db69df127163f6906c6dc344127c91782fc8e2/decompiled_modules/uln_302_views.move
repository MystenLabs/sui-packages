module 0x2096aa2ca7a57688c3399cc8c4db69df127163f6906c6dc344127c91782fc8e2::uln_302_views {
    public fun verifiable(arg0: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::receive_uln::Verification, arg2: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2, arg3: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: vector<u8>) : u8 {
        let v0 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::decode_header(arg4);
        let v1 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::src_eid(&v0);
        let v2 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::sender(&v0);
        let v3 = 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::receiver(&v0);
        if (!0x2096aa2ca7a57688c3399cc8c4db69df127163f6906c6dc344127c91782fc8e2::endpoint_views::initializable(arg3, v1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_bytes(&v2))) {
            return 3
        };
        if (!endpoint_verifiable(arg3, v1, v2, 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec::nonce(&v0), 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_address(&v3), arg5)) {
            return 2
        };
        if (0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::verifiable(arg0, arg1, arg2, arg4, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(arg5))) {
            return 1
        };
        0
    }

    fun endpoint_verifiable(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg3: u64, arg4: address, arg5: vector<u8>) : bool {
        if (!0x2096aa2ca7a57688c3399cc8c4db69df127163f6906c6dc344127c91782fc8e2::endpoint_views::verifiable(arg0, arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_bytes(&arg2), arg3)) {
            return false
        };
        if (0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::has_inbound_payload_hash(arg0, arg1, arg2, arg3)) {
            if (0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_inbound_payload_hash(arg0, arg1, arg2, arg3) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(arg5)) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

