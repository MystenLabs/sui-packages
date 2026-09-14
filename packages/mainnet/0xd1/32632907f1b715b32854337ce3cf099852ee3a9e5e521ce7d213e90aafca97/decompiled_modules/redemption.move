module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::redemption {
    struct VaultRedemptionFeeDecay has store, key {
        id: 0x2::object::UID,
        base_rate_bps: u64,
        last_redemption_time: u64,
        min_rate_bps: u64,
        half_life_sec: u256,
        half_life_factor_bps: u64,
    }

    public fun calc_redemption_rate(arg0: u256) : u64 {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::min(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::REDEMPTION_FEE_FLOOR_BPS()), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0)))), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::BASIS_POINTS())))
    }

    fun calculate_decayed_base_rate(arg0: &0x2::clock::Clock, arg1: &VaultRedemptionFeeDecay) : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (arg1.last_redemption_time == 0 || v0 <= arg1.last_redemption_time) {
            return 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(arg1.base_rate_bps)
        };
        let v1 = (v0 - arg1.last_redemption_time) / 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ONE_MIN_MS();
        if (v1 == 0) {
            return 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(arg1.base_rate_bps)
        };
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(arg1.base_rate_bps), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::dec_pow(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1.half_life_sec), v1));
        let v3 = v2;
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(arg1.min_rate_bps);
        if (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::lt(v2, v4)) {
            v3 = v4;
        };
        v3
    }

    public(friend) fun create_vault_redemption(arg0: &mut 0x2::tx_context::TxContext) : VaultRedemptionFeeDecay {
        VaultRedemptionFeeDecay{
            id                   : 0x2::object::new(arg0),
            base_rate_bps        : 50,
            last_redemption_time : 0,
            min_rate_bps         : 50,
            half_life_sec        : 998076600000000000,
            half_life_factor_bps : 5000,
        }
    }

    public fun get_updated_base_rate_from_redemption(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &VaultRedemptionFeeDecay) : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::Decimal {
        if (arg1 == 0) {
            return calculate_decayed_base_rate(arg2, arg3)
        };
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(calculate_decayed_base_rate(arg2, arg3), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(arg1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::REDEMPTION_BETA())));
        let v1 = v0;
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::one();
        if (0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::gt(v0, v2)) {
            v1 = v2;
        };
        v1
    }

    public(friend) fun update_base_rate_and_get_redemption_rate(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut VaultRedemptionFeeDecay) {
        arg3.base_rate_bps = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_bps(get_updated_base_rate_from_redemption(arg0, arg1, arg2, arg3));
        update_last_fee_time(arg3, arg2);
    }

    fun update_last_fee_time(arg0: &mut VaultRedemptionFeeDecay, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 - arg0.last_redemption_time >= 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ONE_MIN_MS()) {
            arg0.last_redemption_time = v0;
        };
    }

    // decompiled from Move bytecode v6
}

