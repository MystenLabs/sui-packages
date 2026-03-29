module 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

