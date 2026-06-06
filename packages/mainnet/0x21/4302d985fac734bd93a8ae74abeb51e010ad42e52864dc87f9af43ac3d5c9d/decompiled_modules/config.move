module 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::config {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        lighthouse_threshold: u64,
        min_threshold: u64,
        scarcity_multiplier: u64,
        vessel_age_gate_ms: u64,
        last_recalibrated: u64,
    }

    struct ThresholdRatcheted has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
        lh_count: u64,
        ratcheted_at: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                   : 0x2::object::new(arg0),
            lighthouse_threshold : 1000,
            min_threshold        : 1000,
            scarcity_multiplier  : 100,
            vessel_age_gate_ms   : 0,
            last_recalibrated    : 0,
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public fun last_recalibrated(arg0: &ProtocolConfig) : u64 {
        arg0.last_recalibrated
    }

    public fun lighthouse_threshold(arg0: &ProtocolConfig) : u64 {
        arg0.lighthouse_threshold
    }

    public fun min_threshold(arg0: &ProtocolConfig) : u64 {
        arg0.min_threshold
    }

    public fun recalibrate(arg0: &mut ProtocolConfig, arg1: &0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::drift::Drift, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x214302d985fac734bd93a8ae74abeb51e010ad42e52864dc87f9af43ac3d5c9d::drift::lh_count(arg1);
        let v1 = v0 * arg0.scarcity_multiplier;
        let v2 = if (v1 > arg0.min_threshold) {
            v1
        } else {
            arg0.min_threshold
        };
        if (v2 > arg0.lighthouse_threshold) {
            arg0.lighthouse_threshold = v2;
            arg0.last_recalibrated = 0x2::clock::timestamp_ms(arg2);
            let v3 = ThresholdRatcheted{
                old_threshold : arg0.lighthouse_threshold,
                new_threshold : v2,
                lh_count      : v0,
                ratcheted_at  : arg0.last_recalibrated,
            };
            0x2::event::emit<ThresholdRatcheted>(v3);
        };
    }

    public fun scarcity_multiplier(arg0: &ProtocolConfig) : u64 {
        arg0.scarcity_multiplier
    }

    public fun tide_threshold(arg0: &ProtocolConfig) : u64 {
        arg0.lighthouse_threshold / 2
    }

    public fun vessel_age_gate_ms(arg0: &ProtocolConfig) : u64 {
        arg0.vessel_age_gate_ms
    }

    // decompiled from Move bytecode v7
}

