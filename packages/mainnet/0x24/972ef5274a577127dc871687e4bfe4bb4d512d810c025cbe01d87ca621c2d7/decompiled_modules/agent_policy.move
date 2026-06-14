module 0x24972ef5274a577127dc871687e4bfe4bb4d512d810c025cbe01d87ca621c2d7::agent_policy {
    struct AgentPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        allowed_markets: vector<0x1::string::String>,
        allowed_assets: vector<0x1::string::String>,
        max_budget_usd_micros: u64,
        max_single_trade_usd_micros: u64,
        expires_at_ms: u64,
        requires_manual_approval: bool,
        revoked: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct PolicyReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: address,
        strategy_id: 0x1::string::String,
        audit_blob_id: 0x1::string::String,
        execution_digest: 0x1::string::String,
        created_at_ms: u64,
    }

    entry fun create_policy(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = AgentPolicy{
            id                          : 0x2::object::new(arg7),
            owner                       : v1,
            allowed_markets             : arg0,
            allowed_assets              : arg1,
            max_budget_usd_micros       : arg2,
            max_single_trade_usd_micros : arg3,
            expires_at_ms               : arg4,
            requires_manual_approval    : arg5,
            revoked                     : false,
            created_at_ms               : v0,
            updated_at_ms               : v0,
        };
        0x2::transfer::public_transfer<AgentPolicy>(v2, v1);
    }

    entry fun record_strategy_receipt(arg0: &AgentPolicy, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 1);
        assert!(!arg0.revoked, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = PolicyReceipt{
            id               : 0x2::object::new(arg5),
            owner            : v0,
            policy_id        : 0x2::object::uid_to_address(&arg0.id),
            strategy_id      : arg1,
            audit_blob_id    : arg2,
            execution_digest : arg3,
            created_at_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::public_transfer<PolicyReceipt>(v1, v0);
    }

    entry fun revoke_policy(arg0: &mut AgentPolicy, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.revoked = true;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    entry fun update_policy(arg0: &mut AgentPolicy, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg8), 1);
        assert!(!arg0.revoked, 2);
        arg0.allowed_markets = arg1;
        arg0.allowed_assets = arg2;
        arg0.max_budget_usd_micros = arg3;
        arg0.max_single_trade_usd_micros = arg4;
        arg0.expires_at_ms = arg5;
        arg0.requires_manual_approval = arg6;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
    }

    // decompiled from Move bytecode v7
}

