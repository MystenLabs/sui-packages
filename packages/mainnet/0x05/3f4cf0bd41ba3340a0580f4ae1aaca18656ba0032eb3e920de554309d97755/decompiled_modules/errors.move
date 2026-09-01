module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors {
    public fun e_admin_only() : u64 {
        100
    }

    public fun e_admin_transfer_noop() : u64 {
        114
    }

    public fun e_battle_finished() : u64 {
        103
    }

    public fun e_entry_fee_changed() : u64 {
        112
    }

    public fun e_fifth_move_bad_signature() : u64 {
        116
    }

    public fun e_fifth_move_config_mismatch() : u64 {
        120
    }

    public fun e_fifth_move_config_noop() : u64 {
        132
    }

    public fun e_fifth_move_disabled() : u64 {
        115
    }

    public fun e_fifth_move_domain_mismatch() : u64 {
        123
    }

    public fun e_fifth_move_draft_required() : u64 {
        133
    }

    public fun e_fifth_move_expired() : u64 {
        121
    }

    public fun e_fifth_move_future_issued() : u64 {
        122
    }

    public fun e_fifth_move_invalid_draft_choice() : u64 {
        134
    }

    public fun e_fifth_move_invalid_source_bitmap() : u64 {
        129
    }

    public fun e_fifth_move_invalid_timestamp_ordering() : u64 {
        130
    }

    public fun e_fifth_move_invalid_version() : u64 {
        125
    }

    public fun e_fifth_move_malformed_public_key() : u64 {
        127
    }

    public fun e_fifth_move_malformed_signature() : u64 {
        128
    }

    public fun e_fifth_move_network_mismatch() : u64 {
        124
    }

    public fun e_fifth_move_not_qualified() : u64 {
        118
    }

    public fun e_fifth_move_threshold_mismatch() : u64 {
        119
    }

    public fun e_fifth_move_version_overflow() : u64 {
        131
    }

    public fun e_fifth_move_wrong_config_object() : u64 {
        126
    }

    public fun e_fifth_move_wrong_wallet() : u64 {
        117
    }

    public fun e_incorrect_coin_type() : u64 {
        200
    }

    public fun e_insufficient_payment() : u64 {
        104
    }

    public fun e_insufficient_vault() : u64 {
        105
    }

    public fun e_invalid_ability_name() : u64 {
        106
    }

    public fun e_invalid_address() : u64 {
        111
    }

    public fun e_invalid_economics() : u64 {
        110
    }

    public fun e_invalid_move() : u64 {
        109
    }

    public fun e_invalid_target_growth() : u64 {
        113
    }

    public fun e_move_repeated() : u64 {
        135
    }

    public fun e_nft_not_whitelisted() : u64 {
        101
    }

    public fun e_no_pending_to_cancel() : u64 {
        108
    }

    public fun e_paused() : u64 {
        107
    }

    public fun e_reroll_already_used() : u64 {
        202
    }

    public fun e_reroll_disabled_for_mode() : u64 {
        204
    }

    public fun e_reroll_not_players_turn() : u64 {
        203
    }

    public fun e_tree_insufficient() : u64 {
        201
    }

    public fun e_unauthorized_player() : u64 {
        102
    }

    // decompiled from Move bytecode v7
}

