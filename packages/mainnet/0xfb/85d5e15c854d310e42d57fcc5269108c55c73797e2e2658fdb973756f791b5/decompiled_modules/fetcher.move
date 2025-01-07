module 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position_registry::borrow_position(0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position : 0x2::object::id<0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::Position>(v0),
            amount   : 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::pool::pending_reward(0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::pool_registry::borrow_pool(0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::state::borrow_pool_registry(arg0), arg1), v0, 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::state::total_alloc_point(arg0), 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::state::reward_per_sec(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

