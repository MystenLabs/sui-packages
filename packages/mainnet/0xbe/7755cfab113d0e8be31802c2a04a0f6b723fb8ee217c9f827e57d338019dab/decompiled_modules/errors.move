module 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors {
    public fun already_bid() : u64 {
        206
    }

    public fun already_completed() : u64 {
        6
    }

    public fun already_executed() : u64 {
        105
    }

    public fun already_revealed() : u64 {
        103
    }

    public fun auction_already_finalized() : u64 {
        209
    }

    public fun auction_not_found() : u64 {
        200
    }

    public fun auction_not_in_reveal_phase() : u64 {
        208
    }

    public fun auction_not_open() : u64 {
        201
    }

    public fun bid_below_minimum() : u64 {
        205
    }

    public fun bid_deadline_passed() : u64 {
        202
    }

    public fun bond_already_forfeited() : u64 {
        401
    }

    public fun bond_locked() : u64 {
        403
    }

    public fun bond_not_releasable() : u64 {
        402
    }

    public fun bundle_already_executed() : u64 {
        302
    }

    public fun bundle_expired() : u64 {
        306
    }

    public fun bundle_not_found() : u64 {
        300
    }

    public fun commitment_not_found() : u64 {
        100
    }

    public fun commitment_not_revealed() : u64 {
        109
    }

    public fun decryption_failed() : u64 {
        304
    }

    public fun empty_vector() : u64 {
        8
    }

    public fun execution_time_not_reached() : u64 {
        301
    }

    public fun hash_mismatch() : u64 {
        104
    }

    public fun insufficient_bond() : u64 {
        400
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_amount() : u64 {
        2
    }

    public fun invalid_bundle_actions() : u64 {
        305
    }

    public fun invalid_commitment_type() : u64 {
        106
    }

    public fun invalid_salt() : u64 {
        108
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

    public fun no_bid_found() : u64 {
        207
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

    public fun not_winner() : u64 {
        210
    }

    public fun reveal_deadline_not_reached() : u64 {
        204
    }

    public fun reveal_deadline_passed() : u64 {
        203
    }

    public fun reveal_window_not_open() : u64 {
        107
    }

    public fun slippage_exceeded() : u64 {
        303
    }

    public fun too_early_to_reveal() : u64 {
        101
    }

    public fun too_late_to_reveal() : u64 {
        102
    }

    // decompiled from Move bytecode v6
}

