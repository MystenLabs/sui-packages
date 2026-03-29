module 0xc52251dce334bd27de034ca0160366689a95a4ed0f503fbc2dd819f41f4be009::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

