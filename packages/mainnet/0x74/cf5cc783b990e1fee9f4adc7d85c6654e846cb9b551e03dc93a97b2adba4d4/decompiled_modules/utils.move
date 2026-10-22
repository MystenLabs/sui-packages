module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::utils {
    public(friend) fun assert_auth<T0>(arg0: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::RewardsAuth, arg2: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg3: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg4: &0x2::tx_context::TxContext) {
        assert_bound<T0>(arg0, arg2);
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth::assert_auth(arg1, arg3, arg4);
    }

    public(friend) fun assert_bound<T0>(arg0: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>) {
        assert!(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::state_id<T0>(arg0) == 0x2::object::id<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>>(arg1), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
    }

    public(friend) fun require_schedule<T0>(arg0: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg1: u64) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        let v0 = 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::rewards_schedule<T0>(arg0);
        assert!(0x1::option::is_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&v0), arg1);
        0x1::option::destroy_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(v0)
    }

    public(friend) fun write<T0>(arg0: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::RewardsManager<T0>, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg2: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state::LendingState<T0>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>, arg5: &0x2::clock::Clock) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::admin::set_rewards_schedule<T0>(arg1, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_manager::borrow_cap<T0>(arg0), arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

