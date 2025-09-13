module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send {
    struct SendParam has copy, drop, store {
        base: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam,
    }

    struct SendResult has copy, drop, store {
        encoded_packet: vector<u8>,
        fee: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee,
    }

    public fun base(arg0: &SendParam) : &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam {
        &arg0.base
    }

    public(friend) fun create_param(arg0: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam) : SendParam {
        SendParam{base: arg0}
    }

    public fun create_result(arg0: vector<u8>, arg1: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee) : SendResult {
        SendResult{
            encoded_packet : arg0,
            fee            : arg1,
        }
    }

    public fun encoded_packet(arg0: &SendResult) : &vector<u8> {
        &arg0.encoded_packet
    }

    public fun fee(arg0: &SendResult) : &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee {
        &arg0.fee
    }

    // decompiled from Move bytecode v6
}

