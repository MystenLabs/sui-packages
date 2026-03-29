module 0x228fb39a56d4462fe5708e6d66a72eacd31af7f0d62b094ec0c8e9c75ea33f83::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

