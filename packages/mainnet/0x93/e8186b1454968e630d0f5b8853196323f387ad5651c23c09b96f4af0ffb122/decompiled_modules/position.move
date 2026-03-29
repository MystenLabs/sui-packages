module 0x93e8186b1454968e630d0f5b8853196323f387ad5651c23c09b96f4af0ffb122::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

