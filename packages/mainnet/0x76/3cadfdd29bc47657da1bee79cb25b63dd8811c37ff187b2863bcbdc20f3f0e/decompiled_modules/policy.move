module 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::policy {
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
        assert!(!arg3 && arg0.phase != 2, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::paused());
        assert!(arg0.phase == 0 || arg0.phase == 1, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::bad_phase());
        if (arg0.phase == 0) {
            assert!(arg1 <= arg0.pilot_deadline_ms, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::pilot_limit());
            assert!(arg0.pilot_actions_used < arg0.pilot_action_limit, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::pilot_limit());
        };
        if (arg2 > 0) {
            assert!(arg1 >= arg2 && arg1 - arg2 >= arg0.min_action_interval_ms, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::cooldown());
        };
    }

    public(friend) fun assert_creation(arg0: &Policy, arg1: u64) {
        assert!(arg0.phase == 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::bad_phase());
        assert!(arg0.pilot_deadline_ms > arg1, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::pilot_limit());
    }

    public(friend) fun assert_exposure(arg0: &Policy, arg1: u64, arg2: u64) {
        assert!(arg2 <= arg0.max_pilot_exposure_b, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!((arg1 as u128) * (arg0.mark_a_in_b_num as u128) <= ((arg0.max_pilot_exposure_b - arg2) as u128) * (arg0.mark_a_in_b_den as u128), 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
    }

    public(friend) fun assert_swap_input(arg0: &Policy, arg1: u8, arg2: u64) {
        let v0 = if (arg1 == 1) {
            arg0.max_swap_input_a
        } else if (arg1 == 2) {
            arg0.max_swap_input_b
        } else {
            0
        };
        assert!(arg2 <= v0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::swap_input_limit());
    }

    public(friend) fun consume_action(arg0: &mut Policy) {
        if (arg0.phase == 0) {
            arg0.pilot_actions_used = arg0.pilot_actions_used + 1;
        };
    }

    public(friend) fun max_active_drift(arg0: &Policy) : u32 {
        arg0.max_active_drift
    }

    public(friend) fun max_bin_bits(arg0: &Policy) : u32 {
        arg0.max_bin_bits
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

    public(friend) fun min_idle_a(arg0: &Policy) : u64 {
        arg0.min_idle_a
    }

    public(friend) fun min_idle_b(arg0: &Policy) : u64 {
        arg0.min_idle_b
    }

    public fun new_pilot(arg0: u64, arg1: u64, arg2: u16, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8) : Policy {
        assert!(arg1 > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::pilot_limit());
        assert!(arg2 >= 2 && arg2 <= 70, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::vector_length());
        assert!(arg7 > 0 && arg7 <= 120000, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::deadline());
        assert!(arg6 <= arg5, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::active_drift());
        assert!(signed_gte(arg4, arg3), 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::bin_range());
        assert!(arg9 > 0 && arg10 > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::amount_limit());
        assert!(arg13 > 0 && arg14 > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!(arg15 > 0 && arg15 <= 1000000000, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!(arg16 > 0 && arg17 > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::swap_input_limit());
        Policy{
            phase                    : 0,
            version                  : 1,
            pilot_deadline_ms        : arg0,
            pilot_action_limit       : arg1,
            pilot_actions_used       : 0,
            max_total_bins           : arg2,
            min_bin_bits             : arg3,
            max_bin_bits             : arg4,
            max_distance_from_active : arg5,
            max_active_drift         : arg6,
            max_plan_ttl_ms          : arg7,
            min_action_interval_ms   : arg8,
            max_deploy_a             : arg9,
            max_deploy_b             : arg10,
            min_idle_a               : arg11,
            min_idle_b               : arg12,
            mark_a_in_b_num          : arg13,
            mark_a_in_b_den          : arg14,
            max_pilot_exposure_b     : arg15,
            max_swap_input_a         : arg16,
            max_swap_input_b         : arg17,
            max_reward_types         : arg18,
            allow_rollover           : true,
            allow_harvest            : true,
            allow_exit_to_idle       : true,
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
        assert!(arg1.mark_a_in_b_num > 0 && arg1.mark_a_in_b_den > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!((arg1.mark_a_in_b_num as u128) * (arg0.mark_a_in_b_den as u128) == (arg0.mark_a_in_b_num as u128) * (arg1.mark_a_in_b_den as u128), 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!(arg1.max_pilot_exposure_b > 0 && arg1.max_pilot_exposure_b <= 1000000000, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::exposure_limit());
        assert!(arg1.max_swap_input_a > 0 && arg1.max_swap_input_b > 0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::swap_input_limit());
        assert!(arg1.max_swap_input_a <= arg0.max_swap_input_a && arg1.max_swap_input_b <= arg0.max_swap_input_b, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::swap_input_limit());
        assert!(arg1.pilot_deadline_ms <= arg0.pilot_deadline_ms && arg1.pilot_action_limit <= arg0.pilot_action_limit, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::pilot_limit());
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
        assert!(v0, 0x763cadfdd29bc47657da1bee79cb25b63dd8811c37ff187b2863bcbdc20f3f0e::errors::bad_phase());
        arg0.phase = arg1;
        arg0.version = arg0.version + 1;
    }

    fun signed_gte(arg0: u32, arg1: u32) : bool {
        let v0 = arg0 >= 2147483648;
        v0 != arg1 >= 2147483648 && !v0 || arg0 >= arg1
    }

    public fun version(arg0: &Policy) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

