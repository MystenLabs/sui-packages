module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::admin {
    public fun cancel_queued_rewards<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg3: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg4: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg7);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs::plan_cancel(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::require_schedule<T0>(arg4, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::no_queued_rewards()), arg6)), arg6);
    }

    public fun create_manager<T0>(arg0: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg3: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_auth(arg0, arg1, arg4);
        let v0 = 0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>>(arg2);
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::cap_state_id<T0>(&arg3) == v0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        let v1 = 0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsWriterCap<T0>>(&arg3);
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::rewards_writer<T0>(arg2) == 0x1::option::some<0x2::object::ID>(v1), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        let v2 = 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::new<T0>(arg3, v0, arg4);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::share<T0>(v2);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_create_manager(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>>(&v2), v0, v1);
    }

    public fun disable_timelock(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap, arg2: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_authority_direct(arg0, arg2);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::disable_timelock(arg0, arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_timelock_disabled(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap>(&arg1));
    }

    public fun migrate(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_migrator(arg0, arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::migrate(arg0);
    }

    public fun mint_timelock_cap(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: &mut 0x2::tx_context::TxContext) : 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_authority_direct(arg0, arg1);
        let v0 = 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::enable_timelock(arg0, arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_timelock_enabled(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun queue_next_rewards<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg3: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg4: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg9);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs::plan_queue(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::require_schedule<T0>(arg4, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::no_rewards_started()), arg6, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_seconds(arg7), arg8)), arg8);
    }

    public fun start_rewards<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg3: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg4: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg11);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs::plan_start(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::rewards_schedule<T0>(arg4), arg6, arg7, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_seconds(arg8), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::timestamp_from_seconds(arg9), arg10)), arg10);
    }

    public fun stop_rewards<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg3: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg4: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg5: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::assert_auth<T0>(arg3, arg1, arg4, arg2, arg7);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs::assert_stoppable(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::require_schedule<T0>(arg4, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::already_stopped()), arg6);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::write<T0>(arg3, arg0, arg4, arg5, 0x1::option::none<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(), arg6);
    }

    public fun transition_to_next_rewards<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg3: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg4: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg5: &0x2::clock::Clock) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg1);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::assert_bound<T0>(arg2, arg3);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::write<T0>(arg2, arg0, arg3, arg4, 0x1::option::some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs::plan_transition(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils::require_schedule<T0>(arg3, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::no_queued_rewards()), arg5)), arg5);
    }

    public fun update_auth(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        if (arg3) {
            assert!(!0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::is_auth(arg0, arg2), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::auth_already_assigned());
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::add_auth(arg0, arg2);
        } else {
            assert!(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::is_auth(arg0, arg2), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::auth_not_assigned());
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::remove_auth(arg0, arg2);
        };
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_update_auth(arg2, arg3);
    }

    public fun update_authority(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        if (arg3) {
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::add_authority(arg0, arg2);
        } else {
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::remove_authority(arg0, arg2);
            if (0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::has_auth_record(arg0, arg2)) {
                0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::remove_auth(arg0, arg2);
            };
        };
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_update_authority(arg2, arg3);
    }

    public fun update_migrator(arg0: &mut 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_version(arg0);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_authority(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        if (arg3) {
            assert!(!0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::has_migrator_record(arg0, arg2), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::auth_already_assigned());
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::add_migrator(arg0, arg2);
        } else {
            assert!(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::has_migrator_record(arg0, arg2), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::auth_not_assigned());
            0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::remove_migrator(arg0, arg2);
        };
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events::emit_log_update_migrator(arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

