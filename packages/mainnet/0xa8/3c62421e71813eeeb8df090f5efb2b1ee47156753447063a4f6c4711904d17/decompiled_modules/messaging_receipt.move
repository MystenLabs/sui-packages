module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_receipt {
    struct MessagingReceipt has copy, drop, store {
        guid: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        nonce: u64,
        messaging_fee: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee,
    }

    public fun messaging_fee(arg0: &MessagingReceipt) : &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee {
        &arg0.messaging_fee
    }

    public(friend) fun create(arg0: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg1: u64, arg2: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee) : MessagingReceipt {
        MessagingReceipt{
            guid          : arg0,
            nonce         : arg1,
            messaging_fee : arg2,
        }
    }

    public fun guid(arg0: &MessagingReceipt) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.guid
    }

    public fun nonce(arg0: &MessagingReceipt) : u64 {
        arg0.nonce
    }

    // decompiled from Move bytecode v6
}

