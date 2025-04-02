module 0x8311d1043f61514acc476e2752ff00ac1d4baac4df570ded6b8dcc56e094fe5c::LifiEventLogger {
    struct LifiLogEvent has copy, drop {
        keys: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
    }

    public fun log_event(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 1);
        let v0 = LifiLogEvent{
            keys   : arg0,
            values : arg1,
        };
        0x2::event::emit<LifiLogEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

