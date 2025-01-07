module 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::borrow_position(0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position::Position>(v0),
            amount   : 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool::pending_reward(0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::borrow_pool(0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state::borrow_pool_registry(arg0), arg1), v0, 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state::total_alloc_point(arg0), 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

