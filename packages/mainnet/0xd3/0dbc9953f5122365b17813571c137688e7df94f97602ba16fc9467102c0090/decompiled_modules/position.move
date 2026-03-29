module 0xd30dbc9953f5122365b17813571c137688e7df94f97602ba16fc9467102c0090::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

