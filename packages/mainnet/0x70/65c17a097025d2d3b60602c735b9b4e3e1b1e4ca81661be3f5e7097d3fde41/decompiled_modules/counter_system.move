module 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_system {
    public fun get(arg0: &0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_schema::Counter) : u32 {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<u32>(0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_schema::borrow_value(arg0))
    }

    public entry fun inc(arg0: &mut 0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_schema::Counter, arg1: u32) {
        let v0 = arg1 > 0 && arg1 < 100;
        0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_error_invalid_increment::require(v0);
        let v1 = 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow_mut<u32>(0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_schema::borrow_mut_value(arg0));
        *v1 = *v1 + arg1;
        0x7065c17a097025d2d3b60602c735b9b4e3e1b1e4ca81661be3f5e7097d3fde41::counter_event_increment::emit(arg1);
    }

    // decompiled from Move bytecode v6
}

