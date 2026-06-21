module 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision {
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
        adapters: 0x2::table::Table<u8, 0x1::type_name::TypeName>,
    }

    public fun adapter_registered(arg0: &DecisionRegistry, arg1: u8) : bool {
        0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg0.adapters, arg1)
    }

    fun assert_intent_valid<T0>(arg0: &ActionIntent, arg1: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg2: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg0.treasury_id == 0x2::object::id<0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>>(arg1), 13906834956027756550);
        assert!(arg0.agent_cap_id == 0x2::object::id<0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T0>>(arg2), 13906834960322854920);
        assert!(arg0.expires_at_ms >= 0x2::clock::timestamp_ms(arg3), 13906834964617953290);
        assert!(arg0.action_kind == 0, 13906834968913051660);
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
            assert!(arg2 > *v0, 13906835162186055684);
            *v0 = arg2;
        } else {
            assert!(arg2 > 0, 13906835175070957572);
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.last_nonce, arg1, arg2);
        };
    }

    fun init(arg0: DECISION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Cap<DECISION>>(0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::new_cap<DECISION>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = DecisionRegistry{
            id         : 0x2::object::new(arg1),
            last_nonce : 0x2::table::new<0x2::object::ID, u64>(arg1),
            adapters   : 0x2::table::new<u8, 0x1::type_name::TypeName>(arg1),
        };
        0x2::transfer::share_object<DecisionRegistry>(v0);
    }

    public fun register_adapter<T0: drop>(arg0: &mut DecisionRegistry, arg1: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Cap<DECISION>, arg2: u8) {
        if (0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg0.adapters, arg2)) {
            *0x2::table::borrow_mut<u8, 0x1::type_name::TypeName>(&mut arg0.adapters, arg2) = 0x1::type_name::get<T0>();
        } else {
            0x2::table::add<u8, 0x1::type_name::TypeName>(&mut arg0.adapters, arg2, 0x1::type_name::get<T0>());
        };
    }

    public fun verified_release<T0, T1: drop>(arg0: T1, arg1: &mut DecisionRegistry, arg2: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg3: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Enclave<DECISION>, arg4: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T0>, arg5: u16, arg6: vector<u8>, arg7: address, arg8: address, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: vector<u8>, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: vector<u8>, arg19: vector<u8>, arg20: u64, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::ReleaseTicket) {
        let v0 = build_intent(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        assert!(0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::verify_signature<DECISION, ActionIntent>(arg3, 0, arg20, v0, &arg21), 13906834848653312002);
        assert_intent_valid<T0>(&v0, arg2, arg4, arg22);
        assert!(0x2::table::contains<u8, 0x1::type_name::TypeName>(&arg1.adapters, v0.protocol_id), 13906834878718869518);
        assert!(*0x2::table::borrow<u8, 0x1::type_name::TypeName>(&arg1.adapters, v0.protocol_id) == 0x1::type_name::get<T1>(), 13906834883013967888);
        consume_nonce(arg1, v0.treasury_id, v0.nonce);
        0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::release_with_ticket<T0>(arg2, arg4, v0.protocol_id, v0.amount, arg22, arg23)
    }

    // decompiled from Move bytecode v7
}

