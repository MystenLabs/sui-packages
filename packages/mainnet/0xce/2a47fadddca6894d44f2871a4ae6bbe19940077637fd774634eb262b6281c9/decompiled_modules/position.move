module 0xce2a47fadddca6894d44f2871a4ae6bbe19940077637fd774634eb262b6281c9::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

