module 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::iexperience {
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

    public(friend) fun add_to_blackmail_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, BlackmailStats>(&mut arg0.id, 0x1::string::utf8(b"blackmail"));
        v0.total_attempt = v0.total_attempt + arg5;
        v0.total_resources_looted = v0.total_resources_looted + arg6;
    }

    public(friend) fun add_to_crack_safe_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, CrackTheSafe>(&mut arg0.id, 0x1::string::utf8(b"crack_safe"));
        v0.total_attempt = v0.total_attempt + arg5;
        if (arg6) {
            v0.total_success = v0.total_success + arg5;
        };
    }

    public(friend) fun add_to_feed_people_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg6);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, FeedPeopleStats>(&mut arg0.id, 0x1::string::utf8(b"feed_people"));
        if (v0.total_required > v0.total_completed) {
            v0.total_completed = v0.total_completed + arg5;
        };
    }

    public(friend) fun add_to_gangster_elimination_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg6);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"gangster_killed"));
        *v0 = *v0 + arg5;
    }

    public(friend) fun add_to_mission_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, MissionStats>(&mut arg0.id, 0x1::string::utf8(b"mission"));
        v0.total_attempt = v0.total_attempt + arg5;
        v0.total_resources_gained = v0.total_resources_gained + arg6;
    }

    public(friend) fun borrow_week_end_ts(arg0: &mut XPBonusConfig) : u64 {
        arg0.end_time
    }

    public(friend) fun decrease_xp(arg0: &mut Experience, arg1: u128) {
        arg0.exp_point = arg0.exp_point - arg1;
    }

    public(friend) fun get_exp_point(arg0: &Experience) : u128 {
        arg0.exp_point
    }

    public(friend) fun get_xp(arg0: &XPBonusConfig, arg1: &mut WeeklyReport, arg2: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) : u128 {
        let v0 = 0;
        let v1 = v0;
        reset_player_weekly_report(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::dynamic_field::borrow<0x1::string::String, BlackmailStats>(&arg1.id, 0x1::string::utf8(b"blackmail"));
        if (v2.total_attempt > *0x1::vector::borrow<u64>(&arg0.blackmail, 0)) {
            v1 = v0 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.blackmail, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v2.total_resources_looted as u128), (v2.total_attempt as u128))), (*0x1::vector::borrow<u64>(&arg0.blackmail, 2) as u128))));
        };
        let v3 = 0x2::dynamic_field::borrow<0x1::string::String, MissionStats>(&arg1.id, 0x1::string::utf8(b"mission"));
        if (v3.total_attempt > *0x1::vector::borrow<u64>(&arg0.mission, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.mission, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v3.total_resources_gained as u128), (v3.total_attempt as u128))), (*0x1::vector::borrow<u64>(&arg0.mission, 2) as u128))));
        };
        let v4 = 0x2::dynamic_field::borrow<0x1::string::String, CrackTheSafe>(&arg1.id, 0x1::string::utf8(b"crack_safe"));
        if (v4.total_success > *0x1::vector::borrow<u64>(&arg0.crack_safe, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.crack_safe, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((v4.total_success as u128), (*0x1::vector::borrow<u64>(&arg0.crack_safe, 2) as u128))));
        };
        let v5 = 0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg1.id, 0x1::string::utf8(b"gangster_killed"));
        if (*v5 > *0x1::vector::borrow<u64>(&arg0.gangster_killed, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.gangster_killed, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*v5 as u128), (*0x1::vector::borrow<u64>(&arg0.gangster_killed, 2) as u128))));
        };
        if (*0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg1.id, 0x1::string::utf8(b"turf_captured")) > *0x1::vector::borrow<u64>(&arg0.turf_captured, 0)) {
            v1 = v1 + 0x1::u128::min((*0x1::vector::borrow<u64>(&arg0.turf_captured, 1) as u128) * 0x1::u128::pow(2, 64), 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient((*v5 as u128), (*0x1::vector::borrow<u64>(&arg0.turf_captured, 2) as u128))));
        };
        let v6 = 0x2::dynamic_field::borrow<0x1::string::String, FeedPeopleStats>(&arg1.id, 0x1::string::utf8(b"feed_people"));
        if (v6.total_required != v6.total_completed) {
            v1 = 0xb6573f8d4411fd47c3fbac41344765d7d421f162c35aea4d49b7f6207d33ec17::utils::percentage(v1, (arg0.slash_xp as u128));
        };
        v1
    }

    public(friend) fun increase_xp(arg0: &mut Experience, arg1: u128) {
        arg0.exp_point = arg0.exp_point + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XPBonusConfig{
            id              : 0x2::object::new(arg0),
            start_time      : 0,
            end_time        : 0,
            base_xp         : 0x1::vector::empty<u64>(),
            mission         : 0x1::vector::empty<u64>(),
            crack_safe      : 0x1::vector::empty<u64>(),
            turf_captured   : 0x1::vector::empty<u64>(),
            blackmail       : 0x1::vector::empty<u64>(),
            gangster_killed : 0x1::vector::empty<u64>(),
            total_feed      : 2,
            slash_xp        : 20,
        };
        0x2::transfer::share_object<XPBonusConfig>(v0);
    }

    public(friend) fun init_player_report(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = WeeklyReport{
            id       : 0x2::object::new(arg1),
            end_time : 0x2::clock::timestamp_ms(arg0) + 7 * 86400000,
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

    public(friend) fun new_experience() : Experience {
        Experience{exp_point: 0}
    }

    public(friend) fun reset_player_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        if (reset_report_ts(arg0, arg5)) {
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
            0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::emit_weekly_report_reset_event(arg1, arg2, arg3, arg4);
        };
    }

    public(friend) fun reset_report_ts(arg0: &mut WeeklyReport, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.end_time) {
            arg0.end_time = v0 + 7 * 86400000;
            true
        } else {
            false
        }
    }

    public(friend) fun set_bonus_xp_config(arg0: &mut XPBonusConfig, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: u64) {
        arg0.start_time = arg1;
        arg0.end_time = arg1 + 7 * 86400000;
        0x1::vector::append<u64>(&mut arg0.base_xp, arg2);
        0x1::vector::append<u64>(&mut arg0.mission, arg3);
        0x1::vector::append<u64>(&mut arg0.crack_safe, arg4);
        0x1::vector::append<u64>(&mut arg0.blackmail, arg5);
        0x1::vector::append<u64>(&mut arg0.turf_captured, arg7);
        0x1::vector::append<u64>(&mut arg0.gangster_killed, arg6);
        arg0.total_feed = arg8;
        arg0.slash_xp = arg9;
    }

    public(friend) fun update_report_ts(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        arg0.end_time = 0x2::clock::timestamp_ms(arg5) + 7 * 86400000;
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_to_current_turf_count_weekly_report(arg0: &mut WeeklyReport, arg1: &0x57c4f34e9f2dfd372fb40326ef82d0a768344e2f2b4e33c062592ff3ad52c6c6::game_events::EventCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock) {
        reset_player_weekly_report(arg0, arg1, arg2, arg3, arg4, arg7);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"turf_captured"));
        if (arg6) {
            *v0 = *v0 + arg5;
        } else if (arg5 > *v0) {
            *v0 = *v0 + arg5;
        } else {
            *v0 = 0;
        };
    }

    // decompiled from Move bytecode v6
}

