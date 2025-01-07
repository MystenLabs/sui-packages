module 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

