module 0xa3ec2b3938c370c7ab4baedb95baf6f98df3d30f7635ff93714db2bece016fb1::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

