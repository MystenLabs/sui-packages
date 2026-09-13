module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::oracle {
    struct FieldValue has copy, drop, store {
        name: 0x1::string::String,
        value: u64,
    }

    struct EvaluationPayload has copy, drop, store {
        target_id: 0x2::object::ID,
        match_id: 0x1::string::String,
        player_game_id: 0x1::string::String,
        game_type: 0x1::string::String,
        fields: vector<FieldValue>,
        timestamp: u64,
    }

    struct ChallengeEvaluated has copy, drop {
        challenge_id: 0x2::object::ID,
        match_id: 0x1::string::String,
        player_game_id: 0x1::string::String,
        game_type: 0x1::string::String,
        fields: vector<FieldValue>,
        multiplier: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    struct TournamentEvaluated has copy, drop {
        tournament_id: 0x2::object::ID,
        match_id: 0x1::string::String,
        player_game_id: 0x1::string::String,
        game_type: 0x1::string::String,
        fields: vector<FieldValue>,
        multiplier: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    struct ParticipantEvaluatedByOracle has copy, drop {
        tournament_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        match_id: 0x1::string::String,
        player_game_id: 0x1::string::String,
        game_type: 0x1::string::String,
        fields: vector<FieldValue>,
        score: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    public fun assert_target_matches(arg0: &EvaluationPayload, arg1: 0x2::object::ID) {
        assert!(arg0.target_id == arg1, 4);
    }

    fun build_fields(arg0: vector<0x1::string::String>, arg1: vector<u64>) : vector<FieldValue> {
        let v0 = 0x1::vector::empty<FieldValue>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = FieldValue{
                name  : *0x1::vector::borrow<0x1::string::String>(&arg0, v1),
                value : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x1::vector::push_back<FieldValue>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun build_permit_message(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::network_id());
        0x1::vector::append<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::original_package_id_bytes());
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    fun build_signature_message(arg0: &0x2::object::ID, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<0x1::string::String>, arg5: &vector<u64>, arg6: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"5a4e4b3a4f52433a534554544c453a563100");
        0x1::vector::push_back<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::network_id());
        0x1::vector::append<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::original_package_id_bytes());
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg3));
        0x1::vector::append<u8>(&mut v0, hash_fields(arg4, arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        v0
    }

    public(friend) fun emit_challenge_evaluated(arg0: 0x2::object::ID, arg1: &EvaluationPayload, arg2: u64, arg3: vector<u8>) {
        let v0 = ChallengeEvaluated{
            challenge_id   : arg0,
            match_id       : arg1.match_id,
            player_game_id : arg1.player_game_id,
            game_type      : arg1.game_type,
            fields         : arg1.fields,
            multiplier     : arg2,
            oracle_pubkey  : arg3,
            timestamp      : arg1.timestamp,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ChallengeEvaluated>(v0);
    }

    public(friend) fun emit_participant_evaluated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &EvaluationPayload, arg3: u64, arg4: vector<u8>) {
        let v0 = ParticipantEvaluatedByOracle{
            tournament_id  : arg0,
            account_id     : arg1,
            match_id       : arg2.match_id,
            player_game_id : arg2.player_game_id,
            game_type      : arg2.game_type,
            fields         : arg2.fields,
            score          : arg3,
            oracle_pubkey  : arg4,
            timestamp      : arg2.timestamp,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ParticipantEvaluatedByOracle>(v0);
    }

    public(friend) fun emit_tournament_evaluated(arg0: 0x2::object::ID, arg1: &EvaluationPayload, arg2: u64, arg3: vector<u8>) {
        let v0 = TournamentEvaluated{
            tournament_id  : arg0,
            match_id       : arg1.match_id,
            player_game_id : arg1.player_game_id,
            game_type      : arg1.game_type,
            fields         : arg1.fields,
            multiplier     : arg2,
            oracle_pubkey  : arg3,
            timestamp      : arg1.timestamp,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<TournamentEvaluated>(v0);
    }

    public fun get_field_or_default(arg0: &EvaluationPayload, arg1: &0x1::string::String, arg2: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FieldValue>(&arg0.fields)) {
            let v1 = 0x1::vector::borrow<FieldValue>(&arg0.fields, v0);
            if (&v1.name == arg1) {
                return v1.value
            };
            v0 = v0 + 1;
        };
        arg2
    }

    fun hash_fields(arg0: &vector<0x1::string::String>, arg1: &vector<u64>) : vector<u8> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::u64::max(0x1::vector::length<0x1::string::String>(arg0), 1) - 1) {
            if (!is_bytes_less_than(0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, v0)), 0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, v0 + 1)))) {
                v1 = false;
                /* label 4 */
                assert!(v1, 9);
                let v2 = b"";
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x1::string::String>(arg0)) {
                    0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(0x1::vector::borrow<0x1::string::String>(arg0, v3)));
                    0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg1, v3)));
                    v3 = v3 + 1;
                };
                return 0x2::hash::keccak256(&v2)
            };
            v0 = v0 + 1;
        };
        v1 = true;
        /* goto 4 */
    }

    fun is_bytes_less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 < v4) {
                return true
            };
            if (v3 > v4) {
                return false
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    fun join_permit_action_bytes(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<0x1::string::String>>(&arg2));
        v0
    }

    public fun match_id(arg0: &EvaluationPayload) : &0x1::string::String {
        &arg0.match_id
    }

    public fun new_field(arg0: 0x1::string::String, arg1: u64) : FieldValue {
        FieldValue{
            name  : arg0,
            value : arg1,
        }
    }

    fun validate_oracle_timestamp(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg2 <= v0 + 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::oracle_clock_skew_ms(arg0), 8);
        assert!(v0 <= arg2 + 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::oracle_signature_age_ms(arg0), 7);
    }

    public fun verify_and_build_payload(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<u64>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>) : EvaluationPayload {
        assert!(0x1::vector::length<u8>(&arg10) == 64, 2);
        assert!(0x1::vector::length<u8>(&arg11) == 33, 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == 0x1::vector::length<u64>(&arg8), 6);
        assert!(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::is_oracle_authorized(arg0, arg11), 1);
        validate_oracle_timestamp(arg1, arg2, arg9);
        let v0 = build_signature_message(&arg3, &arg4, &arg5, &arg6, &arg7, &arg8, arg9);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg10, &arg11, &v0, 1), 0);
        EvaluationPayload{
            target_id      : arg3,
            match_id       : arg4,
            player_game_id : arg5,
            game_type      : arg6,
            fields         : build_fields(arg7, arg8),
            timestamp      : arg9,
        }
    }

    public fun verify_challenge_create_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a4348413a4352454154453a563100", arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun verify_challenge_create_vault_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a4348413a4352454154453a5641554c543a563100", arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun verify_join_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a54524e3a4a4f494e3a563100", arg3, join_permit_action_bytes(arg4, arg5, arg6), arg7, arg8, arg9, arg10);
    }

    public fun verify_join_vault_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a54524e3a4a4f494e3a5641554c543a563100", arg3, join_permit_action_bytes(arg4, arg5, arg6), arg7, arg8, arg9, arg10);
    }

    fun verify_permit_internal(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg8) == 64, 2);
        assert!(0x1::vector::length<u8>(&arg9) == 33, 3);
        assert!(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::is_oracle_authorized(arg0, arg9), 1);
        validate_oracle_timestamp(arg1, arg2, arg7);
        let v0 = build_permit_message(arg3, arg4, arg5, arg6, arg7);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg8, &arg9, &v0, 1), 0);
    }

    public fun verify_platform_bind_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<0x1::string::String>(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg5));
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a504c543a42494e443a563100", arg3, v0, arg6, arg7, arg8, arg9);
    }

    public fun verify_platform_claim_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<0x1::string::String>(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg5));
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a504c543a434c41494d3a563100", arg3, v0, arg6, arg7, arg8, arg9);
    }

    public fun verify_sponsorship_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = 0x2::object::id_to_bytes(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a53504f3a4144443a563100", arg3, v0, arg6, arg7, arg8, arg9);
    }

    public fun verify_tournament_create_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a54524e3a4352454154453a563100", arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun verify_tournament_create_vault_permit(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>) {
        verify_permit_internal(arg0, arg1, arg2, x"5a4e4b3a54524e3a4352454154453a5641554c543a563100", arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

