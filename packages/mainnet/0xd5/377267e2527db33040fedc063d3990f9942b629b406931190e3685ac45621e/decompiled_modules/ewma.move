module 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::ewma {
    struct EWMAState has copy, drop, store {
        mean: u64,
        variance: u64,
        alpha: u64,
        z_score_threshold: u64,
        additional_taker_fee: u64,
        last_updated_timestamp: u64,
        enabled: bool,
    }

    public(friend) fun additional_taker_fee(arg0: &EWMAState) : u64 {
        arg0.additional_taker_fee
    }

    public(friend) fun alpha(arg0: &EWMAState) : u64 {
        arg0.alpha
    }

    public(friend) fun apply_taker_penalty(arg0: &EWMAState, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        if (!arg0.enabled || 0x2::tx_context::gas_price(arg2) < arg0.mean) {
            return arg1
        };
        if (z_score(arg0, arg2) > arg0.z_score_threshold) {
            arg1 + arg0.additional_taker_fee
        } else {
            arg1
        }
    }

    public(friend) fun disable(arg0: &mut EWMAState) {
        arg0.enabled = false;
    }

    public(friend) fun enable(arg0: &mut EWMAState) {
        arg0.enabled = true;
    }

    public(friend) fun enabled(arg0: &EWMAState) : bool {
        arg0.enabled
    }

    public(friend) fun init_ewma_state(arg0: &0x2::tx_context::TxContext) : EWMAState {
        EWMAState{
            mean                   : 0x2::tx_context::gas_price(arg0) * 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling(),
            variance               : 0,
            alpha                  : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::default_ewma_alpha(),
            z_score_threshold      : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::default_z_score_threshold(),
            additional_taker_fee   : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::default_additional_taker_fee(),
            last_updated_timestamp : 0,
            enabled                : false,
        }
    }

    public(friend) fun last_updated_timestamp(arg0: &EWMAState) : u64 {
        arg0.last_updated_timestamp
    }

    public(friend) fun mean(arg0: &EWMAState) : u64 {
        arg0.mean
    }

    public(friend) fun set_additional_taker_fee(arg0: &mut EWMAState, arg1: u64) {
        arg0.additional_taker_fee = arg1;
    }

    public(friend) fun set_alpha(arg0: &mut EWMAState, arg1: u64) {
        arg0.alpha = arg1;
    }

    public(friend) fun set_z_score_threshold(arg0: &mut EWMAState, arg1: u64) {
        arg0.z_score_threshold = arg1;
    }

    public(friend) fun update(arg0: &mut EWMAState, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 == arg0.last_updated_timestamp) {
            return
        };
        arg0.last_updated_timestamp = v0;
        let v1 = arg0.alpha;
        let v2 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling() - v1;
        let v3 = 0x2::tx_context::gas_price(arg2) * 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling();
        let v4 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v1, v3) + 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v2, arg0.mean);
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            v4 - v3
        };
        let v6 = if (arg0.variance == 0) {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v5, v5)
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0.variance, v2) + 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v1, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v5, v5))
        };
        arg0.mean = v4;
        arg0.variance = v6;
    }

    public(friend) fun variance(arg0: &EWMAState) : u64 {
        arg0.variance
    }

    public(friend) fun z_score(arg0: &EWMAState, arg1: &0x2::tx_context::TxContext) : u64 {
        if (arg0.variance == 0) {
            return 0
        };
        let v0 = 0x2::tx_context::gas_price(arg1) * 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling();
        let v1 = if (v0 > arg0.mean) {
            v0 - arg0.mean
        } else {
            arg0.mean - v0
        };
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(v1, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::sqrt(arg0.variance, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling()))
    }

    public(friend) fun z_score_threshold(arg0: &EWMAState) : u64 {
        arg0.z_score_threshold
    }

    // decompiled from Move bytecode v6
}

