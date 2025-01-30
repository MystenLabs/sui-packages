module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::counter_system {
    public fun get(arg0: &0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::Schema) : u32 {
        *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u32>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::borrow_counter(arg0))
    }

    public entry fun inc(arg0: &mut 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::Schema, arg1: u32) {
        let v0 = arg1 > 0 && arg1 < 100;
        0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::errors::invalid_increment_error(v0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u32>(0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::schema::counter(arg0), get(arg0) + arg1);
        0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::events::increment_event(arg1);
    }

    // decompiled from Move bytecode v6
}

