module 0x25d3dd5bfb4bf4afbc1f1da0ec7ad90498e41f74e094abdd6df23047d64432e9::errors {
    public fun e_admin_only() : u64 {
        100
    }

    public fun e_battle_finished() : u64 {
        103
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

    public fun e_unauthorized_player() : u64 {
        102
    }

    // decompiled from Move bytecode v6
}

