module 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy {
    struct Policy has copy, drop, store {
        phase: u8,
        version: u64,
        pilot_deadline_ms: u64,
        pilot_action_limit: u64,
        pilot_actions_used: u64,
        max_bins: u16,
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
        max_reward_types: u8,
        allow_rebalance: bool,
        allow_harvest: bool,
        allow_exit_to_idle: bool,
    }

    public(friend) fun allow_exit_to_idle(arg0: &Policy) : bool {
        arg0.allow_exit_to_idle
    }

    public(friend) fun allow_harvest(arg0: &Policy) : bool {
        arg0.allow_harvest
    }

    public(friend) fun allow_rebalance(arg0: &Policy) : bool {
        arg0.allow_rebalance
    }

    public(friend) fun assert_action(arg0: &Policy, arg1: u64, arg2: u64, arg3: bool) {
        assert!(!arg3 && arg0.phase != 2, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::paused());
        assert!(arg0.phase == 0 || arg0.phase == 1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
        if (arg0.phase == 0) {
            assert!(arg1 <= arg0.pilot_deadline_ms, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::pilot_limit());
            assert!(arg0.pilot_actions_used < arg0.pilot_action_limit, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::pilot_limit());
        };
        if (arg2 > 0) {
            assert!(arg1 >= arg2 && arg1 - arg2 >= arg0.min_action_interval_ms, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::cooldown());
        };
    }

    public(friend) fun assert_creation(arg0: &Policy, arg1: u64) {
        assert!(arg0.phase == 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
        assert!(arg0.pilot_deadline_ms > arg1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::pilot_limit());
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

    public(friend) fun max_bins(arg0: &Policy) : u16 {
        arg0.max_bins
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

    public(friend) fun min_bin_bits(arg0: &Policy) : u32 {
        arg0.min_bin_bits
    }

    public(friend) fun min_idle_a(arg0: &Policy) : u64 {
        arg0.min_idle_a
    }

    public(friend) fun min_idle_b(arg0: &Policy) : u64 {
        arg0.min_idle_b
    }

    public fun new_pilot(arg0: u64, arg1: u64, arg2: u16, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u8) : Policy {
        assert!(arg1 > 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::pilot_limit());
        assert!(arg2 > 0 && arg2 <= 70, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::vector_length());
        assert!(arg7 > 0 && arg7 <= 120000, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::deadline());
        assert!(arg6 <= arg5, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::active_drift());
        assert!(signed_gte(arg4, arg3), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bin_range());
        assert!(arg9 > 0 || arg10 > 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::amount_limit());
        Policy{
            phase                    : 0,
            version                  : 1,
            pilot_deadline_ms        : arg0,
            pilot_action_limit       : arg1,
            pilot_actions_used       : 0,
            max_bins                 : arg2,
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
            max_reward_types         : arg13,
            allow_rebalance          : true,
            allow_harvest            : true,
            allow_exit_to_idle       : true,
        }
    }

    public fun paused_phase() : u8 {
        2
    }

    public(friend) fun phase(arg0: &Policy) : u8 {
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
        *arg0 = arg1;
        arg0.version = arg0.version + 1;
    }

    public(friend) fun set_phase(arg0: &mut Policy, arg1: u8) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else {
            arg1 == 2
        };
        assert!(v0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
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

