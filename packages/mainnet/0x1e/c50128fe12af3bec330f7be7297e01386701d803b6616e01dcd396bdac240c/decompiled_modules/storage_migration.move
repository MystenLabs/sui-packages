module 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_migration {
    public fun add_field<T0: store>(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: T0) {
        0x2::dynamic_field::add<vector<u8>, T0>(arg0, arg1, arg2);
    }

    public fun borrow_field<T0: store>(arg0: &0x2::object::UID, arg1: vector<u8>) : &T0 {
        0x2::dynamic_field::borrow<vector<u8>, T0>(arg0, arg1)
    }

    public fun borrow_mut_field<T0: store>(arg0: &mut 0x2::object::UID, arg1: vector<u8>) : &mut T0 {
        0x2::dynamic_field::borrow_mut<vector<u8>, T0>(arg0, arg1)
    }

    public fun field_exists(arg0: &0x2::object::UID, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

