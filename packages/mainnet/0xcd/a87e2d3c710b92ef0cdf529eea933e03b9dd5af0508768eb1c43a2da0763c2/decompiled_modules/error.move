module 0xcda87e2d3c710b92ef0cdf529eea933e03b9dd5af0508768eb1c43a2da0763c2::error {
    public(friend) fun err_already_processed() {
        abort 200
    }

    public(friend) fun err_amount_too_large() {
        abort 102
    }

    public(friend) fun err_insufficient_backing() {
        abort 207
    }

    public(friend) fun err_invalid_message() {
        abort 204
    }

    public(friend) fun err_invalid_version() {
        abort 800
    }

    public(friend) fun err_operator_revoked() {
        abort 801
    }

    public(friend) fun err_outstanding_backing() {
        abort 208
    }

    public(friend) fun err_paused() {
        abort 100
    }

    public(friend) fun err_payload_too_short() {
        abort 205
    }

    public(friend) fun err_rate_limit_exceeded() {
        abort 101
    }

    public(friend) fun err_unauthorized_emitter() {
        abort 202
    }

    public(friend) fun err_unauthorized_origin() {
        abort 201
    }

    public(friend) fun err_unsupported_evm_token() {
        abort 206
    }

    public(friend) fun err_wrong_message_type() {
        abort 203
    }

    // decompiled from Move bytecode v6
}

