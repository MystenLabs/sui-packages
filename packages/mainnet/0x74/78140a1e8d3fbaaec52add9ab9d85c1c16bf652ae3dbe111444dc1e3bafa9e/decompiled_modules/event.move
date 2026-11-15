module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::event {
    struct TypusEvent has copy, drop {
        action: 0x1::string::String,
        log: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bcs_padding: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    struct Event has copy, drop {
        action: 0x1::string::String,
        log: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bcs_padding: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    public fun emit_event(arg0: 0x1::string::String, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>) {
        abort 0
    }

    public(friend) fun emit_typus_event(arg0: 0x1::string::String, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>) {
        let v0 = TypusEvent{
            action      : arg0,
            log         : arg1,
            bcs_padding : arg2,
        };
        0x2::event::emit<TypusEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

