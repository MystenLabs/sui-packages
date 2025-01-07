module 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_system {
    public fun get(arg0: &0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::Counter) : u32 {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<u32>(0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::borrow_value(arg0))
    }

    public entry fun inc(arg0: &mut 0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::Counter, arg1: u32) {
        let v0 = arg1 > 0 && arg1 < 100;
        0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_error_invalid_increment::require(v0);
        let v1 = 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow_mut<u32>(0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_schema::borrow_mut_value(arg0));
        *v1 = *v1 + arg1;
        0x3161f40cc883773de0e43061ec01d29da93dcb775935f77c2a1850951a912773::counter_event_increment::emit(arg1);
    }

    // decompiled from Move bytecode v6
}

