module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_position_id(arg0: &PositionCap) : 0x2::object::ID {
        0x2::object::id<PositionCap>(arg0)
    }

    // decompiled from Move bytecode v6
}

