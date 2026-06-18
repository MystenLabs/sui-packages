module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard {
    struct Scoreboard has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        scores: 0x2::table::Table<address, ScoreInfo>,
        linear_paused: bool,
        linear_pause_started_at: u64,
        linear_paused_ms: u64,
    }

    struct ScoreInfo has store {
        score: u64,
        updated_at: u64,
        score_per_duration: u64,
        duration: u64,
        linear_paused_ms_at_update: u64,
        score_debt: u64,
    }

    public(friend) fun add_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: address) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = get_mut_scoreboard_score(arg0);
        if (!0x2::table::contains<address, ScoreInfo>(v1, arg3)) {
            0x2::table::add<address, ScoreInfo>(v1, arg3, new_score_info(arg1, 0, 0, arg2));
            0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_added(v0, arg3, arg1, 0, arg1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, ScoreInfo>(v1, arg3);
            let v3 = v2.score;
            let v4 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(v3, arg1);
            v2.score = v4;
            0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_added(v0, arg3, arg1, v3, v4);
        };
    }

    public(friend) fun calculate_convert(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = get_unconverted_score_by_address(arg0, arg1, arg2);
        assert!(v0 > 0, 2);
        let v1 = get_mut_score_by_address(arg0, arg2);
        let v2 = v1.score_debt;
        let v3 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(v2, v0);
        v1.score_debt = v3;
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_debt_updated(0x2::object::id<Scoreboard>(arg0), arg2, v0, v2, v3, 2);
        v0
    }

    public(friend) fun calculate_convert_amount(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) : u64 {
        assert!(arg3 > 0 && arg3 <= get_unconverted_score_by_address(arg0, arg1, arg2), 2);
        let v0 = get_mut_score_by_address(arg0, arg2);
        let v1 = v0.score_debt;
        let v2 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(v1, arg3);
        v0.score_debt = v2;
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_debt_updated(0x2::object::id<Scoreboard>(arg0), arg2, arg3, v1, v2, 2);
        arg3
    }

    public(friend) fun calculate_current_score(arg0: &ScoreInfo, arg1: &0x2::clock::Clock) : u64 {
        calculate_current_score_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun calculate_current_score_at(arg0: &ScoreInfo, arg1: u64) : u64 {
        assert!(arg0.duration > 0, 1);
        if (arg1 <= arg0.updated_at || arg0.score_per_duration == 0) {
            return arg0.score
        };
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(arg0.score, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::linear_accrued(arg0.score_per_duration, arg1 - arg0.updated_at, arg0.duration))
    }

    fun calculate_current_score_at_with_pause(arg0: &ScoreInfo, arg1: u64, arg2: u64) : u64 {
        assert!(arg0.duration > 0, 1);
        if (arg1 <= arg0.updated_at || arg0.score_per_duration == 0) {
            return arg0.score
        };
        let v0 = arg1 - arg0.updated_at;
        let v1 = if (arg2 > arg0.linear_paused_ms_at_update) {
            arg2 - arg0.linear_paused_ms_at_update
        } else {
            0
        };
        if (v1 >= v0) {
            return arg0.score
        };
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(arg0.score, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::linear_accrued(arg0.score_per_duration, v0 - v1, arg0.duration))
    }

    public fun create_shared_scoreboard(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::scoreboard_domain());
        let v0 = Scoreboard{
            id                      : 0x2::object::new(arg2),
            project_id              : 0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(arg1),
            scores                  : 0x2::table::new<address, ScoreInfo>(arg2),
            linear_paused           : false,
            linear_pause_started_at : 0,
            linear_paused_ms        : 0,
        };
        0x2::transfer::public_share_object<Scoreboard>(v0);
    }

    fun current_linear_paused_ms(arg0: &Scoreboard, arg1: u64) : u64 {
        if (!arg0.linear_paused || arg1 <= arg0.linear_pause_started_at) {
            arg0.linear_paused_ms
        } else {
            arg0.linear_paused_ms + arg1 - arg0.linear_pause_started_at
        }
    }

    fun get_mut_score_by_address(arg0: &mut Scoreboard, arg1: address) : &mut ScoreInfo {
        let v0 = &mut arg0.scores;
        assert!(0x2::table::contains<address, ScoreInfo>(v0, arg1), 0);
        0x2::table::borrow_mut<address, ScoreInfo>(v0, arg1)
    }

    public(friend) fun get_mut_scoreboard_score(arg0: &mut Scoreboard) : &mut 0x2::table::Table<address, ScoreInfo> {
        &mut arg0.scores
    }

    public fun get_project_cap_ID(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap) : 0x2::object::ID {
        0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(arg0)
    }

    public fun get_scoreboard_project_ID(arg0: &Scoreboard) : &0x2::object::ID {
        &arg0.project_id
    }

    public fun get_total_score_by_address(arg0: &Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = &arg0.scores;
        if (!0x2::table::contains<address, ScoreInfo>(v0, arg2)) {
            0
        } else {
            calculate_current_score_at_with_pause(0x2::table::borrow<address, ScoreInfo>(v0, arg2), 0x2::clock::timestamp_ms(arg1), current_linear_paused_ms(arg0, 0x2::clock::timestamp_ms(arg1)))
        }
    }

    public fun get_unconverted_score_by_address(arg0: &Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = &arg0.scores;
        if (!0x2::table::contains<address, ScoreInfo>(v0, arg2)) {
            0
        } else {
            let v2 = 0x2::table::borrow<address, ScoreInfo>(v0, arg2);
            let v3 = calculate_current_score_at_with_pause(v2, 0x2::clock::timestamp_ms(arg1), current_linear_paused_ms(arg0, 0x2::clock::timestamp_ms(arg1)));
            if (v3 <= v2.score_debt) {
                0
            } else {
                v3 - v2.score_debt
            }
        }
    }

    public fun new_score_info(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : ScoreInfo {
        ScoreInfo{
            score                      : arg0,
            updated_at                 : arg1,
            score_per_duration         : arg2,
            duration                   : arg3,
            linear_paused_ms_at_update : 0,
            score_debt                 : 0,
        }
    }

    public(friend) fun new_scoreboard(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : Scoreboard {
        Scoreboard{
            id                      : 0x2::object::new(arg1),
            project_id              : 0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(arg0),
            scores                  : 0x2::table::new<address, ScoreInfo>(arg1),
            linear_paused           : false,
            linear_pause_started_at : 0,
            linear_paused_ms        : 0,
        }
    }

    public(friend) fun restore_tokenized_score(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) {
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = current_linear_paused_ms(arg0, v1);
        let v3 = get_mut_scoreboard_score(arg0);
        assert!(0x2::table::contains<address, ScoreInfo>(v3, arg2), 0);
        let v4 = 0x2::table::borrow_mut<address, ScoreInfo>(v3, arg2);
        v4.score = calculate_current_score_at_with_pause(v4, v1, v2);
        v4.updated_at = v1;
        v4.linear_paused_ms_at_update = v2;
        let v5 = v4.score_debt;
        if (v5 >= arg3) {
            v4.score_debt = v5 - arg3;
        } else {
            v4.score_debt = 0;
            v4.score = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(v4.score, arg3 - v5);
        };
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_debt_updated(v0, arg2, arg3, v5, v4.score_debt, 3);
    }

    public(friend) fun set_linear_time_paused(arg0: &mut Scoreboard, arg1: bool, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.linear_paused == arg1) {
            return
        };
        if (arg1) {
            arg0.linear_paused = true;
            arg0.linear_pause_started_at = v0;
        } else {
            if (v0 > arg0.linear_pause_started_at) {
                arg0.linear_paused_ms = arg0.linear_paused_ms + v0 - arg0.linear_pause_started_at;
            };
            arg0.linear_paused = false;
            arg0.linear_pause_started_at = 0;
        };
    }

    public(friend) fun set_linear_time_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = current_linear_paused_ms(arg0, v1);
        let v3 = get_mut_scoreboard_score(arg0);
        if (!0x2::table::contains<address, ScoreInfo>(v3, arg4)) {
            let v4 = new_score_info(0, v1, arg1, arg2);
            v4.linear_paused_ms_at_update = v2;
            0x2::table::add<address, ScoreInfo>(v3, arg4, v4);
            0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_linear_time_score_set(v0, arg4, 0, 0, 0, arg1, 0, arg2, 0, v1);
        } else {
            let v5 = 0x2::table::borrow_mut<address, ScoreInfo>(v3, arg4);
            let v6 = calculate_current_score_at_with_pause(v5, v1, v2);
            v5.score = v6;
            v5.score_per_duration = arg1;
            v5.duration = arg2;
            v5.updated_at = v1;
            v5.linear_paused_ms_at_update = v2;
            0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_linear_time_score_set(v0, arg4, v5.score, v6, v5.score_per_duration, arg1, v5.duration, arg2, v5.updated_at, v1);
        };
    }

    public(friend) fun sub_score(arg0: &mut Scoreboard, arg1: u64, arg2: address) {
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = get_mut_scoreboard_score(arg0);
        assert!(0x2::table::contains<address, ScoreInfo>(v1, arg2), 0);
        let v2 = 0x2::table::borrow_mut<address, ScoreInfo>(v1, arg2);
        let v3 = v2.score_debt;
        let v4 = 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_math::checked_add(v3, arg1);
        v2.score_debt = v4;
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_score_debt_updated(v0, arg2, arg1, v3, v4, 1);
    }

    public(friend) fun update_linear_time_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = current_linear_paused_ms(arg0, v1);
        let v3 = get_mut_scoreboard_score(arg0);
        assert!(0x2::table::contains<address, ScoreInfo>(v3, arg4), 0);
        let v4 = 0x2::table::borrow_mut<address, ScoreInfo>(v3, arg4);
        let v5 = calculate_current_score_at_with_pause(v4, v1, v2);
        v4.score = v5;
        v4.score_per_duration = arg1;
        v4.duration = arg2;
        v4.updated_at = v1;
        v4.linear_paused_ms_at_update = v2;
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_linear_time_score_updated(v0, arg4, v4.score, v5, v4.score_per_duration, arg1, v4.duration, arg2, v4.updated_at, v1);
    }

    // decompiled from Move bytecode v7
}

