module 0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::position_registry::borrow_position(0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::position::Position>(v0),
            amount   : 0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::pool::pending_reward(0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::pool_registry::borrow_pool(0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::state::borrow_pool_registry(arg0), arg1), v0, 0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::state::total_alloc_point(arg0), 0x9db74afd003c4ff083e5f57a38dc1935104ba29cbc2b9d0732e760ea9c1b08fe::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

