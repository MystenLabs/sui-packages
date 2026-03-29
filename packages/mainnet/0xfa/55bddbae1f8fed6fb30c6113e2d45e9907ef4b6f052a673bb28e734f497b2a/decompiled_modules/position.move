module 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

