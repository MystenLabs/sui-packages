module 0xd5ddf37a26069e8ca201ad610d33e1ad6b3902f5eabd415b7bcbc79ff0012673::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

