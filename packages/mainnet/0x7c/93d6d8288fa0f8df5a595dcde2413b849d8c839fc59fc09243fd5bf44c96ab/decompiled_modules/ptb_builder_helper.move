module 0x7c93d6d8288fa0f8df5a595dcde2413b849d8c839fc59fc09243fd5bf44c96ab::ptb_builder_helper {
    public fun lz_compose_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_compose::LzComposeParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    public fun lz_receive_call_id() : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::lz_receive::LzReceiveParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>>());
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::from_bytes(0x2::hash::keccak256(0x1::ascii::as_bytes(&v0)))
    }

    // decompiled from Move bytecode v6
}

