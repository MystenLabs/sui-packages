module 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up {
    struct UP has drop {
        dummy_field: bool,
    }

    struct UpAdmin has store, key {
        id: 0x2::object::UID,
        versions: 0x2::table::Table<0x2::object::ID, u64>,
    }

    public fun assert_valid_version(arg0: &UpAdmin) {
    }

    // decompiled from Move bytecode v7
}

