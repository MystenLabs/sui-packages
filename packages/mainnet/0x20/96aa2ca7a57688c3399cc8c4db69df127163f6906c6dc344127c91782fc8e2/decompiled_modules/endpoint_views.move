module 0x2096aa2ca7a57688c3399cc8c4db69df127163f6906c6dc344127c91782fc8e2::endpoint_views {
    public fun executable(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : u8 {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(arg2);
        let v1 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::has_inbound_payload_hash(arg0, arg1, v0, arg3);
        if (!v1 && arg3 <= 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_lazy_inbound_nonce(arg0, arg1, v0)) {
            return 3
        };
        if (v1) {
            let v2 = 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_inbound_payload_hash(arg0, arg1, v0, arg3);
            if (!0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::is_zero(&v2) && arg3 <= 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::get_inbound_nonce(arg0, arg1, v0)) {
                return 2
            };
            if (!0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::is_zero(&v2)) {
                return 1
            };
        };
        0
    }

    public fun initializable(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>) : bool {
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::initializable(arg0, arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(arg2))
    }

    public fun verifiable(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : bool {
        0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::verifiable(arg0, arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

