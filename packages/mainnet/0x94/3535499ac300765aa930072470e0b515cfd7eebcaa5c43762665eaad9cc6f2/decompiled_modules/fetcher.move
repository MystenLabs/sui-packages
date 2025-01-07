module 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fetcher {
    struct PendingReward has copy, drop {
        token_reward_amount: u64,
        flx_reward_amount: u64,
    }

    public entry fun fetch_pending_reward<T0, T1, T2>(arg0: &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::State, arg1: &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool::estimate_pending_rewards<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::borrow_pool<T0, T1, T2>(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state::borrow_pool_registry(arg0), 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::pool_idx(arg1)), arg1, arg2);
        let v2 = PendingReward{
            token_reward_amount : v0,
            flx_reward_amount   : v1,
        };
        0x2::event::emit<PendingReward>(v2);
    }

    // decompiled from Move bytecode v6
}

