module 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::events {
    struct SetSigner has copy, drop {
        source_id: u16,
        public_key: vector<u8>,
        expires_at_ms: u64,
    }

    struct RemovedSigner has copy, drop {
        source_id: u16,
        public_key: vector<u8>,
    }

    struct SetMaxConfidenceBps has copy, drop {
        source_id: u16,
        old_max_confidence_bps: u64,
        new_max_confidence_bps: u64,
    }

    struct SetMaxFutureDriftMs has copy, drop {
        source_id: u16,
        old_max_future_drift_ms: u64,
        new_max_future_drift_ms: u64,
    }

    struct SetStepLimit has copy, drop {
        source_id: u16,
        storage_id: 0x1::option::Option<u32>,
        base_bps: u64,
        bps_per_second: u64,
        max_bps: u64,
    }

    struct RemovedStepLimit has copy, drop {
        source_id: u16,
        storage_id: u32,
    }

    public(friend) fun removed_signer(arg0: u16, arg1: vector<u8>) {
        let v0 = RemovedSigner{
            source_id  : arg0,
            public_key : arg1,
        };
        0x2::event::emit<RemovedSigner>(v0);
    }

    public(friend) fun removed_step_limit(arg0: u16, arg1: u32) {
        let v0 = RemovedStepLimit{
            source_id  : arg0,
            storage_id : arg1,
        };
        0x2::event::emit<RemovedStepLimit>(v0);
    }

    public(friend) fun set_max_confidence_bps(arg0: u16, arg1: u64, arg2: u64) {
        let v0 = SetMaxConfidenceBps{
            source_id              : arg0,
            old_max_confidence_bps : arg1,
            new_max_confidence_bps : arg2,
        };
        0x2::event::emit<SetMaxConfidenceBps>(v0);
    }

    public(friend) fun set_max_future_drift_ms(arg0: u16, arg1: u64, arg2: u64) {
        let v0 = SetMaxFutureDriftMs{
            source_id               : arg0,
            old_max_future_drift_ms : arg1,
            new_max_future_drift_ms : arg2,
        };
        0x2::event::emit<SetMaxFutureDriftMs>(v0);
    }

    public(friend) fun set_signer(arg0: u16, arg1: vector<u8>, arg2: u64) {
        let v0 = SetSigner{
            source_id     : arg0,
            public_key    : arg1,
            expires_at_ms : arg2,
        };
        0x2::event::emit<SetSigner>(v0);
    }

    public(friend) fun set_step_limit(arg0: u16, arg1: 0x1::option::Option<u32>, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SetStepLimit{
            source_id      : arg0,
            storage_id     : arg1,
            base_bps       : arg2,
            bps_per_second : arg3,
            max_bps        : arg4,
        };
        0x2::event::emit<SetStepLimit>(v0);
    }

    // decompiled from Move bytecode v7
}

