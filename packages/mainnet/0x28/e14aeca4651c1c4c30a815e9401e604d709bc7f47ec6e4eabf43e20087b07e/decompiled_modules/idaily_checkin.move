module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::idaily_checkin {
    struct SevenDaysCheckInRewardsRegistry has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        max_missed_days: u64,
        cost_per_missed_days: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        day_rewards: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
    }

    struct DailyCheckInStreak has key {
        id: 0x2::object::UID,
        streak_count: u64,
        longest_streak: u64,
        last_checked_ts: u64,
        week_ends_in: u64,
        seven_days_rewards_claimed_day: vector<0x1::string::String>,
    }

    public fun borrow_dailystreak_count(arg0: &DailyCheckInStreak) : u64 {
        arg0.streak_count
    }

    public fun borrow_dailystreak_last_checkedin_ts(arg0: &DailyCheckInStreak) : u64 {
        arg0.last_checked_ts
    }

    public fun borrow_dailystreak_seven_day_claim(arg0: &DailyCheckInStreak) : vector<0x1::string::String> {
        arg0.seven_days_rewards_claimed_day
    }

    public fun borrow_dailystreak_week_exp_ts(arg0: &DailyCheckInStreak) : u64 {
        arg0.week_ends_in
    }

    public(friend) fun concat_in_seven_days_reward_claim_status(arg0: &mut DailyCheckInStreak, arg1: vector<0x1::string::String>) {
        0x1::vector::append<0x1::string::String>(&mut arg0.seven_days_rewards_claimed_day, arg1);
    }

    public fun get_7days_checkin_rewards(arg0: &SevenDaysCheckInRewardsRegistry) : 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>> {
        arg0.day_rewards
    }

    public fun get_7days_checkin_start_end_time(arg0: &SevenDaysCheckInRewardsRegistry) : (u64, u64) {
        (arg0.start_time, arg0.end_time)
    }

    public fun get_7days_max_missed_and_cost(arg0: &SevenDaysCheckInRewardsRegistry) : (u64, &0x2::vec_map::VecMap<0x1::string::String, u64>) {
        (arg0.max_missed_days, &arg0.cost_per_missed_days)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SevenDaysCheckInRewardsRegistry{
            id                   : 0x2::object::new(arg0),
            start_time           : 0,
            end_time             : 0,
            max_missed_days      : 0,
            cost_per_missed_days : 0x2::vec_map::empty<0x1::string::String, u64>(),
            day_rewards          : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(),
        };
        0x2::transfer::share_object<SevenDaysCheckInRewardsRegistry>(v0);
    }

    public(friend) fun insert_in_seven_days_reward_claim_status(arg0: &mut DailyCheckInStreak, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.seven_days_rewards_claimed_day, arg1);
    }

    public(friend) fun new_check_in_streak(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = DailyCheckInStreak{
            id                             : 0x2::object::new(arg0),
            streak_count                   : 0,
            longest_streak                 : 0,
            last_checked_ts                : 0,
            week_ends_in                   : 0,
            seven_days_rewards_claimed_day : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<DailyCheckInStreak>(v0);
        0x2::object::id<DailyCheckInStreak>(&v0)
    }

    public(friend) fun reset_seven_days_reward_claim_status(arg0: &mut DailyCheckInStreak) {
        arg0.seven_days_rewards_claimed_day = 0x1::vector::empty<0x1::string::String>();
    }

    public(friend) fun set_7days_late_signin_cost_config(arg0: &mut SevenDaysCheckInRewardsRegistry, arg1: u64, arg2: 0x1::string::String, arg3: u64) {
        arg0.max_missed_days = arg1;
        arg0.cost_per_missed_days = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.cost_per_missed_days, arg2, arg3);
    }

    public(friend) fun set_7days_rewards_config(arg0: &mut SevenDaysCheckInRewardsRegistry, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>) {
        arg0.day_rewards = arg1;
    }

    public(friend) fun set_7days_start_time(arg0: &mut SevenDaysCheckInRewardsRegistry, arg1: u64) {
        arg0.start_time = arg1;
        arg0.end_time = arg1 + 604800000;
    }

    public(friend) fun set_dailystreak_count(arg0: &mut DailyCheckInStreak, arg1: u64) {
        arg0.streak_count = arg1;
    }

    public(friend) fun set_dailystreak_last_checkedin_ts(arg0: &mut DailyCheckInStreak, arg1: u64) {
        arg0.last_checked_ts = arg1;
    }

    public(friend) fun set_dailystreak_week_exp_ts(arg0: &mut DailyCheckInStreak, arg1: u64) {
        arg0.week_ends_in = arg1;
    }

    // decompiled from Move bytecode v6
}

