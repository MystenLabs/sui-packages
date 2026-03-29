module 0x13ee2983cace85cecb2ce55502e246fbd29b5485276378af952cb72bed63b796::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

