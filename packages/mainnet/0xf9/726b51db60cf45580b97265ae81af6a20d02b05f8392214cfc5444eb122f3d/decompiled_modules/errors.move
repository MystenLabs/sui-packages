module 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors {
    public(friend) fun get_bucket_full_error() : u64 {
        12
    }

    public(friend) fun get_insufficient_funds_error() : u64 {
        2
    }

    public(friend) fun get_invalid_bucket_index_error() : u64 {
        9
    }

    public(friend) fun get_invalid_end_time_error() : u64 {
        1
    }

    public(friend) fun get_invalid_lotto_type_error() : u64 {
        4
    }

    public(friend) fun get_invalid_num_tickets_error() : u64 {
        8
    }

    public(friend) fun get_invalid_num_winners_error() : u64 {
        5
    }

    public(friend) fun get_invalid_ticket_price_error() : u64 {
        0
    }

    public(friend) fun get_lotto_already_refunded_error() : u64 {
        13
    }

    public(friend) fun get_lotto_ended_error() : u64 {
        3
    }

    public(friend) fun get_lotto_not_ended_error() : u64 {
        7
    }

    public(friend) fun get_not_a_winner_error() : u64 {
        6
    }

    public(friend) fun get_refund_already_in_progress_error() : u64 {
        16
    }

    public(friend) fun get_refund_buckets_not_processed_error() : u64 {
        17
    }

    public(friend) fun get_refund_not_in_progress_error() : u64 {
        15
    }

    public(friend) fun get_refund_selection_not_started_error() : u64 {
        14
    }

    public(friend) fun get_version_mismatch_error() : u64 {
        18
    }

    public(friend) fun get_winner_selection_in_progress_error() : u64 {
        10
    }

    public(friend) fun get_winner_selection_not_in_progress_error() : u64 {
        11
    }

    // decompiled from Move bytecode v6
}

