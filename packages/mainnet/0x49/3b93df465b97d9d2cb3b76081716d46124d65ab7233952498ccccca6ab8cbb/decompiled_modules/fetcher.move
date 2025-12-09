module 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::position_registry::borrow_position(0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::position::Position>(v0),
            amount   : 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::pool::pending_reward(0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::pool_registry::borrow_pool(0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::state::borrow_pool_registry(arg0), arg1), v0, 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::state::total_alloc_point(arg0), 0x493b93df465b97d9d2cb3b76081716d46124d65ab7233952498ccccca6ab8cbb::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

