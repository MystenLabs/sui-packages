module 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::event {
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

    struct SwappedEvent<phantom T0, phantom T1> has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        coin_x_decimals: u64,
        coin_y_decimals: u64,
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

    public(friend) fun swapped_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = SwappedEvent<T0, T1>{
            global          : arg0,
            lp_name         : arg1,
            coin_x_decimals : arg2,
            coin_y_decimals : arg3,
            coin_x_in       : arg4,
            coin_x_out      : arg5,
            coin_y_in       : arg6,
            coin_y_out      : arg7,
        };
        0x2::event::emit<SwappedEvent<T0, T1>>(v0);
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

