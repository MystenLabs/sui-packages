module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors {
    public fun e_admin_only() : u64 {
        100
    }

    public fun e_battle_finished() : u64 {
        103
    }

    public fun e_entry_fee_changed() : u64 {
        112
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

    public fun e_nft_not_whitelisted() : u64 {
        101
    }

    public fun e_no_pending_to_cancel() : u64 {
        108
    }

    public fun e_paused() : u64 {
        107
    }

    public fun e_tree_insufficient() : u64 {
        201
    }

    public fun e_unauthorized_player() : u64 {
        102
    }

    // decompiled from Move bytecode v7
}

