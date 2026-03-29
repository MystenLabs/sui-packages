module 0xd1830b980d135d0ae631ef287befbd07964464b77ea038f8c23cb1673197a296::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

