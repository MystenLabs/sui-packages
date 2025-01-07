module 0x4ebd63e982fa6b7129445cab9dbbbaa38185f2d2ee0e4adae9543be69d60e673::events {
    struct StakedEvent has copy, drop {
        user: address,
        new_afsui_collateral: u64,
        leverage: u64,
    }

    struct UnstakedEvent has copy, drop {
        user: address,
        afsui_collateral: u64,
    }

    struct ChangedLeverageEvent has copy, drop {
        user: address,
        initial_leverage: u64,
        new_leverage: u64,
    }

    public(friend) fun emit_changed_leverage_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = ChangedLeverageEvent{
            user             : arg0,
            initial_leverage : arg1,
            new_leverage     : arg2,
        };
        0x2::event::emit<ChangedLeverageEvent>(v0);
    }

    public(friend) fun emit_staked_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = StakedEvent{
            user                 : arg0,
            new_afsui_collateral : arg1,
            leverage             : arg2,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public(friend) fun emit_unstaked_event(arg0: address, arg1: u64) {
        let v0 = UnstakedEvent{
            user             : arg0,
            afsui_collateral : arg1,
        };
        0x2::event::emit<UnstakedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

