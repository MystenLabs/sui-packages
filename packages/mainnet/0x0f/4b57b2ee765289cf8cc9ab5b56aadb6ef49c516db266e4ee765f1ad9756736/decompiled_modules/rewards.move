module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards {
    struct RateSegment has copy, drop, store {
        rate: u64,
        from_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
        to_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
    }

    struct RewardsSchedule has copy, drop, store {
        start_tvl: u64,
        start_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
        end_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
        yearly_reward: u64,
        next_start_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
        next_end_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
        next_yearly_reward: u64,
    }

    struct RewardsWriterCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        state_id: 0x2::object::ID,
    }

    public fun cap_state_id<T0>(arg0: &RewardsWriterCap<T0>) : 0x2::object::ID {
        arg0.state_id
    }

    public fun end_s(arg0: &RewardsSchedule) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.end_s
    }

    public fun get_rate_segments(arg0: &RewardsSchedule, arg1: u64, arg2: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg3: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) : vector<RateSegment> {
        if (arg1 == 0 || arg1 < arg0.start_tvl) {
            return 0x1::vector::empty<RateSegment>()
        };
        let v0 = 0x1::vector::empty<RateSegment>();
        let v1 = &mut v0;
        push_segment(v1, rate_for(arg0.yearly_reward, arg1, arg0.start_tvl), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::max_ts(arg2, arg0.start_s), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::min_ts(arg3, arg0.end_s));
        let v2 = &mut v0;
        push_segment(v2, rate_for(arg0.next_yearly_reward, arg1, arg0.start_tvl), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::max_ts(arg2, arg0.next_start_s), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::min_ts(arg3, arg0.next_end_s));
        v0
    }

    public fun has_next(arg0: &RewardsSchedule) : bool {
        if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero_ts(arg0.next_start_s)) {
            true
        } else if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero_ts(arg0.next_end_s)) {
            true
        } else {
            arg0.next_yearly_reward != 0
        }
    }

    public fun new_schedule(arg0: u64, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg2: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg3: u64, arg4: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg5: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg6: u64, arg7: &0x2::clock::Clock) : RewardsSchedule {
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg7);
        assert!(arg0 != 0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::invalid_start_tvl());
        assert!(arg3 != 0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::invalid_yearly_reward());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(arg2, arg1), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::invalid_window());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(arg2, v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_in_past());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::elapsed_since(arg2, arg1), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::max_duration_s()), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_too_long());
        assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le_ts(arg1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::add_ts(v0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::max_duration_s())), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_too_long());
        let v1 = if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero_ts(arg4)) {
            true
        } else if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero_ts(arg5)) {
            true
        } else {
            arg6 != 0
        };
        if (v1) {
            assert!(arg6 != 0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::invalid_yearly_reward());
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(arg5, arg4), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::invalid_window());
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(arg5, v0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_in_past());
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::ge_ts(arg4, arg2), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::overlapping_window());
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::elapsed_since(arg4, arg2), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::max_duration_s()), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_too_long());
            assert!(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::le(0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::elapsed_since(arg5, arg4), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::max_duration_s()), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::window_too_long());
        };
        RewardsSchedule{
            start_tvl          : arg0,
            start_s            : arg1,
            end_s              : arg2,
            yearly_reward      : arg3,
            next_start_s       : arg4,
            next_end_s         : arg5,
            next_yearly_reward : arg6,
        }
    }

    public(friend) fun new_writer_cap<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardsWriterCap<T0> {
        RewardsWriterCap<T0>{
            id       : 0x2::object::new(arg1),
            state_id : arg0,
        }
    }

    public fun next_end_s(arg0: &RewardsSchedule) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.next_end_s
    }

    public fun next_start_s(arg0: &RewardsSchedule) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.next_start_s
    }

    public fun next_yearly_reward(arg0: &RewardsSchedule) : u64 {
        arg0.next_yearly_reward
    }

    fun push_segment(arg0: &mut vector<RateSegment>, arg1: u64, arg2: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS, arg3: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) {
        if (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::gt_ts(arg3, arg2) && arg1 > 0) {
            let v0 = RateSegment{
                rate   : arg1,
                from_s : arg2,
                to_s   : arg3,
            };
            0x1::vector::push_back<RateSegment>(arg0, v0);
        };
    }

    fun rate_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 < arg2 || arg1 == 0) {
            return 0
        };
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_calcs::calc_rewards_rate(arg0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::return_percent_precision(), arg1, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::max_rewards_rate())
    }

    public fun segment_from(arg0: &RateSegment) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.from_s
    }

    public fun segment_rate(arg0: &RateSegment) : u64 {
        arg0.rate
    }

    public fun segment_to(arg0: &RateSegment) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.to_s
    }

    public fun start_s(arg0: &RewardsSchedule) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.start_s
    }

    public fun start_tvl(arg0: &RewardsSchedule) : u64 {
        arg0.start_tvl
    }

    public fun yearly_reward(arg0: &RewardsSchedule) : u64 {
        arg0.yearly_reward
    }

    // decompiled from Move bytecode v7
}

