module 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

