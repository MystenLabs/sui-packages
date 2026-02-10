module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors {
    public fun cap_already_revoked() : u64 {
        301
    }

    public fun empty_label() : u64 {
        300
    }

    public fun empty_pool_name() : u64 {
        400
    }

    public fun expired_on_create() : u64 {
        109
    }

    public fun expired_on_create_intent() : u64 {
        207
    }

    public fun fill_below_minimum() : u64 {
        111
    }

    public fun fill_exceeds_remaining() : u64 {
        112
    }

    public fun insufficient_escrowed() : u64 {
        205
    }

    public fun insufficient_liquidity() : u64 {
        204
    }

    public fun intent_expired() : u64 {
        201
    }

    public fun intent_not_pending() : u64 {
        200
    }

    public fun invalid_fill_policy() : u64 {
        104
    }

    public fun invalid_price_bounds() : u64 {
        103
    }

    public fun invalid_status_for_expire() : u64 {
        117
    }

    public fun invalid_status_for_fill() : u64 {
        120
    }

    public fun invalid_status_for_withdraw() : u64 {
        115
    }

    public fun min_fill_exceeds_amount() : u64 {
        118
    }

    public fun not_creator() : u64 {
        206
    }

    public fun not_maker() : u64 {
        114
    }

    public fun not_pool_creator() : u64 {
        402
    }

    public fun not_yet_expired() : u64 {
        116
    }

    public fun not_yet_expired_intent() : u64 {
        202
    }

    public fun offer_already_in_pool() : u64 {
        401
    }

    public fun offer_expired() : u64 {
        105
    }

    public fun offer_not_fillable() : u64 {
        106
    }

    public fun offer_not_in_pool() : u64 {
        403
    }

    public fun partial_cap_already_revoked() : u64 {
        302
    }

    public fun partial_fill_cap_required() : u64 {
        119
    }

    public fun partial_fill_not_allowed() : u64 {
        110
    }

    public fun pool_full() : u64 {
        404
    }

    public fun price_mismatch() : u64 {
        203
    }

    public fun price_too_high() : u64 {
        108
    }

    public fun price_too_low() : u64 {
        107
    }

    public fun revocation_not_found() : u64 {
        304
    }

    public fun revoked_cap() : u64 {
        303
    }

    public fun would_leave_dust() : u64 {
        113
    }

    public fun zero_amount() : u64 {
        100
    }

    public fun zero_escrow_amount() : u64 {
        209
    }

    public fun zero_max_price() : u64 {
        102
    }

    public fun zero_min_price() : u64 {
        101
    }

    public fun zero_price() : u64 {
        121
    }

    public fun zero_receive_amount() : u64 {
        208
    }

    // decompiled from Move bytecode v6
}

