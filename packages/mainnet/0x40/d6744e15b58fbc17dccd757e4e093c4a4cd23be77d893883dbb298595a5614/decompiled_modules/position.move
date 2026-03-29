module 0x40d6744e15b58fbc17dccd757e4e093c4a4cd23be77d893883dbb298595a5614::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

