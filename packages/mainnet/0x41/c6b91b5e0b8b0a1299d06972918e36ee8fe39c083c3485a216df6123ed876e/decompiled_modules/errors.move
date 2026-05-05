module 0x41c6b91b5e0b8b0a1299d06972918e36ee8fe39c083c3485a216df6123ed876e::errors {
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

