module 0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::position_registry::borrow_position(0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::position::Position>(v0),
            amount   : 0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::pool::pending_reward(0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::pool_registry::borrow_pool(0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::state::borrow_pool_registry(arg0), arg1), v0, 0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::state::total_alloc_point(arg0), 0x8fae3413f869d902656a8c2ca3e001ec836bf621c4f30011d0ba98d68121d8e5::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

