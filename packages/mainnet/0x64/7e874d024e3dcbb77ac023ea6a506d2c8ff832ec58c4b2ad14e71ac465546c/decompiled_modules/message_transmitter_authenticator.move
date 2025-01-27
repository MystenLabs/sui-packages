module 0x647e874d024e3dcbb77ac023ea6a506d2c8ff832ec58c4b2ad14e71ac465546c::message_transmitter_authenticator {
    struct MessageTransmitterAuthenticator has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : MessageTransmitterAuthenticator {
        MessageTransmitterAuthenticator{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

