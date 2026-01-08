module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::ewma {
    struct EWMAState has copy, drop, store {
        mean: u64,
        variance: u64,
        alpha: u64,
        z_score_threshold: u64,
        additional_taker_fee: u64,
        last_updated_timestamp: u64,
        enabled: bool,
    }

    struct EWMAUpdate has copy, drop, store {
        pool_id: 0x2::object::ID,
        gas_price: u64,
        mean: u64,
        variance: u64,
        timestamp: u64,
    }

    public(friend) fun additional_taker_fee(arg0: &EWMAState) : u64 {
        arg0.additional_taker_fee
    }

    public(friend) fun alpha(arg0: &EWMAState) : u64 {
        arg0.alpha
    }

    public(friend) fun apply_taker_penalty(arg0: &EWMAState, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        if (!arg0.enabled || 0x2::tx_context::gas_price(arg2) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() < arg0.mean) {
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
            mean                   : 0x2::tx_context::gas_price(arg0) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling(),
            variance               : 0,
            alpha                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::default_ewma_alpha(),
            z_score_threshold      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::default_z_score_threshold(),
            additional_taker_fee   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::default_additional_taker_fee(),
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

    public(friend) fun update(arg0: &mut EWMAState, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 == arg0.last_updated_timestamp) {
            return
        };
        arg0.last_updated_timestamp = v0;
        let v1 = arg0.alpha;
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() - v1;
        let v3 = 0x2::tx_context::gas_price(arg3) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling();
        let v4 = if (v3 > arg0.mean) {
            v3 - arg0.mean
        } else {
            arg0.mean - v3
        };
        let v5 = if (arg0.variance == 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v4, v4)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0.variance, v2) + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v4, v4))
        };
        arg0.mean = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v1, v3) + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v2, arg0.mean);
        arg0.variance = v5;
        let v6 = EWMAUpdate{
            pool_id   : arg1,
            gas_price : v3,
            mean      : arg0.mean,
            variance  : arg0.variance,
            timestamp : v0,
        };
        0x2::event::emit<EWMAUpdate>(v6);
    }

    public(friend) fun variance(arg0: &EWMAState) : u64 {
        arg0.variance
    }

    public(friend) fun z_score(arg0: &EWMAState, arg1: &0x2::tx_context::TxContext) : u64 {
        if (arg0.variance == 0) {
            return 0
        };
        let v0 = 0x2::tx_context::gas_price(arg1) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling();
        let v1 = if (v0 > arg0.mean) {
            v0 - arg0.mean
        } else {
            arg0.mean - v0
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::sqrt(arg0.variance, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling()))
    }

    public(friend) fun z_score_threshold(arg0: &EWMAState) : u64 {
        arg0.z_score_threshold
    }

    // decompiled from Move bytecode v6
}

