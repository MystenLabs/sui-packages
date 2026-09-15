module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

