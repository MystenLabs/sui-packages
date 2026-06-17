module 0x7f3578ebe174b0343cd96391b2a1c75d5db4ad82c793650b3950bdb5634192e5::decision_registry {
    struct DecisionRecorded has copy, drop {
        agent_id: u64,
        run_id: 0x1::string::String,
        decision_hash: 0x1::string::String,
        evidence_uri: 0x1::string::String,
        signal_type: 0x1::string::String,
        recorder: address,
    }

    public fun record_agent_decision(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        let v0 = DecisionRecorded{
            agent_id      : arg0,
            run_id        : arg1,
            decision_hash : arg2,
            evidence_uri  : arg3,
            signal_type   : arg4,
            recorder      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DecisionRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

