module 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        token_reward_amount: u64,
        flx_reward_amount: u64,
    }

    public entry fun fetch_pending_reward<T0, T1, T2>(arg0: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry::borrow_position(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_position_registry(arg0), arg1, 0x2::tx_context::sender(arg3));
        let (v1, v2) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::estimate_pending_rewards<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_pool<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_pool_registry(arg0), arg1), v0, arg2);
        let v3 = PendingReward{
            position            : 0x2::object::id<0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position>(v0),
            token_reward_amount : v1,
            flx_reward_amount   : v2,
        };
        0x2::event::emit<PendingReward>(v3);
    }

    // decompiled from Move bytecode v6
}

