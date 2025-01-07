module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

