module 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy {
    struct Policy has copy, drop, store {
        phase: u8,
        version: u64,
        pilot_deadline_ms: u64,
        pilot_action_limit: u64,
        pilot_actions_used: u64,
        max_total_bins: u16,
        min_bin_bits: u32,
        max_bin_bits: u32,
        max_distance_from_active: u32,
        max_active_drift: u32,
        max_plan_ttl_ms: u64,
        min_action_interval_ms: u64,
        max_deploy_a: u64,
        max_deploy_b: u64,
        min_idle_a: u64,
        min_idle_b: u64,
        mark_a_in_b_num: u64,
        mark_a_in_b_den: u64,
        max_pilot_exposure_b: u64,
        max_swap_input_a: u64,
        max_swap_input_b: u64,
        max_reward_types: u8,
        allow_rollover: bool,
        allow_harvest: bool,
        allow_exit_to_idle: bool,
        income_mode: u8,
        income_cooldown_ms: u64,
        min_harvest_a: u64,
        min_harvest_b: u64,
        target_equity_b: u64,
        max_compound_a_per_action: u64,
        max_compound_b_per_action: u64,
    }

    public(friend) fun allow_exit_to_idle(arg0: &Policy) : bool {
        arg0.allow_exit_to_idle
    }

    public(friend) fun allow_harvest(arg0: &Policy) : bool {
        arg0.allow_harvest
    }

    public(friend) fun allow_rollover(arg0: &Policy) : bool {
        arg0.allow_rollover
    }

    public(friend) fun assert_action(arg0: &Policy, arg1: u64, arg2: u64, arg3: bool) {
        assert!(!arg3 && arg0.phase != 2, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::paused());
        assert!(arg0.phase == 0 || arg0.phase == 1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        if (arg0.phase == 0) {
            assert!(arg1 <= arg0.pilot_deadline_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pilot_limit());
            assert!(arg0.pilot_actions_used < arg0.pilot_action_limit, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pilot_limit());
        };
        if (arg2 > 0) {
            assert!(arg1 >= arg2 && arg1 - arg2 >= arg0.min_action_interval_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::cooldown());
        };
    }

    public(friend) fun assert_creation(arg0: &Policy, arg1: u64) {
        assert!(arg0.phase == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        assert!(arg0.pilot_deadline_ms > arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pilot_limit());
    }

    public(friend) fun assert_income_action(arg0: &Policy, arg1: u64, arg2: u64) {
        if (arg2 > 0) {
            assert!(arg1 >= arg2 && arg1 - arg2 >= arg0.income_cooldown_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::cooldown());
        };
    }

    fun assert_income_policy(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        assert!(arg1 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exposure_limit());
        assert!(arg2 > 0 && arg3 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_limit());
    }

    public(friend) fun assert_swap_input(arg0: &Policy, arg1: u8, arg2: u64) {
        assert!(arg0.max_swap_input_a == 0 && arg0.max_swap_input_b == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::swap_input_limit());
        assert!(arg1 == 0 && arg2 == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::swap_input_limit());
    }

    public fun compound_mode() : u8 {
        0
    }

    public(friend) fun consume_action(arg0: &mut Policy) {
        if (arg0.phase == 0) {
            arg0.pilot_actions_used = arg0.pilot_actions_used + 1;
        };
    }

    public fun harvest_mode() : u8 {
        1
    }

    public fun income_mode(arg0: &Policy) : u8 {
        arg0.income_mode
    }

    public(friend) fun mark_a_in_b_den(arg0: &Policy) : u64 {
        arg0.mark_a_in_b_den
    }

    public(friend) fun mark_a_in_b_num(arg0: &Policy) : u64 {
        arg0.mark_a_in_b_num
    }

    public(friend) fun max_active_drift(arg0: &Policy) : u32 {
        arg0.max_active_drift
    }

    public(friend) fun max_bin_bits(arg0: &Policy) : u32 {
        arg0.max_bin_bits
    }

    public(friend) fun max_compound_a_per_action(arg0: &Policy) : u64 {
        arg0.max_compound_a_per_action
    }

    public(friend) fun max_compound_b_per_action(arg0: &Policy) : u64 {
        arg0.max_compound_b_per_action
    }

    public(friend) fun max_deploy_a(arg0: &Policy) : u64 {
        arg0.max_deploy_a
    }

    public(friend) fun max_deploy_b(arg0: &Policy) : u64 {
        arg0.max_deploy_b
    }

    public(friend) fun max_distance_from_active(arg0: &Policy) : u32 {
        arg0.max_distance_from_active
    }

    public(friend) fun max_pilot_exposure_b(arg0: &Policy) : u64 {
        arg0.max_pilot_exposure_b
    }

    public(friend) fun max_plan_ttl_ms(arg0: &Policy) : u64 {
        arg0.max_plan_ttl_ms
    }

    public(friend) fun max_reward_types(arg0: &Policy) : u8 {
        arg0.max_reward_types
    }

    public(friend) fun max_swap_input_a(arg0: &Policy) : u64 {
        arg0.max_swap_input_a
    }

    public(friend) fun max_swap_input_b(arg0: &Policy) : u64 {
        arg0.max_swap_input_b
    }

    public(friend) fun max_total_bins(arg0: &Policy) : u16 {
        arg0.max_total_bins
    }

    public(friend) fun min_bin_bits(arg0: &Policy) : u32 {
        arg0.min_bin_bits
    }

    public(friend) fun min_harvest_a(arg0: &Policy) : u64 {
        arg0.min_harvest_a
    }

    public(friend) fun min_harvest_b(arg0: &Policy) : u64 {
        arg0.min_harvest_b
    }

    public(friend) fun min_idle_a(arg0: &Policy) : u64 {
        arg0.min_idle_a
    }

    public(friend) fun min_idle_b(arg0: &Policy) : u64 {
        arg0.min_idle_b
    }

    public fun new_pilot(arg0: u64, arg1: u64, arg2: u16, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8) : Policy {
        new_pilot_with_income_policy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 0, 0, 0, 0, arg15, arg9, arg10)
    }

    public fun new_pilot_with_income_policy(arg0: u64, arg1: u64, arg2: u16, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: u8, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64) : Policy {
        assert!(arg1 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pilot_limit());
        assert!(arg2 >= 2 && arg2 <= 70, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::vector_length());
        assert!(arg7 > 0 && arg7 <= 120000, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        assert!(arg6 <= arg5, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        assert!(signed_gte(arg4, arg3), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bin_range());
        assert!(arg9 > 0 && arg10 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_limit());
        let v0 = if (arg13 > 0) {
            if (arg14 > 0) {
                arg15 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exposure_limit());
        assert!(arg16 == 0 && arg17 == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::swap_input_limit());
        assert_income_policy(arg19, arg23, arg24, arg25);
        Policy{
            phase                     : 0,
            version                   : 1,
            pilot_deadline_ms         : arg0,
            pilot_action_limit        : arg1,
            pilot_actions_used        : 0,
            max_total_bins            : arg2,
            min_bin_bits              : arg3,
            max_bin_bits              : arg4,
            max_distance_from_active  : arg5,
            max_active_drift          : arg6,
            max_plan_ttl_ms           : arg7,
            min_action_interval_ms    : arg8,
            max_deploy_a              : arg9,
            max_deploy_b              : arg10,
            min_idle_a                : arg11,
            min_idle_b                : arg12,
            mark_a_in_b_num           : arg13,
            mark_a_in_b_den           : arg14,
            max_pilot_exposure_b      : arg15,
            max_swap_input_a          : arg16,
            max_swap_input_b          : arg17,
            max_reward_types          : arg18,
            allow_rollover            : true,
            allow_harvest             : true,
            allow_exit_to_idle        : true,
            income_mode               : arg19,
            income_cooldown_ms        : arg20,
            min_harvest_a             : arg21,
            min_harvest_b             : arg22,
            target_equity_b           : arg23,
            max_compound_a_per_action : arg24,
            max_compound_b_per_action : arg25,
        }
    }

    public fun paused_phase() : u8 {
        2
    }

    public fun phase(arg0: &Policy) : u8 {
        arg0.phase
    }

    public fun pilot_actions_used(arg0: &Policy) : u64 {
        arg0.pilot_actions_used
    }

    public fun pilot_phase() : u8 {
        0
    }

    public fun production_phase() : u8 {
        1
    }

    public(friend) fun replace(arg0: &mut Policy, arg1: Policy) {
        let v0 = if (arg1.mark_a_in_b_num > 0) {
            if (arg1.mark_a_in_b_den > 0) {
                arg1.max_pilot_exposure_b > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exposure_limit());
        assert!(arg1.max_swap_input_a == 0 && arg1.max_swap_input_b == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::swap_input_limit());
        assert!(arg0.max_swap_input_a == 0 && arg0.max_swap_input_b == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::swap_input_limit());
        assert!(arg1.pilot_deadline_ms <= arg0.pilot_deadline_ms && arg1.pilot_action_limit <= arg0.pilot_action_limit, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pilot_limit());
        assert!(arg1.target_equity_b >= arg0.target_equity_b, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exposure_limit());
        assert_income_policy(arg1.income_mode, arg1.target_equity_b, arg1.max_compound_a_per_action, arg1.max_compound_b_per_action);
        *arg0 = arg1;
        arg0.version = arg0.version + 1;
        arg0.pilot_actions_used = arg0.pilot_actions_used;
        arg0.phase = arg0.phase;
    }

    public(friend) fun set_phase(arg0: &mut Policy, arg1: u8) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        arg0.phase = arg1;
        arg0.version = arg0.version + 1;
    }

    fun signed_gte(arg0: u32, arg1: u32) : bool {
        let v0 = arg0 >= 2147483648;
        v0 != arg1 >= 2147483648 && !v0 || arg0 >= arg1
    }

    public(friend) fun target_equity_b(arg0: &Policy) : u64 {
        arg0.target_equity_b
    }

    public fun target_equity_mode() : u8 {
        2
    }

    public fun version(arg0: &Policy) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

