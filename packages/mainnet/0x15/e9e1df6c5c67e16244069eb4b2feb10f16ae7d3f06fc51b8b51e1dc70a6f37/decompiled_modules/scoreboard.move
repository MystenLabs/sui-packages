module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard {
    struct Scoreboard has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        scores: 0x2::table::Table<address, ScoreInfo>,
        linear_paused: bool,
        linear_pause_started_at: u64,
        linear_paused_ms: u64,
    }

    struct ScoreboardCreated has copy, drop {
        scoreboard_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
    }

    struct PolicyScoringClosed has copy, drop {
        scoreboard_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
        cutoff_ms: u64,
        paused_ms_at_cutoff: u64,
    }

    struct LinearStreamUpdated has copy, drop {
        scoreboard_id: 0x2::object::ID,
        project_object_id: 0x2::object::ID,
        owner: address,
        origin: address,
        source_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
        score_per_duration: u64,
        duration: u64,
        policies: vector<PolicyDependency>,
        updated_at: u64,
    }

    struct ScoreInfo has store {
        score: u64,
        updated_at: u64,
        score_per_duration: u64,
        duration: u64,
        linear_paused_ms_at_update: u64,
        score_debt: u64,
        linear_groups: vector<LinearRateGroup>,
    }

    struct PolicyDependency has copy, drop, store {
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        generation: u64,
    }

    struct PolicyCutoffKey has copy, drop, store {
        project_object_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        generation: u64,
    }

    struct PolicyCutoff has store {
        cutoff_ms: u64,
        paused_ms_at_cutoff: u64,
    }

    struct LinearRateGroup has copy, drop, store {
        project_object_id: 0x2::object::ID,
        policies: vector<PolicyDependency>,
        score_per_duration: u64,
        duration: u64,
        updated_at: u64,
        linear_paused_ms_at_update: u64,
        remainder: u64,
    }

    struct LinearScoreRemainder has store {
        numerator: u64,
    }

    struct LinearScoreRemainderKey has copy, drop, store {
        pos0: address,
    }

    struct LinearStreamKey has copy, drop, store {
        owner: address,
        origin: address,
        source_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
    }

    struct LinearStream has store {
        score_per_duration: u64,
        duration: u64,
        project_object_id: 0x2::object::ID,
        policies: vector<PolicyDependency>,
    }

    fun add_group_rate(arg0: &mut vector<LinearRateGroup>, arg1: 0x2::object::ID, arg2: vector<PolicyDependency>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LinearRateGroup>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<LinearRateGroup>(arg0, v0);
            let v2 = if (v1.project_object_id == arg1) {
                if (policies_equal(&v1.policies, &arg2)) {
                    v1.duration == arg4
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                v1.score_per_duration = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v1.score_per_duration, arg3);
                v1.updated_at = arg5;
                v1.linear_paused_ms_at_update = arg6;
                return
            };
            v0 = v0 + 1;
        };
        let v3 = LinearRateGroup{
            project_object_id          : arg1,
            policies                   : arg2,
            score_per_duration         : arg3,
            duration                   : arg4,
            updated_at                 : arg5,
            linear_paused_ms_at_update : arg6,
            remainder                  : 0,
        };
        0x1::vector::push_back<LinearRateGroup>(arg0, v3);
    }

    public(friend) fun add_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: address) {
        assert_scoring_enabled(arg0);
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = get_mut_scoreboard_score(arg0);
        if (!0x2::table::contains<address, ScoreInfo>(v1, arg3)) {
            0x2::table::add<address, ScoreInfo>(&mut arg0.scores, arg3, new_score_info(arg1, 0, 0, arg2));
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_added(v0, arg3, arg1, 0, arg1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, ScoreInfo>(v1, arg3);
            let v3 = v2.score;
            let v4 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v3, arg1);
            v2.score = v4;
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_added(v0, arg3, arg1, v3, v4);
        };
    }

    fun assert_scoring_enabled(arg0: &Scoreboard) {
        assert!(!arg0.linear_paused, 6);
    }

    public(friend) fun calculate_convert(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = get_unconverted_score_by_address(arg0, arg1, arg2);
        assert!(v0 > 0, 2);
        let v1 = get_mut_score_by_address(arg0, arg2);
        let v2 = v1.score_debt;
        let v3 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v2, v0);
        v1.score_debt = v3;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_debt_updated(0x2::object::id<Scoreboard>(arg0), arg2, v0, v2, v3, 2);
        v0
    }

    public(friend) fun calculate_convert_amount(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) : u64 {
        assert!(arg3 > 0 && arg3 <= get_unconverted_score_by_address(arg0, arg1, arg2), 2);
        let v0 = get_mut_score_by_address(arg0, arg2);
        let v1 = v0.score_debt;
        let v2 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v1, arg3);
        v0.score_debt = v2;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_debt_updated(0x2::object::id<Scoreboard>(arg0), arg2, arg3, v1, v2, 2);
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
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(arg0.score, 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::linear_accrued(arg0.score_per_duration, arg1 - arg0.updated_at, arg0.duration))
    }

    fun calculate_current_score_at_with_pause_and_remainder(arg0: &ScoreInfo, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg0.duration > 0, 1);
        if (arg1 <= arg0.updated_at || arg0.score_per_duration == 0) {
            return (arg0.score, arg3)
        };
        let v0 = arg1 - arg0.updated_at;
        let v1 = if (arg2 > arg0.linear_paused_ms_at_update) {
            arg2 - arg0.linear_paused_ms_at_update
        } else {
            0
        };
        if (v1 >= v0) {
            return (arg0.score, arg3)
        };
        let v2 = (arg0.score_per_duration as u256) * ((v0 - v1) as u256) + (arg3 as u256);
        let v3 = (arg0.duration as u256);
        (0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(arg0.score, 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_floor_to_u64(v2, v3)), ((v2 % v3) as u64))
    }

    public fun create_shared_scoreboard(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::scoreboard_domain());
        0x2::transfer::public_share_object<Scoreboard>(new_scoreboard(arg1, arg2));
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

    public fun get_project_cap_ID(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap) : 0x2::object::ID {
        0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(arg0)
    }

    public fun get_scoreboard_project_ID(arg0: &Scoreboard) : &0x2::object::ID {
        &arg0.project_id
    }

    public fun get_total_score_by_address(arg0: &Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = &arg0.scores;
        if (!0x2::table::contains<address, ScoreInfo>(v0, arg2)) {
            0
        } else {
            preview_score_with_groups(arg0, 0x2::table::borrow<address, ScoreInfo>(v0, arg2), arg2, 0x2::clock::timestamp_ms(arg1))
        }
    }

    public fun get_unconverted_score_by_address(arg0: &Scoreboard, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        let v0 = &arg0.scores;
        if (!0x2::table::contains<address, ScoreInfo>(v0, arg2)) {
            0
        } else {
            let v2 = 0x2::table::borrow<address, ScoreInfo>(v0, arg2);
            let v3 = preview_score_with_groups(arg0, v2, arg2, 0x2::clock::timestamp_ms(arg1));
            if (v3 <= v2.score_debt) {
                0
            } else {
                v3 - v2.score_debt
            }
        }
    }

    fun group_accrual(arg0: &LinearRateGroup, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 <= arg0.updated_at || arg0.score_per_duration == 0) {
            return (0, arg0.remainder)
        };
        let v0 = arg1 - arg0.updated_at;
        let v1 = if (arg2 > arg0.linear_paused_ms_at_update) {
            arg2 - arg0.linear_paused_ms_at_update
        } else {
            0
        };
        if (v1 >= v0) {
            return (0, arg0.remainder)
        };
        let v2 = (arg0.score_per_duration as u256) * ((v0 - v1) as u256) + (arg0.remainder as u256);
        let v3 = (arg0.duration as u256);
        (0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_floor_to_u64(v2, v3), ((v2 % v3) as u64))
    }

    fun group_effective_checkpoint(arg0: &Scoreboard, arg1: &LinearRateGroup, arg2: u64) : (u64, u64, bool) {
        policy_checkpoint_at(arg0, arg1.project_object_id, &arg1.policies, arg2)
    }

    fun group_is_active(arg0: &vector<LinearRateGroup>, arg1: 0x2::object::ID, arg2: &vector<PolicyDependency>, arg3: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LinearRateGroup>(arg0)) {
            let v1 = 0x1::vector::borrow<LinearRateGroup>(arg0, v0);
            let v2 = if (v1.project_object_id == arg1) {
                if (policies_equal(&v1.policies, arg2)) {
                    v1.duration == arg3
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v1.score_per_duration > 0
            };
            v0 = v0 + 1;
        };
        false
    }

    fun linear_rate_summary(arg0: &vector<LinearRateGroup>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<LinearRateGroup>(arg0)) {
            let v2 = 0x1::vector::borrow<LinearRateGroup>(arg0, v1);
            if (v2.score_per_duration > 0) {
                if (v0 != 0 && v0 != v2.duration) {
                    return (0, 1)
                };
                v0 = v2.duration;
            };
            v1 = v1 + 1;
        };
        let v3 = 0;
        v1 = 0;
        while (v1 < 0x1::vector::length<LinearRateGroup>(arg0)) {
            v3 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v3, 0x1::vector::borrow<LinearRateGroup>(arg0, v1).score_per_duration);
            v1 = v1 + 1;
        };
        let v4 = if (v0 == 0) {
            1
        } else {
            v0
        };
        (v3, v4)
    }

    fun linear_score_remainder(arg0: &Scoreboard, arg1: address) : u64 {
        let v0 = LinearScoreRemainderKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<LinearScoreRemainderKey>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<LinearScoreRemainderKey, LinearScoreRemainder>(&arg0.id, v0).numerator
        }
    }

    fun materialize_linear_groups(arg0: &mut Scoreboard, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow<address, ScoreInfo>(&arg0.scores, arg1);
        let v1 = v0.linear_groups;
        if (0x1::vector::is_empty<LinearRateGroup>(&v1)) {
            let v2 = current_linear_paused_ms(arg0, arg2);
            let (v3, v4) = calculate_current_score_at_with_pause_and_remainder(0x2::table::borrow<address, ScoreInfo>(&arg0.scores, arg1), arg2, v2, linear_score_remainder(arg0, arg1));
            let v5 = 0x2::table::borrow_mut<address, ScoreInfo>(&mut arg0.scores, arg1);
            v5.score = v3;
            v5.updated_at = arg2;
            v5.linear_paused_ms_at_update = v2;
            set_linear_score_remainder(arg0, arg1, v4);
            return
        };
        let v6 = v0.score;
        let v7 = 0;
        while (v7 < 0x1::vector::length<LinearRateGroup>(&v1)) {
            let v8 = 0x1::vector::borrow_mut<LinearRateGroup>(&mut v1, v7);
            let (v9, v10, v11) = group_effective_checkpoint(arg0, v8, arg2);
            let (v12, v13) = group_accrual(v8, v9, v10);
            v6 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v6, v12);
            v8.updated_at = v9;
            v8.linear_paused_ms_at_update = v10;
            v8.remainder = v13;
            if (v11) {
                v8.score_per_duration = 0;
            };
            v7 = v7 + 1;
        };
        let (v14, v15) = linear_rate_summary(&v1);
        let v16 = 0x2::table::borrow_mut<address, ScoreInfo>(&mut arg0.scores, arg1);
        v16.score = v6;
        v16.score_per_duration = v14;
        if (v15 > 0) {
            v16.duration = v15;
        };
        v16.updated_at = arg2;
        v16.linear_paused_ms_at_update = current_linear_paused_ms(arg0, arg2);
        v16.linear_groups = v1;
    }

    public(friend) fun new_policy_dependency(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID, arg2: u64) : PolicyDependency {
        PolicyDependency{
            policy          : arg0,
            policy_state_id : arg1,
            generation      : arg2,
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
            linear_groups              : 0x1::vector::empty<LinearRateGroup>(),
        }
    }

    public(friend) fun new_scoreboard(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : Scoreboard {
        let v0 = Scoreboard{
            id                      : 0x2::object::new(arg1),
            project_id              : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap>(arg0),
            scores                  : 0x2::table::new<address, ScoreInfo>(arg1),
            linear_paused           : false,
            linear_pause_started_at : 0,
            linear_paused_ms        : 0,
        };
        let v1 = ScoreboardCreated{
            scoreboard_id : 0x2::object::id<Scoreboard>(&v0),
            project_id    : v0.project_id,
        };
        0x2::event::emit<ScoreboardCreated>(v1);
        v0
    }

    public fun paused(arg0: &Scoreboard) : bool {
        arg0.linear_paused
    }

    fun policies_equal(arg0: &vector<PolicyDependency>, arg1: &vector<PolicyDependency>) : bool {
        if (0x1::vector::length<PolicyDependency>(arg0) != 0x1::vector::length<PolicyDependency>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyDependency>(arg0)) {
            let v1 = *0x1::vector::borrow<PolicyDependency>(arg0, v0);
            let v2 = *0x1::vector::borrow<PolicyDependency>(arg1, v0);
            let v3 = if (v1.policy != v2.policy) {
                true
            } else if (v1.policy_state_id != v2.policy_state_id) {
                true
            } else {
                v1.generation != v2.generation
            };
            if (v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun policy_checkpoint(arg0: &Scoreboard, arg1: 0x2::object::ID, arg2: &vector<PolicyDependency>, arg3: &0x2::clock::Clock) : (u64, u64, bool) {
        policy_checkpoint_at(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3))
    }

    fun policy_checkpoint_at(arg0: &Scoreboard, arg1: 0x2::object::ID, arg2: &vector<PolicyDependency>, arg3: u64) : (u64, u64, bool) {
        let v0 = arg3;
        let v1 = current_linear_paused_ms(arg0, arg3);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<PolicyDependency>(arg2)) {
            let v4 = *0x1::vector::borrow<PolicyDependency>(arg2, v3);
            let v5 = PolicyCutoffKey{
                project_object_id : arg1,
                policy            : v4.policy,
                policy_state_id   : v4.policy_state_id,
                generation        : v4.generation,
            };
            if (0x2::dynamic_field::exists<PolicyCutoffKey>(&arg0.id, v5)) {
                let v6 = 0x2::dynamic_field::borrow<PolicyCutoffKey, PolicyCutoff>(&arg0.id, v5);
                if (!v2 || v6.cutoff_ms < v0) {
                    v0 = v6.cutoff_ms;
                    v1 = v6.paused_ms_at_cutoff;
                    v2 = true;
                };
            };
            v3 = v3 + 1;
        };
        (v0, v1, v2)
    }

    fun preview_score_with_groups(arg0: &Scoreboard, arg1: &ScoreInfo, arg2: address, arg3: u64) : u64 {
        if (0x1::vector::is_empty<LinearRateGroup>(&arg1.linear_groups)) {
            let (v0, _) = calculate_current_score_at_with_pause_and_remainder(arg1, arg3, current_linear_paused_ms(arg0, arg3), linear_score_remainder(arg0, arg2));
            return v0
        };
        let v2 = arg1.score;
        let v3 = 0;
        while (v3 < 0x1::vector::length<LinearRateGroup>(&arg1.linear_groups)) {
            let v4 = 0x1::vector::borrow<LinearRateGroup>(&arg1.linear_groups, v3);
            let (v5, v6, _) = group_effective_checkpoint(arg0, v4, arg3);
            let (v8, _) = group_accrual(v4, v5, v6);
            v2 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v2, v8);
            v3 = v3 + 1;
        };
        v2
    }

    public(friend) fun record_policy_cutoff(arg0: &mut Scoreboard, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = current_linear_paused_ms(arg0, v0);
        let v2 = PolicyCutoffKey{
            project_object_id : arg1,
            policy            : arg2,
            policy_state_id   : arg3,
            generation        : arg4,
        };
        if (!0x2::dynamic_field::exists<PolicyCutoffKey>(&arg0.id, v2)) {
            let v3 = PolicyCutoff{
                cutoff_ms           : v0,
                paused_ms_at_cutoff : v1,
            };
            0x2::dynamic_field::add<PolicyCutoffKey, PolicyCutoff>(&mut arg0.id, v2, v3);
            let v4 = PolicyScoringClosed{
                scoreboard_id           : 0x2::object::id<Scoreboard>(arg0),
                project_object_id       : arg1,
                policy                  : arg2,
                policy_state_id         : arg3,
                registration_generation : arg4,
                cutoff_ms               : v0,
                paused_ms_at_cutoff     : v1,
            };
            0x2::event::emit<PolicyScoringClosed>(v4);
        };
    }

    public(friend) fun restore_tokenized_score(arg0: &mut Scoreboard, arg1: &0x2::clock::Clock, arg2: address, arg3: u64) {
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (!0x2::table::contains<address, ScoreInfo>(&arg0.scores, arg2)) {
            let v2 = new_score_info(0, v1, 0, 1);
            v2.linear_paused_ms_at_update = current_linear_paused_ms(arg0, v1);
            0x2::table::add<address, ScoreInfo>(&mut arg0.scores, arg2, v2);
        };
        materialize_linear_groups(arg0, arg2, v1);
        let v3 = 0x2::table::borrow_mut<address, ScoreInfo>(&mut arg0.scores, arg2);
        let v4 = v3.score_debt;
        if (v4 >= arg3) {
            v3.score_debt = v4 - arg3;
        } else {
            v3.score_debt = 0;
            v3.score = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v3.score, arg3 - v4);
        };
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_debt_updated(v0, arg2, arg3, v4, v3.score_debt, 3);
    }

    fun set_linear_score_remainder(arg0: &mut Scoreboard, arg1: address, arg2: u64) {
        let v0 = LinearScoreRemainderKey{pos0: arg1};
        if (0x2::dynamic_field::exists<LinearScoreRemainderKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow_mut<LinearScoreRemainderKey, LinearScoreRemainder>(&mut arg0.id, v0).numerator = arg2;
        } else {
            let v1 = LinearScoreRemainder{numerator: arg2};
            0x2::dynamic_field::add<LinearScoreRemainderKey, LinearScoreRemainder>(&mut arg0.id, v0, v1);
        };
    }

    public(friend) fun set_linear_stream(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<PolicyDependency>) {
        write_linear_stream(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, false);
    }

    public(friend) fun set_linear_time_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        set_linear_stream(arg0, arg1, arg2, arg3, arg4, arg4, v0, v0, v0, 0x1::vector::empty<PolicyDependency>());
    }

    public(friend) fun set_paused(arg0: &mut Scoreboard, arg1: bool, arg2: &0x2::clock::Clock) {
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
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_scoreboard_pause_updated(0x2::object::id<Scoreboard>(arg0), arg0.project_id, arg1, v0);
    }

    public(friend) fun sub_score(arg0: &mut Scoreboard, arg1: u64, arg2: address) {
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = get_mut_scoreboard_score(arg0);
        assert!(0x2::table::contains<address, ScoreInfo>(v1, arg2), 0);
        let v2 = 0x2::table::borrow_mut<address, ScoreInfo>(v1, arg2);
        let v3 = v2.score_debt;
        let v4 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v3, arg1);
        v2.score_debt = v4;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_score_debt_updated(v0, arg2, arg1, v3, v4, 1);
    }

    fun subtract_group_rate(arg0: &mut vector<LinearRateGroup>, arg1: 0x2::object::ID, arg2: &vector<PolicyDependency>, arg3: u64, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LinearRateGroup>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<LinearRateGroup>(arg0, v0);
            let v2 = if (v1.project_object_id == arg1) {
                if (policies_equal(&v1.policies, arg2)) {
                    v1.duration == arg3
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                assert!(v1.score_per_duration >= arg4, 5);
                v1.score_per_duration = v1.score_per_duration - arg4;
                return
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    public(friend) fun update_linear_stream(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<PolicyDependency>) {
        write_linear_stream(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true);
    }

    public(friend) fun update_linear_time_score(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        update_linear_stream(arg0, arg1, arg2, arg3, arg4, arg4, v0, v0, v0, 0x1::vector::empty<PolicyDependency>());
    }

    fun write_linear_stream(arg0: &mut Scoreboard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<PolicyDependency>, arg10: bool) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<Scoreboard>(arg0);
        let v1 = LinearStreamKey{
            owner      : arg4,
            origin     : arg5,
            source_id  : arg6,
            subject_id : arg7,
        };
        let v2 = 0x2::dynamic_field::exists<LinearStreamKey>(&arg0.id, v1);
        assert!(!arg10 || v2, 3);
        let (v3, v4, v5, v6) = if (v2) {
            let v7 = 0x2::dynamic_field::borrow<LinearStreamKey, LinearStream>(&arg0.id, v1);
            (v7.score_per_duration, v7.duration, v7.project_object_id, v7.policies)
        } else {
            (0, arg2, arg8, 0x1::vector::empty<PolicyDependency>())
        };
        let v8 = v6;
        let v9 = 0x2::clock::timestamp_ms(arg3);
        let v10 = current_linear_paused_ms(arg0, v9);
        if (!0x2::table::contains<address, ScoreInfo>(&arg0.scores, arg4)) {
            let v11 = new_score_info(0, v9, 0, arg2);
            v11.linear_paused_ms_at_update = v10;
            0x2::table::add<address, ScoreInfo>(&mut arg0.scores, arg4, v11);
        };
        materialize_linear_groups(arg0, arg4, v9);
        let v12 = 0x2::table::borrow_mut<address, ScoreInfo>(&mut arg0.scores, arg4);
        let v13 = v12.score;
        let v14 = if (v2 && group_is_active(&v12.linear_groups, v5, &v8, v4)) {
            v3
        } else {
            0
        };
        if (v14 > 0) {
            let v15 = &mut v12.linear_groups;
            subtract_group_rate(v15, v5, &v8, v4, v14);
        };
        let v16 = &mut v12.linear_groups;
        add_group_rate(v16, arg8, arg9, arg1, arg2, v9, v10);
        let (v17, v18) = linear_rate_summary(&v12.linear_groups);
        v12.score_per_duration = v17;
        v12.duration = v18;
        v12.updated_at = v9;
        v12.linear_paused_ms_at_update = v10;
        if (v2) {
            let v19 = 0x2::dynamic_field::borrow_mut<LinearStreamKey, LinearStream>(&mut arg0.id, v1);
            v19.score_per_duration = arg1;
            v19.duration = arg2;
            v19.project_object_id = arg8;
            v19.policies = arg9;
        } else {
            let v20 = LinearStream{
                score_per_duration : arg1,
                duration           : arg2,
                project_object_id  : arg8,
                policies           : arg9,
            };
            0x2::dynamic_field::add<LinearStreamKey, LinearStream>(&mut arg0.id, v1, v20);
        };
        let v21 = LinearStreamUpdated{
            scoreboard_id      : v0,
            project_object_id  : arg8,
            owner              : arg4,
            origin             : arg5,
            source_id          : arg6,
            subject_id         : arg7,
            score_per_duration : arg1,
            duration           : arg2,
            policies           : arg9,
            updated_at         : v9,
        };
        0x2::event::emit<LinearStreamUpdated>(v21);
        if (arg10) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_linear_time_score_updated(v0, arg4, v13, v13, v12.score_per_duration, v17, v12.duration, 0x2::table::borrow<address, ScoreInfo>(&arg0.scores, arg4).duration, v12.updated_at, v9);
        } else {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_linear_time_score_set(v0, arg4, v13, v13, v12.score_per_duration, v17, v12.duration, 0x2::table::borrow<address, ScoreInfo>(&arg0.scores, arg4).duration, v12.updated_at, v9);
        };
    }

    // decompiled from Move bytecode v7
}

