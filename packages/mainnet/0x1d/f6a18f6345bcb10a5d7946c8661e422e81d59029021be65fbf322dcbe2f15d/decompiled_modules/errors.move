module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors {
    public fun e_action_mismatch() : u64 {
        6
    }

    public fun e_action_type_mismatch() : u64 {
        7
    }

    public fun e_action_type_not_allowed() : u64 {
        12
    }

    public fun e_amount_mismatch() : u64 {
        9
    }

    public fun e_amount_too_high() : u64 {
        5
    }

    public fun e_circuit_breaker_approval_required() : u64 {
        22
    }

    public fun e_circuit_breaker_metric_missing() : u64 {
        20
    }

    public fun e_circuit_breaker_paused() : u64 {
        17
    }

    public fun e_circuit_breaker_policy_mismatch() : u64 {
        18
    }

    public fun e_circuit_breaker_rule_violated() : u64 {
        21
    }

    public fun e_duplicate_metric() : u64 {
        24
    }

    public fun e_duplicate_rule() : u64 {
        23
    }

    public fun e_invalid_circuit_breaker_rule() : u64 {
        19
    }

    public fun e_invalid_policy_kind() : u64 {
        15
    }

    public fun e_invalid_receipt() : u64 {
        3
    }

    public fun e_not_authorized() : u64 {
        2
    }

    public fun e_paused() : u64 {
        1
    }

    public fun e_policy_mismatch() : u64 {
        11
    }

    public fun e_protocol_mismatch() : u64 {
        14
    }

    public fun e_receipt_expired() : u64 {
        4
    }

    public fun e_receipt_required() : u64 {
        16
    }

    public fun e_receipt_ttl_too_long() : u64 {
        13
    }

    public fun e_recipient_mismatch() : u64 {
        8
    }

    public fun e_recipient_not_allowed() : u64 {
        10
    }

    public fun e_rule_not_found() : u64 {
        25
    }

    public fun e_too_many_rules() : u64 {
        26
    }

    // decompiled from Move bytecode v7
}

