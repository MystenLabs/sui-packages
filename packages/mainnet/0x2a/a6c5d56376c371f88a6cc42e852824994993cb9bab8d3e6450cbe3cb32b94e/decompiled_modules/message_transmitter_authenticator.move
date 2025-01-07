module 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

