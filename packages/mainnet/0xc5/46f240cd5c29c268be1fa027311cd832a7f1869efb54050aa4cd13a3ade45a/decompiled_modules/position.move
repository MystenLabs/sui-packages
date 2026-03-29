module 0xc546f240cd5c29c268be1fa027311cd832a7f1869efb54050aa4cd13a3ade45a::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

