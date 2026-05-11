module 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::errors {
    public fun e_cap_rotation_not_approved() : u64 {
        23
    }

    public fun e_cap_rotation_timelock_not_elapsed() : u64 {
        21
    }

    public fun e_deadline_exceeded() : u64 {
        95
    }

    public fun e_deadline_ext_invalid() : u64 {
        74
    }

    public fun e_deadline_ext_max_reached() : u64 {
        76
    }

    public fun e_deadline_ext_not_authorized() : u64 {
        75
    }

    public fun e_deadline_ext_pending() : u64 {
        77
    }

    public fun e_deadline_not_reached() : u64 {
        3
    }

    public fun e_dispute_timeout_not_reached() : u64 {
        15
    }

    public fun e_dq_already_assigned() : u64 {
        46
    }

    public fun e_dq_already_committed() : u64 {
        48
    }

    public fun e_dq_already_revealed() : u64 {
        53
    }

    public fun e_dq_bond_not_ready() : u64 {
        43
    }

    public fun e_dq_challenge_window_closed() : u64 {
        54
    }

    public fun e_dq_commit_window_closed() : u64 {
        49
    }

    public fun e_dq_economics_update_not_approved() : u64 {
        66
    }

    public fun e_dq_economics_update_timelock_not_elapsed() : u64 {
        67
    }

    public fun e_dq_escrow_already_bound() : u64 {
        92
    }

    public fun e_dq_fallback_not_ready() : u64 {
        57
    }

    public fun e_dq_insufficient_stake() : u64 {
        63
    }

    public fun e_dq_invalid_config() : u64 {
        39
    }

    public fun e_dq_invalid_input() : u64 {
        37
    }

    public fun e_dq_invalid_policy() : u64 {
        44
    }

    public fun e_dq_invalid_reveal() : u64 {
        52
    }

    public fun e_dq_invalid_state() : u64 {
        45
    }

    public fun e_dq_missing_commit() : u64 {
        51
    }

    public fun e_dq_no_pending_economics_update() : u64 {
        65
    }

    public fun e_dq_no_pending_reviewer_threshold_update() : u64 {
        96
    }

    public fun e_dq_no_pending_timing_update() : u64 {
        83
    }

    public fun e_dq_not_assigned() : u64 {
        47
    }

    public fun e_dq_not_authorized() : u64 {
        38
    }

    public fun e_dq_not_finalizable() : u64 {
        55
    }

    public fun e_dq_not_invited() : u64 {
        93
    }

    public fun e_dq_pending_economics_update_already_exists() : u64 {
        68
    }

    public fun e_dq_pending_reviewer_threshold_update_already_exists() : u64 {
        99
    }

    public fun e_dq_pending_timing_update_already_exists() : u64 {
        86
    }

    public fun e_dq_replacement_exhausted() : u64 {
        56
    }

    public fun e_dq_reveal_window_closed() : u64 {
        50
    }

    public fun e_dq_reviewer_already_registered() : u64 {
        41
    }

    public fun e_dq_reviewer_not_active() : u64 {
        42
    }

    public fun e_dq_reviewer_not_eligible() : u64 {
        40
    }

    public fun e_dq_reviewer_threshold_update_not_approved() : u64 {
        97
    }

    public fun e_dq_reviewer_threshold_update_timelock_not_elapsed() : u64 {
        98
    }

    public fun e_dq_ticket_invalid_path() : u64 {
        59
    }

    public fun e_dq_ticket_mismatch() : u64 {
        58
    }

    public fun e_dq_timing_update_not_approved() : u64 {
        84
    }

    public fun e_dq_timing_update_timelock_not_elapsed() : u64 {
        85
    }

    public fun e_dq_vote_above_max() : u64 {
        62
    }

    public fun e_dq_vote_below_min() : u64 {
        61
    }

    public fun e_dq_vote_floor_invalid() : u64 {
        64
    }

    public fun e_dq_vote_not_odd() : u64 {
        60
    }

    public fun e_fee_timelock_not_elapsed() : u64 {
        17
    }

    public fun e_fee_update_not_approved() : u64 {
        19
    }

    public fun e_incident_freeze_active() : u64 {
        22
    }

    public fun e_invalid_address() : u64 {
        16
    }

    public fun e_invalid_amount() : u64 {
        4
    }

    public fun e_invalid_deadline() : u64 {
        5
    }

    public fun e_invalid_fee_config() : u64 {
        8
    }

    public fun e_invalid_kind() : u64 {
        6
    }

    public fun e_invalid_listing_deposit_config() : u64 {
        24
    }

    public fun e_invalid_listing_deposit_settlement() : u64 {
        26
    }

    public fun e_invalid_listing_ref() : u64 {
        25
    }

    public fun e_invalid_manifest_anchor_input() : u64 {
        14
    }

    public fun e_invalid_state() : u64 {
        2
    }

    public fun e_listing_deposit_already_bound() : u64 {
        90
    }

    public fun e_listing_deposit_timelock_not_elapsed() : u64 {
        29
    }

    public fun e_listing_deposit_update_not_approved() : u64 {
        28
    }

    public fun e_mailbox_ack_not_monotonic() : u64 {
        36
    }

    public fun e_mailbox_already_bound() : u64 {
        91
    }

    public fun e_mailbox_closed() : u64 {
        32
    }

    public fun e_mailbox_invalid_ack_seq() : u64 {
        35
    }

    public fun e_mailbox_invalid_hash() : u64 {
        34
    }

    public fun e_mailbox_invalid_input() : u64 {
        30
    }

    public fun e_mailbox_invalid_signal_type() : u64 {
        33
    }

    public fun e_mailbox_not_authorized() : u64 {
        31
    }

    public fun e_milestone_deadline_passed() : u64 {
        87
    }

    public fun e_milestone_dispute_not_expired() : u64 {
        82
    }

    public fun e_milestone_index_oob() : u64 {
        81
    }

    public fun e_milestone_invalid_input() : u64 {
        78
    }

    public fun e_milestone_invalid_state() : u64 {
        79
    }

    public fun e_milestone_not_authorized() : u64 {
        80
    }

    public fun e_native_requires_fee_path() : u64 {
        13
    }

    public fun e_no_pending_cap_rotation() : u64 {
        20
    }

    public fun e_no_pending_fee_update() : u64 {
        18
    }

    public fun e_no_pending_listing_deposit_update() : u64 {
        27
    }

    public fun e_not_authorized() : u64 {
        1
    }

    public fun e_order_escrow_already_bound() : u64 {
        89
    }

    public fun e_review_already_exists() : u64 {
        72
    }

    public fun e_review_invalid_input() : u64 {
        70
    }

    public fun e_review_invalid_rating() : u64 {
        73
    }

    public fun e_review_not_authorized() : u64 {
        71
    }

    public fun e_self_deal_not_allowed() : u64 {
        7
    }

    // decompiled from Move bytecode v7
}

