module 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::fetcher {
    struct PendingReward has copy, drop {
        position: 0x2::object::ID,
        pending_ostr_reward: u64,
    }

    public entry fun fetch_pending_reward(arg0: &0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::State, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position_registry::borrow_position(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_position_registry(arg0), arg1, arg2);
        let v1 = PendingReward{
            position            : 0x2::object::id<0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::position::Position>(v0),
            pending_ostr_reward : 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool::pending_ostr(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::pool_registry::borrow_pool(0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::borrow_pool_registry(arg0), arg1), v0, 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::total_alloc_point(arg0), 0xf794e590fb6a42aee87837631e6ff9c006397503d64a1d3f69bfb3938a118b9e::state::ostr_per_ms(arg0), arg3),
        };
        0x2::event::emit<PendingReward>(v1);
    }

    // decompiled from Move bytecode v6
}

