module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_calcs {
    public fun annualize(arg0: u64, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS) : u64 {
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((arg0 as u128), (0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::seconds_per_year() as u128), (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(arg1) as u128));
        assert!(v0 <= 18446744073709551615, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::max_rate());
        assert!(v0 != 0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        (v0 as u64)
    }

    fun assert_budget(arg0: u64, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS) {
        assert!(arg0 != 0, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        assert!(!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero(arg1) && 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le(arg1, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::max_duration_s()), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
    }

    public fun assert_stoppable(arg0: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) {
        assert!(!0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::has_next(&arg0) || 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_end_s(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::next_rewards_queued());
    }

    public fun plan_cancel(arg0: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::has_next(&arg0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::no_queued_rewards());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::must_transition_to_next());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::new_schedule(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_tvl(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::yearly_reward(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0, arg1)
    }

    public fun plan_queue(arg0: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule, arg1: u64, arg2: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS, arg3: &0x2::clock::Clock) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        assert_budget(arg1, arg2);
        assert!(!0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::has_next(&arg0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::next_rewards_queued());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg3)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::already_stopped());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::new_schedule(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_tvl(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::yearly_reward(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::add_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), arg2), annualize(arg1, arg2), arg3)
    }

    public fun plan_start(arg0: 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>, arg1: u64, arg2: u64, arg3: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS, arg4: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg5: &0x2::clock::Clock) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg5);
        assert_budget(arg2, arg3);
        let v1 = if (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero_ts(arg4)) {
            v0
        } else {
            arg4
        };
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::ge_ts(v1, v0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::invalid_params());
        if (0x1::option::is_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&arg0)) {
            let v2 = 0x1::option::destroy_some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(arg0);
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&v2), v0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::not_ended());
            assert!(!0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::has_next(&v2) || 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_end_s(&v2), v0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::must_transition_to_next());
        };
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::new_schedule(arg1, v1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::add_ts(v1, arg3), annualize(arg2, arg3), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0, arg5)
    }

    public fun plan_transition(arg0: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        assert!(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::has_next(&arg0), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::no_queued_rewards());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le_ts(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::end_s(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::not_ended());
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::new_schedule(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::start_tvl(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_start_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_end_s(&arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::next_yearly_reward(&arg0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::zero_ts(), 0, arg1)
    }

    // decompiled from Move bytecode v7
}

