module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::admin {
    public fun cancel_queued_rewards<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg3: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::assert_auth<T0>(arg2, arg1, arg3, arg6);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs::plan_cancel(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::require_schedule<T0>(arg3, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::no_queued_rewards()), arg5)), arg5);
    }

    public fun create_manager<T0>(arg0: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg1: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg2: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg0);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_auth(arg0, arg3);
        let v0 = 0x2::object::id<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>>(arg1);
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::cap_state_id<T0>(&arg2) == v0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::share<T0>(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::new<T0>(arg2, v0, arg3));
    }

    public fun migrate(arg0: &mut 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_authority(arg0, arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::migrate(arg0);
    }

    public fun queue_next_rewards<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg3: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::assert_auth<T0>(arg2, arg1, arg3, arg8);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs::plan_queue(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::require_schedule<T0>(arg3, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::no_rewards_started()), arg5, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(arg6), arg7)), arg7);
    }

    public fun start_rewards<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg3: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::assert_auth<T0>(arg2, arg1, arg3, arg10);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs::plan_start(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::rewards_schedule<T0>(arg3), arg5, arg6, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(arg7), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::timestamp_from_seconds(arg8), arg9)), arg9);
    }

    public fun stop_rewards<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg3: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::assert_auth<T0>(arg2, arg1, arg3, arg6);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs::assert_stoppable(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::require_schedule<T0>(arg3, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::already_stopped()), arg5);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::none<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(), arg5);
    }

    public fun transition_to_next_rewards<T0>(arg0: &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry::LendingRegistry, arg1: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg2: &0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager::RewardsManager<T0>, arg3: &mut 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_state::LendingState<T0>, arg4: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg5: &0x2::clock::Clock) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::assert_bound<T0>(arg2, arg3);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs::plan_transition(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::utils::require_schedule<T0>(arg3, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::no_queued_rewards()), arg5)), arg5);
    }

    public fun update_auth(arg0: &mut 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg0);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_authority(arg0, arg3);
        assert!(arg1 != @0x0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        assert!(!0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::is_authority(arg0, arg1), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        if (arg2) {
            assert!(!0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::is_auth(arg0, arg1), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::auth_already_assigned());
            0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::add_auth(arg0, arg1);
        } else {
            assert!(0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::is_auth(arg0, arg1), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::auth_not_assigned());
            0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::remove_auth(arg0, arg1);
        };
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::events::emit_log_update_auth(arg1, arg2);
    }

    public fun update_authority(arg0: &mut 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::RewardsAuth, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_version(arg0);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::assert_authority(arg0, arg2);
        assert!(arg1 != @0x0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        let v0 = 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::authority(arg0);
        assert!(arg1 != v0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::remove_auth(arg0, v0);
        if (!0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::is_auth(arg0, arg1)) {
            0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::add_auth(arg0, arg1);
        };
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth::set_authority(arg0, arg1);
        0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::events::emit_log_update_authority(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

