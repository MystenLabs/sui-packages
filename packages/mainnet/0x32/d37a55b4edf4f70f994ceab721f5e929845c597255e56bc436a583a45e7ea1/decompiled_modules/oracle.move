module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::oracle {
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

    fun build_signature_message(arg0: &0x2::object::ID, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<0x1::string::String>, arg5: &vector<u64>, arg6: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, hash_fields(arg4, arg5));
        0x1::vector::append<u8>(&mut v0, u64_to_le_bytes(arg6));
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
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ChallengeEvaluated>(v0);
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
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ParticipantEvaluatedByOracle>(v0);
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
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<TournamentEvaluated>(v0);
    }

    public fun field_name(arg0: &FieldValue) : &0x1::string::String {
        &arg0.name
    }

    public fun field_value(arg0: &FieldValue) : u64 {
        arg0.value
    }

    public fun fields(arg0: &EvaluationPayload) : &vector<FieldValue> {
        &arg0.fields
    }

    public fun game_type(arg0: &EvaluationPayload) : &0x1::string::String {
        &arg0.game_type
    }

    public fun get_field(arg0: &EvaluationPayload, arg1: &0x1::string::String) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FieldValue>(&arg0.fields)) {
            let v1 = 0x1::vector::borrow<FieldValue>(&arg0.fields, v0);
            if (&v1.name == arg1) {
                return v1.value
            };
            v0 = v0 + 1;
        };
        abort 5
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

    public fun has_field(arg0: &EvaluationPayload, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FieldValue>(&arg0.fields)) {
            if (&0x1::vector::borrow<FieldValue>(&arg0.fields, v0).name == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun hash_fields(arg0: &vector<0x1::string::String>, arg1: &vector<u64>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, v1)));
            0x1::vector::append<u8>(&mut v0, u64_to_le_bytes(*0x1::vector::borrow<u64>(arg1, v1)));
            v1 = v1 + 1;
        };
        0x2::hash::keccak256(&v0)
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

    public fun player_game_id(arg0: &EvaluationPayload) : &0x1::string::String {
        &arg0.player_game_id
    }

    public fun target_id(arg0: &EvaluationPayload) : 0x2::object::ID {
        arg0.target_id
    }

    public fun timestamp(arg0: &EvaluationPayload) : u64 {
        arg0.timestamp
    }

    fun u64_to_le_bytes(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun validate_oracle_timestamp(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::ConfigStore, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg2 <= v0 + 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::oracle_clock_skew_ms(arg0), 8);
        assert!(v0 <= arg2 + 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::oracle_signature_age_ms(arg0), 7);
    }

    public fun verify_and_build_payload(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::ConfigStore, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<u64>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>) : EvaluationPayload {
        assert!(0x1::vector::length<u8>(&arg10) == 64, 2);
        assert!(0x1::vector::length<u8>(&arg11) == 33, 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg7) == 0x1::vector::length<u64>(&arg8), 6);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::is_oracle_authorized(arg0, arg11), 1);
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

    // decompiled from Move bytecode v7
}

