module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::activity_log {
    struct AgentAction has copy, drop {
        agent_cap_id: address,
        action_type: vector<u8>,
        protocol: address,
        amount: u64,
        description: vector<u8>,
        walrus_blob_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct GuardianAction has copy, drop {
        action_type: vector<u8>,
        risk_score: u64,
        description: vector<u8>,
        walrus_blob_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct IntentExecution has copy, drop {
        user: address,
        raw_intent: vector<u8>,
        parsed_action: vector<u8>,
        guardian_result: vector<u8>,
        tx_digest: vector<u8>,
        walrus_blob_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct DAOAction has copy, drop {
        proposer: address,
        action_type: vector<u8>,
        description: vector<u8>,
        timestamp_ms: u64,
    }

    public fun log_agent_action(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AgentCap, arg1: vector<u8>, arg2: address, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = AgentAction{
            agent_cap_id   : 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::cap_id(arg0),
            action_type    : arg1,
            protocol       : arg2,
            amount         : arg3,
            description    : arg4,
            walrus_blob_id : arg5,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AgentAction>(v0);
    }

    public fun log_dao_action(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = DAOAction{
            proposer     : 0x2::tx_context::sender(arg4),
            action_type  : arg1,
            description  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DAOAction>(v0);
    }

    public fun log_guardian_action(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskGuardianCap, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = GuardianAction{
            action_type    : arg1,
            risk_score     : arg2,
            description    : arg3,
            walrus_blob_id : arg4,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<GuardianAction>(v0);
    }

    public fun log_intent_execution(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = IntentExecution{
            user            : 0x2::tx_context::sender(arg6),
            raw_intent      : arg0,
            parsed_action   : arg1,
            guardian_result : arg2,
            tx_digest       : arg3,
            walrus_blob_id  : arg4,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<IntentExecution>(v0);
    }

    // decompiled from Move bytecode v7
}

