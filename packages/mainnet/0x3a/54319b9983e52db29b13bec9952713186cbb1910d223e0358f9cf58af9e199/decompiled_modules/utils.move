module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils {
    public(friend) fun assert_auth<T0>(arg0: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_bound<T0>(arg0, arg2);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_auth(arg1, arg3);
    }

    public(friend) fun assert_bound<T0>(arg0: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>) {
        assert!(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::state_id<T0>(arg0) == 0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>>(arg1), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
    }

    public(friend) fun require_schedule<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg1: u64) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule {
        let v0 = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::rewards_schedule<T0>(arg0);
        assert!(0x1::option::is_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(&v0), arg1);
        0x1::option::destroy_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(v0)
    }

    public(friend) fun write<T0>(arg0: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg2: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: 0x1::option::Option<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>, arg5: &0x2::clock::Clock) {
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::admin::set_rewards_schedule<T0>(arg1, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::borrow_cap<T0>(arg0), arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

