module 0xe578839163bfd46ef1366453feecab0e61167fc2b0be2ac59792d40fb645e6e2::landing_probe {
    struct LandingProbeEvent has copy, drop {
        experiment_id: u64,
        probe_id: u64,
        anchor_checkpoint: u64,
        target_checkpoint: u64,
        anchor_checkpoint_timestamp_ms: u64,
        predicted_target_checkpoint_timestamp_ms: u64,
        predicted_target_local_timestamp_ms: u64,
        client_send_timestamp_ms: u64,
        requested_lead_ms: u64,
        consensus_timestamp_ms: u64,
        consensus_at_or_after_client_send: bool,
        client_to_consensus_abs_ms: u64,
        consensus_at_or_after_prediction: bool,
        prediction_to_consensus_abs_ms: u64,
    }

    fun abs_delta(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    fun make_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : LandingProbeEvent {
        LandingProbeEvent{
            experiment_id                            : arg0,
            probe_id                                 : arg1,
            anchor_checkpoint                        : arg2,
            target_checkpoint                        : arg3,
            anchor_checkpoint_timestamp_ms           : arg4,
            predicted_target_checkpoint_timestamp_ms : arg5,
            predicted_target_local_timestamp_ms      : arg6,
            client_send_timestamp_ms                 : arg7,
            requested_lead_ms                        : arg8,
            consensus_timestamp_ms                   : arg9,
            consensus_at_or_after_client_send        : arg9 >= arg7,
            client_to_consensus_abs_ms               : abs_delta(arg9, arg7),
            consensus_at_or_after_prediction         : arg9 >= arg5,
            prediction_to_consensus_abs_ms           : abs_delta(arg9, arg5),
        }
    }

    public fun probe(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x2::event::emit<LandingProbeEvent>(make_event(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2::clock::timestamp_ms(arg0)));
    }

    // decompiled from Move bytecode v6
}

