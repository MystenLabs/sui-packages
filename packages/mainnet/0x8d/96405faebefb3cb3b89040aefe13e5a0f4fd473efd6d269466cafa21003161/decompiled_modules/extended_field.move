module 0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::extended_field {
    struct VersionKey has copy, drop, store {
        pos0: u64,
    }

    public(friend) fun borrow<T0: store + key>(arg0: &0x2::object::UID, arg1: u64) : &T0 {
        let v0 = VersionKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<VersionKey, T0>(arg0, v0)
    }

    public(friend) fun borrow_mut<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: u64) : &mut T0 {
        let v0 = VersionKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<VersionKey, T0>(arg0, v0)
    }

    public(friend) fun add<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: u64, arg2: T0) {
        let v0 = VersionKey{pos0: arg1};
        0x2::dynamic_object_field::add<VersionKey, T0>(arg0, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

