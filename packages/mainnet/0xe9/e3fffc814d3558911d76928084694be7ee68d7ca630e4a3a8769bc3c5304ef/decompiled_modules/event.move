module 0xe9e3fffc814d3558911d76928084694be7ee68d7ca630e4a3a8769bc3c5304ef::event {
    struct AddedEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        optimal_x_val: u64,
        optimal_y_val: u64,
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

    struct BurnEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        before: u64,
        burn: u64,
        after: u64,
    }

    struct WithdrewEvent has copy, drop {
        global: 0x2::object::ID,
        lp_name: 0x1::string::String,
        fee_coin_x: u64,
        fee_coin_y: u64,
    }

    public(friend) fun added_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = AddedEvent{
            global        : arg0,
            lp_name       : arg1,
            optimal_x_val : arg4,
            optimal_y_val : arg5,
            coin_x_val    : arg2,
            coin_y_val    : arg3,
            lp_val        : arg6,
        };
        0x2::event::emit<AddedEvent>(v0);
    }

    public(friend) fun burn_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BurnEvent{
            global  : arg0,
            lp_name : arg1,
            before  : arg2,
            burn    : arg3,
            after   : arg4,
        };
        0x2::event::emit<BurnEvent>(v0);
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

    public fun withdrew_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
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

