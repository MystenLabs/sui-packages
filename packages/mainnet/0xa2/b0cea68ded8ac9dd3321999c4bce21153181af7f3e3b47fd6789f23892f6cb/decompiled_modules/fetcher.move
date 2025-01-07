module 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::borrow_position(0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position::Position>(v0),
            amount   : 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool::pending_reward(0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::borrow_pool(0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state::borrow_pool_registry(arg0), arg1), v0, 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state::total_alloc_point(arg0), 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

