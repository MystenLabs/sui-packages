module 0x74803ac88036cbd57bf1a46347e22143a47081f7159efb01419f1ed14a17ad67::endpoint_views {
    public fun executable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : u8 {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(arg2);
        let v1 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::has_inbound_payload_hash(arg0, arg1, v0, arg3);
        if (!v1 && arg3 <= 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_lazy_inbound_nonce(arg0, arg1, v0)) {
            return 3
        };
        if (v1) {
            let v2 = 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_inbound_payload_hash(arg0, arg1, v0, arg3);
            if (!0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::is_zero(&v2) && arg3 <= 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_inbound_nonce(arg0, arg1, v0)) {
                return 2
            };
            if (!0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::is_zero(&v2)) {
                return 1
            };
        };
        0
    }

    public fun initializable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::initializable(arg0, arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(arg2))
    }

    public fun verifiable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: vector<u8>, arg3: u64) : bool {
        0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::verifiable(arg0, arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

