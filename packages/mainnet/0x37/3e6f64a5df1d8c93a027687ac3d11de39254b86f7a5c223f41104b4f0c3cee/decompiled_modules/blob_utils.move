module 0x373e6f64a5df1d8c93a027687ac3d11de39254b86f7a5c223f41104b4f0c3cee::blob_utils {
    public fun blob_id_to_string(arg0: u256) : 0x1::string::String {
        0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64url::encode(0x2::bcs::to_bytes<u256>(&arg0))
    }

    public fun blob_id_to_u256(arg0: 0x1::string::String) : u256 {
        let v0 = 0x2::bcs::new(0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64url::decode(arg0));
        0x2::bcs::peel_u256(&mut v0)
    }

    // decompiled from Move bytecode v6
}

