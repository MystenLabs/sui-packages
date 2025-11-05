module 0x6b84da4f5dc051759382e60352377fea9d59bc6ec92dc60e0b6387e05274415f::event {
    struct AddedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct RemovedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct SwappedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_in: u64,
        coin_x_out: u64,
        coin_y_in: u64,
        coin_y_out: u64,
    }

    struct WithdrewEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        fee_coin_x: u64,
        fee_coin_y: u64,
    }

    public(friend) fun added_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AddedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<AddedEvent>(v0);
    }

    public(friend) fun removed_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemovedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_val : arg2,
            coin_y_val : arg3,
            lp_val     : arg4,
        };
        0x2::event::emit<RemovedEvent>(v0);
    }

    public(friend) fun swapped_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwappedEvent{
            global     : arg0,
            lp_name    : arg1,
            coin_x_in  : arg2,
            coin_x_out : arg3,
            coin_y_in  : arg4,
            coin_y_out : arg5,
        };
        0x2::event::emit<SwappedEvent>(v0);
    }

    public(friend) fun withdrew_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = WithdrewEvent{
            global     : arg0,
            lp_name    : arg1,
            fee_coin_x : arg2,
            fee_coin_y : arg3,
        };
        0x2::event::emit<WithdrewEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

