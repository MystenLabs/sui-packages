module 0x492fb5c32d3fd060db7a9e5b4fcc31d0e0f95aa118f3961b8242f893f314ecc9::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

