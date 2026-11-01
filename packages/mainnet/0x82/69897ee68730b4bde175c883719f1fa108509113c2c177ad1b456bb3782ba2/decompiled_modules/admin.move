module 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin {
    public fun cancel_queued_rewards<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg7);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs::plan_cancel(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::require_schedule<T0>(arg4, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::no_queued_rewards()), arg6)), arg6);
    }

    public fun create_manager<T0>(arg0: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg3: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_auth(arg0, arg1, arg4);
        let v0 = 0x2::object::id<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>>(arg2);
        assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::cap_state_id<T0>(&arg3) == v0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        let v1 = 0x2::object::id<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>>(&arg3);
        assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::rewards_writer<T0>(arg2) == 0x1::option::some<0x2::object::ID>(v1), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        let v2 = 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::new<T0>(arg3, v0, arg4);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::share<T0>(v2);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_create_manager(0x2::object::id<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>>(&v2), v0, v1);
    }

    public fun disable_timelock(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap, arg2: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_authority_direct(arg0, arg2);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::disable_timelock(arg0, arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_timelock_disabled(0x2::object::id<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(&arg1));
    }

    public fun migrate(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_migrator(arg0, arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::migrate(arg0);
    }

    public fun mint_timelock_cap(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: &mut 0x2::tx_context::TxContext) : 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_authority_direct(arg0, arg1);
        let v0 = 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::enable_timelock(arg0, arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_timelock_enabled(0x2::object::id<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun queue_next_rewards<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg9);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs::plan_queue(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::require_schedule<T0>(arg4, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::no_rewards_started()), arg6, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_seconds(arg7), arg8)), arg8);
    }

    public fun start_rewards<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg11);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs::plan_start(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::rewards_schedule<T0>(arg4), arg6, arg7, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_seconds(arg8), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::timestamp_from_seconds(arg9), arg10)), arg10);
    }

    public fun stop_rewards<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg7);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs::assert_stoppable(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::require_schedule<T0>(arg4, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::already_stopped()), arg6);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::none<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(), arg6);
    }

    public fun transition_to_next_rewards<T0>(arg0: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg2: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg3: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg4: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0x2::clock::Clock) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg1);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::assert_bound<T0>(arg2, arg3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs::plan_transition(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::utils::require_schedule<T0>(arg3, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::no_queued_rewards()), arg5)), arg5);
    }

    public fun update_auth(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        if (arg3) {
            assert!(!0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::is_auth(arg0, arg2), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::auth_already_assigned());
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::add_auth(arg0, arg2);
        } else {
            assert!(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::has_auth_record(arg0, arg2), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::auth_not_assigned());
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::remove_auth(arg0, arg2);
        };
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_update_auth(arg2, arg3);
    }

    public fun update_authority(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        if (arg3) {
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::add_authority(arg0, arg2);
        } else {
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::remove_authority(arg0, arg2);
            if (0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::has_auth_record(arg0, arg2)) {
                0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::remove_auth(arg0, arg2);
            };
        };
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_update_authority(arg2, arg3);
    }

    public fun update_migrator(arg0: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_version(arg0);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        if (arg3) {
            assert!(!0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::has_migrator_record(arg0, arg2), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::auth_already_assigned());
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::add_migrator(arg0, arg2);
        } else {
            assert!(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::has_migrator_record(arg0, arg2), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::auth_not_assigned());
            0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::remove_migrator(arg0, arg2);
        };
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::events::emit_log_update_migrator(arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

