module 0xb852c18ee424f3f693377d39fc69c148b55456483e6114fa6861041ed1a720d::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

