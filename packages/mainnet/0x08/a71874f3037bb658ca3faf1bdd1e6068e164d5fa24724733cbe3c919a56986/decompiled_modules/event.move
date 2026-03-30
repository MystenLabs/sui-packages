module 0x8a71874f3037bb658ca3faf1bdd1e6068e164d5fa24724733cbe3c919a56986::event {
    struct StakedEvent has copy, drop {
        global: 0x2::object::ID,
        staker: address,
        order_id: u64,
        amount: u64,
    }

    struct UnstakedEvent has copy, drop {
        global: 0x2::object::ID,
        staker: address,
        order_id: u64,
        original_amount: u64,
        payout: u64,
        elapsed_days: u64,
    }

    struct AdminDepositedEvent has copy, drop {
        global: 0x2::object::ID,
        amount: u64,
        cumulative_admin_deposited: u64,
    }

    struct AdminWithdrawnEvent has copy, drop {
        global: 0x2::object::ID,
        amount: u64,
        cumulative_admin_deposited: u64,
        cumulative_admin_withdrawn: u64,
    }

    public fun admin_deposited_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AdminDepositedEvent{
            global                     : arg0,
            amount                     : arg1,
            cumulative_admin_deposited : arg2,
        };
        0x2::event::emit<AdminDepositedEvent>(v0);
    }

    public fun admin_withdrawn_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AdminWithdrawnEvent{
            global                     : arg0,
            amount                     : arg1,
            cumulative_admin_deposited : arg2,
            cumulative_admin_withdrawn : arg3,
        };
        0x2::event::emit<AdminWithdrawnEvent>(v0);
    }

    public fun staked_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = StakedEvent{
            global   : arg0,
            staker   : arg1,
            order_id : arg2,
            amount   : arg3,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public fun unstaked_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = UnstakedEvent{
            global          : arg0,
            staker          : arg1,
            order_id        : arg2,
            original_amount : arg3,
            payout          : arg4,
            elapsed_days    : arg5,
        };
        0x2::event::emit<UnstakedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

