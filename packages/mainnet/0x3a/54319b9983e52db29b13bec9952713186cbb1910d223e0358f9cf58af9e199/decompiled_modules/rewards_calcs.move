module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_calcs {
    public fun annualize(arg0: u64, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS) : u64 {
        let v0 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128((arg0 as u128), (0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::seconds_per_year() as u128), (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(arg1) as u128));
        assert!(v0 <= 18446744073709551615, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::max_rate());
        assert!(v0 != 0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        (v0 as u64)
    }

    fun assert_budget(arg0: u64, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS) {
        assert!(arg0 != 0, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        assert!(!0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::is_zero(arg1) && 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::le(arg1, 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::max_duration_s()), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
    }

    public fun assert_stoppable(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) {
        assert!(!0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::has_next(&arg0) || 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::le_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_end_s(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::next_rewards_queued());
    }

    public fun plan_cancel(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule {
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::has_next(&arg0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::no_queued_rewards());
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::gt_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::must_transition_to_next());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::new_schedule(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_tvl(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::yearly_reward(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0, arg1)
    }

    public fun plan_queue(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule, arg1: u64, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS, arg3: &0x2::clock::Clock) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule {
        assert_budget(arg1, arg2);
        assert!(!0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::has_next(&arg0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::next_rewards_queued());
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::gt_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::already_stopped());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::new_schedule(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_tvl(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::yearly_reward(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::add_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), arg2), annualize(arg1, arg2), arg3)
    }

    public fun plan_start(arg0: 0x1::option::Option<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>, arg1: u64, arg2: u64, arg3: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS, arg4: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg5: &0x2::clock::Clock) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule {
        let v0 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg5);
        assert_budget(arg2, arg3);
        let v1 = if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::is_zero_ts(arg4)) {
            v0
        } else {
            arg4
        };
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::ge_ts(v1, v0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::invalid_params());
        if (0x1::option::is_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(&arg0)) {
            let v2 = 0x1::option::destroy_some<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule>(arg0);
            assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::le_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&v2), v0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::not_ended());
            assert!(!0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::has_next(&v2) || 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::le_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_end_s(&v2), v0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::must_transition_to_next());
        };
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::new_schedule(arg1, v1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::add_ts(v1, arg3), annualize(arg2, arg3), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0, arg5)
    }

    public fun plan_transition(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsSchedule {
        assert!(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::has_next(&arg0), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::no_queued_rewards());
        assert!(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::le_ts(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::end_s(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg1)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::not_ended());
        0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::new_schedule(0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::start_tvl(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_start_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_end_s(&arg0), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::next_yearly_reward(&arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::zero_ts(), 0, arg1)
    }

    // decompiled from Move bytecode v7
}

