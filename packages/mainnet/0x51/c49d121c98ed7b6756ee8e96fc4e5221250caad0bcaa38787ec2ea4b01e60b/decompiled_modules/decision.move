module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::decision {
    struct DECISION has drop {
        dummy_field: bool,
    }

    struct DecisionPayload has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
        nonce: u64,
    }

    struct ActionIntent has copy, drop {
        schema_version: u16,
        chain_id: vector<u8>,
        treasury_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        nonce: u64,
        expires_at_ms: u64,
        action_kind: u8,
        protocol_id: u8,
        asset_type: vector<u8>,
        amount: u64,
        min_health_factor_bps: u64,
        max_protocol_exposure: u64,
        policy_hash: vector<u8>,
        input_hash: vector<u8>,
        rationale_hash: vector<u8>,
    }

    struct DecisionRegistry has key {
        id: 0x2::object::UID,
        last_nonce: 0x2::table::Table<0x2::object::ID, u64>,
    }

    fun assert_intent_valid<T0>(arg0: &ActionIntent, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg0.treasury_id == 0x2::object::id<0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>>(arg1), 13906835196546121737);
        assert!(arg0.agent_cap_id == 0x2::object::id<0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>>(arg2), 13906835200841220107);
        assert!(arg0.expires_at_ms >= 0x2::clock::timestamp_ms(arg3), 13906835205136318477);
        assert!(arg0.action_kind == 0, 13906835209431416847);
    }

    fun build_intent(arg0: u16, arg1: vector<u8>, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>) : ActionIntent {
        ActionIntent{
            schema_version        : arg0,
            chain_id              : arg1,
            treasury_id           : 0x2::object::id_from_address(arg2),
            agent_cap_id          : 0x2::object::id_from_address(arg3),
            nonce                 : arg4,
            expires_at_ms         : arg5,
            action_kind           : arg6,
            protocol_id           : arg7,
            asset_type            : arg8,
            amount                : arg9,
            min_health_factor_bps : arg10,
            max_protocol_exposure : arg11,
            policy_hash           : arg12,
            input_hash            : arg13,
            rationale_hash        : arg14,
        }
    }

    fun consume_nonce(arg0: &mut DecisionRegistry, arg1: 0x2::object::ID, arg2: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.last_nonce, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.last_nonce, arg1);
            assert!(arg2 > *v0, 13906836570935525383);
            *v0 = arg2;
        } else {
            assert!(arg2 > 0, 13906836583820427271);
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_nonce, arg1, arg2);
        };
    }

    public fun execute_decision<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>>(arg1);
        let v1 = DecisionPayload{
            treasury : v0,
            amount   : arg4,
            nonce    : arg5,
        };
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<DECISION, DecisionPayload>(arg2, 0, arg6, v1, &arg7), 13906834698329653253);
        consume_nonce(arg0, v0, arg5);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg1, arg3, arg4, arg8, arg9)
    }

    public(friend) fun execute_verified<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg3: ActionIntent, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_intent_valid<T0>(&arg3, arg1, arg2, arg4);
        assert!(arg3.protocol_id == 255, 13906835273856057361);
        consume_nonce(arg0, arg3.treasury_id, arg3.nonce);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::mock_supply::supply_and_custody<T0>(arg1, arg2, arg3.amount, arg4, arg5);
    }

    public(friend) fun execute_verified_navi<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg3: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg6: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::Incentive, arg7: u8, arg8: ActionIntent, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_intent_valid<T0>(&arg8, arg1, arg2, arg9);
        assert!(arg8.protocol_id == 2, 13906835617453441041);
        consume_nonce(arg0, arg8.treasury_id, arg8.nonce);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::navi_adapter::supply_and_custody<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8.amount, arg9, arg10);
    }

    public(friend) fun execute_verified_scallop<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: ActionIntent, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_intent_valid<T0>(&arg5, arg1, arg2, arg6);
        assert!(arg5.protocol_id == 1, 13906835480014487569);
        consume_nonce(arg0, arg5.treasury_id, arg5.nonce);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::scallop_adapter::supply_and_custody<T0>(arg1, arg2, arg3, arg4, arg5.amount, arg6, arg7);
    }

    public(friend) fun execute_verified_suilend<T0, T1>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T1>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T1>, arg3: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::LendingMarket<T0>, arg4: u64, arg5: ActionIntent, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_intent_valid<T1>(&arg5, arg1, arg2, arg6);
        assert!(arg5.protocol_id == 0, 13906835359755403281);
        consume_nonce(arg0, arg5.treasury_id, arg5.nonce);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::suilend_adapter::supply_and_custody<T0, T1>(arg1, arg2, arg3, arg4, arg5.amount, arg6, arg7);
    }

    fun init(arg0: DECISION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Cap<DECISION>>(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::new_cap<DECISION>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = DecisionRegistry{
            id         : 0x2::object::new(arg1),
            last_nonce : 0x2::table::new<0x2::object::ID, u64>(arg1),
        };
        0x2::transfer::share_object<DecisionRegistry>(v0);
    }

    public fun verified_supply<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: ActionIntent, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<DECISION, ActionIntent>(arg2, 0, arg5, arg4, &arg6), 13906834809998802949);
        execute_verified<T0>(arg0, arg1, arg3, arg4, arg7, arg8);
    }

    public fun verified_supply_entry<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: u16, arg5: vector<u8>, arg6: address, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: u64, arg20: vector<u8>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        verified_supply<T0>(arg0, arg1, arg2, arg3, build_intent(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18), arg19, arg20, arg21, arg22);
    }

    public fun verified_supply_navi<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg6: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg7: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::Incentive, arg8: u8, arg9: ActionIntent, arg10: u64, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<DECISION, ActionIntent>(arg2, 0, arg10, arg9, &arg11), 13906835132121350149);
        execute_verified_navi<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    public fun verified_supply_navi_entry<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg6: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg7: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::Incentive, arg8: u8, arg9: u16, arg10: vector<u8>, arg11: address, arg12: address, arg13: u64, arg14: u64, arg15: u8, arg16: u8, arg17: vector<u8>, arg18: u64, arg19: u64, arg20: u64, arg21: vector<u8>, arg22: vector<u8>, arg23: vector<u8>, arg24: u64, arg25: vector<u8>, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        verified_supply_navi<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, build_intent(arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23), arg24, arg25, arg26, arg27);
    }

    public fun verified_supply_scallop<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: ActionIntent, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<DECISION, ActionIntent>(arg2, 0, arg7, arg6, &arg8), 13906835020452200453);
        execute_verified_scallop<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg9, arg10);
    }

    public fun verified_supply_scallop_entry<T0>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: u16, arg7: vector<u8>, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: u8, arg13: u8, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: u64, arg22: vector<u8>, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        verified_supply_scallop<T0>(arg0, arg1, arg2, arg3, arg4, arg5, build_intent(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20), arg21, arg22, arg23, arg24);
    }

    public fun verified_supply_suilend<T0, T1>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T1>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T1>, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::LendingMarket<T0>, arg5: u64, arg6: ActionIntent, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::verify_signature<DECISION, ActionIntent>(arg2, 0, arg7, arg6, &arg8), 13906834917372985349);
        execute_verified_suilend<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg9, arg10);
    }

    public fun verified_supply_suilend_entry<T0, T1>(arg0: &mut DecisionRegistry, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T1>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::enclave::Enclave<DECISION>, arg3: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T1>, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::LendingMarket<T0>, arg5: u64, arg6: u16, arg7: vector<u8>, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: u8, arg13: u8, arg14: vector<u8>, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: u64, arg22: vector<u8>, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        verified_supply_suilend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, build_intent(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20), arg21, arg22, arg23, arg24);
    }

    // decompiled from Move bytecode v7
}

