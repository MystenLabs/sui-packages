module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send {
    struct SendParam has copy, drop, store {
        base: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam,
    }

    struct SendResult has copy, drop, store {
        encoded_packet: vector<u8>,
        fee: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee,
    }

    public fun base(arg0: &SendParam) : &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam {
        &arg0.base
    }

    public(friend) fun create_param(arg0: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam) : SendParam {
        SendParam{base: arg0}
    }

    public fun create_result(arg0: vector<u8>, arg1: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee) : SendResult {
        SendResult{
            encoded_packet : arg0,
            fee            : arg1,
        }
    }

    public fun encoded_packet(arg0: &SendResult) : &vector<u8> {
        &arg0.encoded_packet
    }

    public fun fee(arg0: &SendResult) : &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee {
        &arg0.fee
    }

    // decompiled from Move bytecode v6
}

