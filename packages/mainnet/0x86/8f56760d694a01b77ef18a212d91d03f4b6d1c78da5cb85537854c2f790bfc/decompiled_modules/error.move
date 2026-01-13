module 0x868f56760d694a01b77ef18a212d91d03f4b6d1c78da5cb85537854c2f790bfc::error {
    public fun e_amount_per_cycle_le_limit() : u64 {
        7
    }

    public fun e_coin_type_not_allowed() : u64 {
        15
    }

    public fun e_coin_type_not_found_in_vault() : u64 {
        104
    }

    public fun e_current_time_before_next_cycle() : u64 {
        3
    }

    public fun e_cycle_count_below_minimum() : u64 {
        0
    }

    public fun e_cycle_frequency_below_minimum() : u64 {
        1
    }

    public fun e_execution_permission_failed() : u64 {
        14
    }

    public fun e_invalid_oracle_signature() : u64 {
        12
    }

    public fun e_invalid_order_status() : u64 {
        13
    }

    public fun e_invalid_signature_format() : u64 {
        10
    }

    public fun e_no_amount_left_next_cycle() : u64 {
        2
    }

    public fun e_oracle_signature_expired() : u64 {
        11
    }

    public fun e_output_amount_above_maximum() : u64 {
        5
    }

    public fun e_output_amount_below_minimum() : u64 {
        4
    }

    public fun e_output_amount_below_promised() : u64 {
        6
    }

    public fun e_package_version_check_failed() : u64 {
        100
    }

    public fun e_receipt_order_id_mismatch() : u64 {
        8
    }

    public fun e_role_index_invalid() : u64 {
        200
    }

    public fun e_unauthorized_keeper() : u64 {
        101
    }

    public fun e_unauthorized_operator() : u64 {
        102
    }

    public fun e_unauthorized_operator_with_cap() : u64 {
        105
    }

    public fun e_unauthorized_oracle() : u64 {
        103
    }

    public fun e_unauthorized_user() : u64 {
        9
    }

    // decompiled from Move bytecode v6
}

