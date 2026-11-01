module 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_calcs {
    public fun annualize(arg0: u64, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS) : u64 {
        let v0 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128((arg0 as u128), (0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::constants::seconds_per_year() as u128), (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::raw(arg1) as u128));
        assert!(v0 <= 18446744073709551615, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::max_rate());
        assert!(v0 != 0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        (v0 as u64)
    }

    fun assert_budget(arg0: u64, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS) {
        assert!(arg0 != 0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        assert!(!0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::is_zero(arg1) && 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::le(arg1, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::constants::max_duration_s()), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
    }

    public fun assert_stoppable(arg0: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) {
        assert!(!0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::has_next(&arg0) || 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::le_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::next_end_s(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg1)), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::next_rewards_queued());
    }

    public fun plan_cancel(arg0: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule {
        assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::has_next(&arg0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::no_queued_rewards());
        assert!(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::gt_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg1)), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::must_transition_to_next());
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::new_schedule(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::start_tvl(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::start_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::yearly_reward(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0, arg1)
    }

    public fun plan_queue(arg0: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule, arg1: u64, arg2: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS, arg3: &0x2::clock::Clock) : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule {
        assert_budget(arg1, arg2);
        assert!(!0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::has_next(&arg0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::next_rewards_queued());
        assert!(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::gt_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3)), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::already_stopped());
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::new_schedule(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::start_tvl(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::start_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::yearly_reward(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::add_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), arg2), annualize(arg1, arg2), arg3)
    }

    public fun plan_start(arg0: 0x1::option::Option<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>, arg1: u64, arg2: u64, arg3: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS, arg4: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS, arg5: &0x2::clock::Clock) : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule {
        let v0 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg5);
        assert_budget(arg2, arg3);
        let v1 = if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::is_zero_ts(arg4)) {
            v0
        } else {
            arg4
        };
        assert!(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::ge_ts(v1, v0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::invalid_params());
        if (0x1::option::is_some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(&arg0)) {
            let v2 = 0x1::option::destroy_some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule>(arg0);
            assert!(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::le_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&v2), v0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::not_ended());
            assert!(!0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::has_next(&v2) || 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::le_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::next_end_s(&v2), v0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::must_transition_to_next());
        };
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::new_schedule(arg1, v1, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::add_ts(v1, arg3), annualize(arg2, arg3), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0, arg5)
    }

    public fun plan_transition(arg0: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule, arg1: &0x2::clock::Clock) : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsSchedule {
        assert!(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::has_next(&arg0), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::no_queued_rewards());
        assert!(0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::le_ts(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::end_s(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg1)), 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::errors::not_ended());
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::new_schedule(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::start_tvl(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::next_start_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::next_end_s(&arg0), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::next_yearly_reward(&arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::zero_ts(), 0, arg1)
    }

    // decompiled from Move bytecode v7
}

