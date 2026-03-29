module 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

