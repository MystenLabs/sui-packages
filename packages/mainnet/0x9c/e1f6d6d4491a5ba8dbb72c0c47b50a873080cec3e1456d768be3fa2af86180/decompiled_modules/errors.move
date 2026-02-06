module 0x9ce1f6d6d4491a5ba8dbb72c0c47b50a873080cec3e1456d768be3fa2af86180::errors {
    public fun agent_has_children() : u64 {
        205
    }

    public fun agent_not_active() : u64 {
        200
    }

    public fun agent_not_found() : u64 {
        207
    }

    public fun agent_suspended() : u64 {
        202
    }

    public fun agent_terminated() : u64 {
        201
    }

    public fun already_completed() : u64 {
        6
    }

    public fun budget_exhausted() : u64 {
        403
    }

    public fun capability_already_granted() : u64 {
        305
    }

    public fun capability_constraint_violated() : u64 {
        304
    }

    public fun capability_expired() : u64 {
        303
    }

    public fun capability_not_delegatable() : u64 {
        300
    }

    public fun capability_not_found() : u64 {
        301
    }

    public fun empty_vector() : u64 {
        8
    }

    public fun genome_not_found() : u64 {
        104
    }

    public fun hook_execution_failed() : u64 {
        405
    }

    public fun idle_timeout() : u64 {
        401
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_amount() : u64 {
        2
    }

    public fun invalid_capability_type() : u64 {
        302
    }

    public fun invalid_generation() : u64 {
        206
    }

    public fun invalid_genome_config() : u64 {
        105
    }

    public fun invalid_inheritance_rate() : u64 {
        103
    }

    public fun invalid_lifecycle_hook() : u64 {
        404
    }

    public fun invalid_status() : u64 {
        7
    }

    public fun invalid_timestamp() : u64 {
        4
    }

    public fun length_mismatch() : u64 {
        9
    }

    public fun lifespan_exceeded() : u64 {
        400
    }

    public fun max_children_reached() : u64 {
        101
    }

    public fun not_ancestor() : u64 {
        204
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun not_found() : u64 {
        5
    }

    public fun not_owner() : u64 {
        0
    }

    public fun not_parent() : u64 {
        203
    }

    public fun spawn_cooldown_active() : u64 {
        102
    }

    public fun spawn_depth_exceeded() : u64 {
        100
    }

    public fun termination_condition_not_met() : u64 {
        402
    }

    // decompiled from Move bytecode v6
}

