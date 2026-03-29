module 0xb51c608f9233dbd20359e3771621ac685f08e9df15e6dd3f662c4a7e4d91c626::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

