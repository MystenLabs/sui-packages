module 0x4066a34f5b6467f80cfd9bcb2aa4ed470cc643c9529f15a71bb110660fe28a3c::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

