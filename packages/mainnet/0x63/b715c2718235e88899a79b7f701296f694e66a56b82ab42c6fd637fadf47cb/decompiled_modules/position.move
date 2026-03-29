module 0x63b715c2718235e88899a79b7f701296f694e66a56b82ab42c6fd637fadf47cb::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

