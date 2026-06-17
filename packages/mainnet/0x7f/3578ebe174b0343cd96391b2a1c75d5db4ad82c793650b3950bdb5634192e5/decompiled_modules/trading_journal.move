module 0x7f3578ebe174b0343cd96391b2a1c75d5db4ad82c793650b3950bdb5634192e5::trading_journal {
    struct StrategyRunRecorded has copy, drop {
        agent_id: u64,
        run_id: 0x1::string::String,
        strategy_id: 0x1::string::String,
        market: 0x1::string::String,
        decision_hash: 0x1::string::String,
        result_hash: 0x1::string::String,
        evidence_uri: 0x1::string::String,
        action: 0x1::string::String,
        pnl_bps: u64,
        pnl_negative: bool,
        status: 0x1::string::String,
        recorder: address,
    }

    public fun record_strategy_run(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: bool, arg10: 0x1::string::String, arg11: &0x2::tx_context::TxContext) {
        let v0 = StrategyRunRecorded{
            agent_id      : arg0,
            run_id        : arg1,
            strategy_id   : arg2,
            market        : arg3,
            decision_hash : arg4,
            result_hash   : arg5,
            evidence_uri  : arg6,
            action        : arg7,
            pnl_bps       : arg8,
            pnl_negative  : arg9,
            status        : arg10,
            recorder      : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<StrategyRunRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

