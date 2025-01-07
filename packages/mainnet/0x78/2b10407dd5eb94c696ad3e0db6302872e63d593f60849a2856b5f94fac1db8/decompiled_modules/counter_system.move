module 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_system {
    public fun get(arg0: &0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::Counter) : u32 {
        0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::get<u32>(0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::borrow_value(arg0))
    }

    public entry fun inc(arg0: &mut 0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::Counter, arg1: u32) {
        let v0 = arg1 > 0 && arg1 < 100;
        0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_error_invalid_increment::require(v0);
        let v1 = 0x1ec50128fe12af3bec330f7be7297e01386701d803b6616e01dcd396bdac240c::storage_value::borrow_mut<u32>(0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_schema::borrow_mut_value(arg0));
        *v1 = *v1 + arg1;
        0x782b10407dd5eb94c696ad3e0db6302872e63d593f60849a2856b5f94fac1db8::counter_event_increment::emit(arg1);
    }

    // decompiled from Move bytecode v6
}

