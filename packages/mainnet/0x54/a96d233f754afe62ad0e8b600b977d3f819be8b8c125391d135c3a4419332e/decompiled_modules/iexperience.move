module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience {
    struct BlackmailStats has store {
        total_attempt: u64,
        total_resources_looted: u64,
    }

    struct MissionStats has store {
        total_attempt: u64,
        total_resources_gained: u64,
    }

    struct CrackTheSafe has store {
        total_attempt: u64,
        total_success: u64,
    }

    struct FeedPeopleStats has store {
        total_required: u64,
        total_completed: u64,
    }

    struct WeeklyReport has key {
        id: 0x2::object::UID,
        end_time: u64,
    }

    struct XPBonusConfig has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        base_xp: vector<u64>,
        mission: vector<u64>,
        crack_safe: vector<u64>,
        turf_captured: vector<u64>,
        blackmail: vector<u64>,
        gangster_killed: vector<u64>,
        total_feed: u64,
        slash_xp: u64,
    }

    struct Experience has drop, store {
        exp_point: u128,
    }

    public(friend) fun add_to_blackmail_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, BlackmailStats>(&mut arg0.id, 0x1::string::utf8(b"blackmail"));
            v1.total_attempt = v1.total_attempt + arg1;
            v1.total_resources_looted = v1.total_resources_looted + arg2;
        };
    }

    public(friend) fun add_to_crack_safe_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, CrackTheSafe>(&mut arg0.id, 0x1::string::utf8(b"crack_safe"));
            v1.total_attempt = v1.total_attempt + arg1;
            if (arg2) {
                v1.total_success = v1.total_success + arg1;
            };
        };
    }

    public(friend) fun add_to_feed_people_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, FeedPeopleStats>(&mut arg0.id, 0x1::string::utf8(b"feed_people"));
            if (v1.total_required > v1.total_completed) {
                v1.total_completed = v1.total_completed + arg1;
            };
        };
    }

    public(friend) fun add_to_gangster_elimination_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"gangster_killed"));
            *v1 = *v1 + arg1;
        };
    }

    public(friend) fun add_to_mission_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, MissionStats>(&mut arg0.id, 0x1::string::utf8(b"mission"));
            v1.total_attempt = v1.total_attempt + arg1;
            v1.total_resources_gained = v1.total_resources_gained + arg2;
        };
    }

    public(friend) fun can_update_report(arg0: &WeeklyReport, arg1: &0x2::clock::Clock) : bool {
        arg0.end_time - 0x2::clock::timestamp_ms(arg1) < 7 * 24 * 60 * 60 * 1000
    }

    public(friend) fun decrease_xp(arg0: &mut Experience, arg1: u128) {
        if (arg1 >= arg0.exp_point) {
            arg0.exp_point = 0;
        } else {
            arg0.exp_point = arg0.exp_point - arg1;
        };
    }

    public(friend) fun get_exp_point(arg0: &Experience) : u128 {
        arg0.exp_point
    }

    public(friend) fun get_xp(arg0: &XPBonusConfig, arg1: &mut WeeklyReport, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0;
        let v1 = v0;
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.end_time, 0);
        let v2 = is_already_claimed(arg1);
        assert!(!v2, 1);
        let v3 = 0x2::dynamic_field::borrow<0x1::string::String, BlackmailStats>(&arg1.id, 0x1::string::utf8(b"blackmail"));
        if (v3.total_attempt >= *0x1::vector::borrow<u64>(&arg0.blackmail, 0)) {
            v1 = v0 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.blackmail, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v3.total_resources_looted as u128), (*0x1::vector::borrow<u64>(&arg0.blackmail, 2) as u128))));
        };
        let v4 = 0x2::dynamic_field::borrow<0x1::string::String, MissionStats>(&arg1.id, 0x1::string::utf8(b"mission"));
        if (v4.total_attempt >= *0x1::vector::borrow<u64>(&arg0.mission, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.mission, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v4.total_resources_gained as u128), (*0x1::vector::borrow<u64>(&arg0.mission, 2) as u128))));
        };
        let v5 = 0x2::dynamic_field::borrow<0x1::string::String, CrackTheSafe>(&arg1.id, 0x1::string::utf8(b"crack_safe"));
        if (v5.total_success >= *0x1::vector::borrow<u64>(&arg0.crack_safe, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.crack_safe, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v5.total_success as u128), (*0x1::vector::borrow<u64>(&arg0.crack_safe, 2) as u128))));
        };
        let v6 = 0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg1.id, 0x1::string::utf8(b"gangster_killed"));
        if (*v6 >= *0x1::vector::borrow<u64>(&arg0.gangster_killed, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.gangster_killed, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*v6 as u128), (*0x1::vector::borrow<u64>(&arg0.gangster_killed, 2) as u128))));
        };
        let v7 = 0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg1.id, 0x1::string::utf8(b"turf_captured"));
        if (*v7 >= *0x1::vector::borrow<u64>(&arg0.turf_captured, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.turf_captured, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*v7 as u128), (*0x1::vector::borrow<u64>(&arg0.turf_captured, 2) as u128))));
        };
        let v8 = 0x2::dynamic_field::borrow_mut<0x1::string::String, FeedPeopleStats>(&mut arg1.id, 0x1::string::utf8(b"feed_people"));
        if (v8.total_required == v8.total_completed) {
            let v9 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::utils::percentage(v1, (arg0.slash_xp as u128));
            v1 = v1 + v9;
        };
        if (v8.total_required != arg0.total_feed) {
            v8.total_required = arg0.total_feed;
        };
        set_weekly_xp_already_claimed(arg1);
        v1
    }

    public(friend) fun has_week_passed(arg0: &WeeklyReport, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.end_time
    }

    public(friend) fun increase_xp(arg0: &mut Experience, arg1: u128) {
        arg0.exp_point = arg0.exp_point + arg1;
    }

    public(friend) fun init_player_report(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = WeeklyReport{
            id       : 0x2::object::new(arg1),
            end_time : 0x2::clock::timestamp_ms(arg0) + 7 * 24 * 60 * 60 * 1000,
        };
        let v1 = BlackmailStats{
            total_attempt          : 0,
            total_resources_looted : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, BlackmailStats>(&mut v0.id, 0x1::string::utf8(b"blackmail"), v1);
        let v2 = MissionStats{
            total_attempt          : 0,
            total_resources_gained : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, MissionStats>(&mut v0.id, 0x1::string::utf8(b"mission"), v2);
        let v3 = CrackTheSafe{
            total_attempt : 0,
            total_success : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, CrackTheSafe>(&mut v0.id, 0x1::string::utf8(b"crack_safe"), v3);
        let v4 = FeedPeopleStats{
            total_required  : 2,
            total_completed : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, FeedPeopleStats>(&mut v0.id, 0x1::string::utf8(b"feed_people"), v4);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"gangster_killed"), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"turf_captured"), 0);
        0x2::transfer::share_object<WeeklyReport>(v0);
        0x2::object::id<WeeklyReport>(&v0)
    }

    public(friend) fun is_already_claimed(arg0: &mut WeeklyReport) : bool {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"is_claimed"))) {
            *0x2::dynamic_field::borrow<0x1::string::String, bool>(&arg0.id, 0x1::string::utf8(b"is_claimed"))
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, 0x1::string::utf8(b"is_claimed"), false);
            false
        }
    }

    public(friend) fun new_experience() : Experience {
        Experience{exp_point: 0}
    }

    public(friend) fun reset_player_weekly_report(arg0: &mut WeeklyReport, arg1: &0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, BlackmailStats>(&mut arg0.id, 0x1::string::utf8(b"blackmail"));
        v0.total_attempt = 0;
        v0.total_resources_looted = 0;
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, MissionStats>(&mut arg0.id, 0x1::string::utf8(b"mission"));
        v1.total_attempt = 0;
        v1.total_resources_gained = 0;
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, CrackTheSafe>(&mut arg0.id, 0x1::string::utf8(b"crack_safe"));
        v2.total_attempt = 0;
        v2.total_success = 0;
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"gangster_killed")) = 0;
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"turf_captured")) = 0;
        0x2::dynamic_field::borrow_mut<0x1::string::String, FeedPeopleStats>(&mut arg0.id, 0x1::string::utf8(b"feed_people")).total_completed = 0;
        0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::emit_weekly_report_reset_event(arg1, arg2, arg3, arg4);
    }

    public(friend) fun reset_report_and_update_timer(arg0: &mut WeeklyReport, arg1: &0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        if (has_week_passed(arg0, arg5)) {
            if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"is_claimed"))) {
                *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg0.id, 0x1::string::utf8(b"is_claimed")) = false;
            } else {
                0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg0.id, 0x1::string::utf8(b"is_claimed"), false);
            };
            reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4);
            arg0.end_time = 0x2::clock::timestamp_ms(arg5) + 7 * 24 * 60 * 60 * 1000;
        };
    }

    public(friend) fun set_weekly_xp_already_claimed(arg0: &mut WeeklyReport) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg0.id, 0x1::string::utf8(b"is_claimed")) = true;
    }

    public(friend) fun update_report_ts(arg0: &mut WeeklyReport) {
        arg0.end_time = arg0.end_time + 7 * 24 * 60 * 60 * 1000;
    }

    public(friend) fun update_to_current_turf_count_weekly_report(arg0: &mut WeeklyReport, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = is_already_claimed(arg0);
        if (!v0) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"turf_captured"));
            *v1 = *v1 + arg1;
        };
    }

    // decompiled from Move bytecode v6
}

