module 0x358178c785ede95df97611c9a6755723365b6d0978a86934b8f2a9b3bd6b317a::settings {
    struct Settings has key {
        id: 0x2::object::UID,
        enabled: bool,
        our_bps: u64,
        treasury: address,
        rebate_to: 0x1::option::Option<address>,
    }

    public fun create(arg0: u64, arg1: address, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x24edb789b606facaaa1994d418d77873e40a0638f130e2de6abb794cb521f287, 930);
        assert!(arg0 <= 10000, 931);
        let v0 = Settings{
            id        : 0x2::object::new(arg3),
            enabled   : true,
            our_bps   : arg0,
            treasury  : arg1,
            rebate_to : arg2,
        };
        0x2::transfer::share_object<Settings>(v0);
    }

    public fun enabled(arg0: &Settings) : bool {
        arg0.enabled
    }

    public fun our_bps(arg0: &Settings) : u64 {
        arg0.our_bps
    }

    public fun rebate_address(arg0: &Settings, arg1: address) : address {
        if (0x1::option::is_some<address>(&arg0.rebate_to)) {
            *0x1::option::borrow<address>(&arg0.rebate_to)
        } else {
            arg1
        }
    }

    public fun set(arg0: &mut Settings, arg1: bool, arg2: u64, arg3: address, arg4: 0x1::option::Option<address>, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x24edb789b606facaaa1994d418d77873e40a0638f130e2de6abb794cb521f287, 930);
        assert!(arg2 <= 10000, 931);
        arg0.enabled = arg1;
        arg0.our_bps = arg2;
        arg0.treasury = arg3;
        arg0.rebate_to = arg4;
    }

    public fun treasury(arg0: &Settings) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

