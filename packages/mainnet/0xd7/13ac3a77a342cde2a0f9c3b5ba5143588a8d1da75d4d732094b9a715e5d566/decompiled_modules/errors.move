module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors {
    public fun already_completed() : u64 {
        6
    }

    public fun balance_mismatch() : u64 {
        207
    }

    public fun cannot_cancel_with_escrow() : u64 {
        110
    }

    public fun challenge_period_not_over() : u64 {
        202
    }

    public fun challenge_period_over() : u64 {
        203
    }

    public fun channel_already_closing() : u64 {
        208
    }

    public fun channel_closed() : u64 {
        200
    }

    public fun channel_disputed() : u64 {
        210
    }

    public fun channel_not_closing() : u64 {
        201
    }

    public fun empty_endpoint() : u64 {
        406
    }

    public fun empty_service_name() : u64 {
        407
    }

    public fun empty_vector() : u64 {
        8
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_amount() : u64 {
        2
    }

    public fun invalid_channel_cap() : u64 {
        209
    }

    public fun invalid_duration() : u64 {
        306
    }

    public fun invalid_nonce() : u64 {
        204
    }

    public fun invalid_pricing() : u64 {
        405
    }

    public fun invalid_rate() : u64 {
        307
    }

    public fun invalid_service_cap() : u64 {
        402
    }

    public fun invalid_shares() : u64 {
        500
    }

    public fun invalid_signature() : u64 {
        205
    }

    public fun invalid_status() : u64 {
        7
    }

    public fun invalid_stream_cap() : u64 {
        309
    }

    public fun invalid_timestamp() : u64 {
        4
    }

    public fun invoice_already_paid() : u64 {
        109
    }

    public fun invoice_directed() : u64 {
        107
    }

    public fun invoice_expired() : u64 {
        102
    }

    public fun invoice_not_disputed() : u64 {
        105
    }

    public fun invoice_not_paid() : u64 {
        104
    }

    public fun invoice_not_pending() : u64 {
        103
    }

    public fun length_mismatch() : u64 {
        9
    }

    public fun no_pricing_tier() : u64 {
        404
    }

    public fun no_revenue() : u64 {
        501
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun not_channel_party() : u64 {
        206
    }

    public fun not_found() : u64 {
        5
    }

    public fun not_owner() : u64 {
        0
    }

    public fun not_payee() : u64 {
        100
    }

    public fun not_payer() : u64 {
        101
    }

    public fun not_stream_recipient() : u64 {
        305
    }

    public fun not_stream_sender() : u64 {
        304
    }

    public fun nothing_to_withdraw() : u64 {
        308
    }

    public fun payment_amount_mismatch() : u64 {
        108
    }

    public fun recipient_exists() : u64 {
        502
    }

    public fun recipient_not_found() : u64 {
        503
    }

    public fun release_conditions_not_met() : u64 {
        106
    }

    public fun service_name_taken() : u64 {
        400
    }

    public fun service_not_found() : u64 {
        401
    }

    public fun stream_already_paused() : u64 {
        301
    }

    public fun stream_ended() : u64 {
        303
    }

    public fun stream_not_active() : u64 {
        300
    }

    public fun stream_not_paused() : u64 {
        302
    }

    public fun token_not_accepted() : u64 {
        403
    }

    public fun zero_recipients() : u64 {
        504
    }

    // decompiled from Move bytecode v6
}

