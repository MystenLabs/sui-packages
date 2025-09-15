module 0x74803ac88036cbd57bf1a46347e22143a47081f7159efb01419f1ed14a17ad67::uln_302_views {
    public fun verifiable(arg0: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302, arg1: &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::receive_uln::Verification, arg2: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2, arg3: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg4: vector<u8>, arg5: vector<u8>) : u8 {
        let v0 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::decode_header(arg4);
        let v1 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::src_eid(&v0);
        let v2 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::sender(&v0);
        let v3 = 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::receiver(&v0);
        if (!0x74803ac88036cbd57bf1a46347e22143a47081f7159efb01419f1ed14a17ad67::endpoint_views::initializable(arg3, v1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::to_bytes(&v2))) {
            return 3
        };
        if (!endpoint_verifiable(arg3, v1, v2, 0x5ccc92487b6d38cf5e327c8c5178776d48dbf82020f25b2f766dcf3dfd669752::packet_v1_codec::nonce(&v0), 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::to_address(&v3), arg5)) {
            return 2
        };
        if (0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::verifiable(arg0, arg1, arg2, arg4, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(arg5))) {
            return 1
        };
        0
    }

    fun endpoint_verifiable(arg0: &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_channel::MessagingChannel, arg1: u32, arg2: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg3: u64, arg4: address, arg5: vector<u8>) : bool {
        if (!0x74803ac88036cbd57bf1a46347e22143a47081f7159efb01419f1ed14a17ad67::endpoint_views::verifiable(arg0, arg1, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::to_bytes(&arg2), arg3)) {
            return false
        };
        if (0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::has_inbound_payload_hash(arg0, arg1, arg2, arg3)) {
            if (0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::get_inbound_payload_hash(arg0, arg1, arg2, arg3) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(arg5)) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

