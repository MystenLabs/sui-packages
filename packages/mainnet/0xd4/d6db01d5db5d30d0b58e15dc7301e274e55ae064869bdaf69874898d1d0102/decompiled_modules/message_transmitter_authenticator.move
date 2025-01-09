module 0xd4d6db01d5db5d30d0b58e15dc7301e274e55ae064869bdaf69874898d1d0102::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

