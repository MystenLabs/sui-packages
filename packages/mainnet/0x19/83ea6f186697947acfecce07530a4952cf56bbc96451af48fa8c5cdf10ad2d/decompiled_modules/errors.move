module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors {
    public fun e_already_consumed() : u64 {
        84
    }

    public fun e_already_matured() : u64 {
        163
    }

    public fun e_already_paused() : u64 {
        65
    }

    public fun e_amount_exceeds_max() : u64 {
        177
    }

    public fun e_amount_too_small() : u64 {
        4
    }

    public fun e_claim_required_before_redeem() : u64 {
        149
    }

    public fun e_collect_already_done_this_epoch() : u64 {
        154
    }

    public fun e_collect_epoch_mismatch() : u64 {
        150
    }

    public fun e_collect_in_progress() : u64 {
        156
    }

    public fun e_collect_inventory_incomplete() : u64 {
        152
    }

    public fun e_collect_inventory_snapshot_too_large() : u64 {
        155
    }

    public fun e_collect_no_work() : u64 {
        147
    }

    public fun e_collect_progress_started() : u64 {
        151
    }

    public fun e_collect_receipt_expired() : u64 {
        157
    }

    public fun e_collect_receipt_not_expired() : u64 {
        158
    }

    public fun e_combine_pt_yt_mismatch() : u64 {
        192
    }

    public fun e_div_by_zero() : u64 {
        2
    }

    public fun e_entry_paused() : u64 {
        167
    }

    public fun e_epoch_overflow() : u64 {
        144
    }

    public fun e_escrow_not_settled() : u64 {
        85
    }

    public fun e_escrow_paused() : u64 {
        80
    }

    public fun e_final_collect_required_before_redeem() : u64 {
        153
    }

    public fun e_hard_cap_breached() : u64 {
        89
    }

    public fun e_insufficient_inventory() : u64 {
        128
    }

    public fun e_invalid_bps() : u64 {
        33
    }

    public fun e_maturity_in_past() : u64 {
        161
    }

    public fun e_no_active_collect() : u64 {
        159
    }

    public fun e_no_shares() : u64 {
        146
    }

    public fun e_not_matured() : u64 {
        162
    }

    public fun e_not_paused() : u64 {
        66
    }

    public fun e_overflow() : u64 {
        1
    }

    public fun e_pause_kind_mismatch() : u64 {
        67
    }

    public fun e_pause_reason_too_long() : u64 {
        68
    }

    public fun e_pause_ttl_too_long() : u64 {
        64
    }

    public fun e_protocol_cap_exceeded() : u64 {
        32
    }

    public fun e_pt_already_consumed_use_drain() : u64 {
        87
    }

    public fun e_pt_inventory_full() : u64 {
        131
    }

    public fun e_pt_not_consumed() : u64 {
        86
    }

    public fun e_pt_vault_head_paused() : u64 {
        132
    }

    public fun e_pt_vault_inventory_mismatch() : u64 {
        130
    }

    public fun e_pt_vault_nonzero_supply() : u64 {
        133
    }

    public fun e_pt_vault_paused() : u64 {
        129
    }

    public fun e_underflow() : u64 {
        3
    }

    public fun e_use_close_pt_side() : u64 {
        88
    }

    public fun e_vault_already_registered() : u64 {
        166
    }

    public fun e_vault_not_registered() : u64 {
        165
    }

    public fun e_watermark_param_out_of_range() : u64 {
        52
    }

    public fun e_wrong_adapter() : u64 {
        16
    }

    public fun e_wrong_escrow() : u64 {
        81
    }

    public fun e_wrong_market() : u64 {
        160
    }

    public fun e_wrong_market_core() : u64 {
        90
    }

    public fun e_wrong_recipient() : u64 {
        176
    }

    public fun e_yt_inventory_full() : u64 {
        148
    }

    public fun e_yt_vault_paused() : u64 {
        145
    }

    public fun e_zero_amount() : u64 {
        0
    }

    // decompiled from Move bytecode v7
}

