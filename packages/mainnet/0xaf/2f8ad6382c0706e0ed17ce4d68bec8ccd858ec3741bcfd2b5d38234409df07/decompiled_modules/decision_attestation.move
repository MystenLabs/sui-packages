module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::decision_attestation {
    struct DecisionAttestation has store, key {
        id: 0x2::object::UID,
        borrower_id: 0x1::string::String,
        model_version: 0x1::string::String,
        decision: 0x1::string::String,
        confidence_score: u64,
        approved_loan_amount: u64,
        approved_interest_rate: u64,
        fairness_score: u64,
        fairness_check_passed: bool,
        features_hash: vector<u8>,
        timestamp: u64,
        decision_maker: address,
    }

    struct DecisionAttested has copy, drop {
        decision_id: address,
        borrower_id: 0x1::string::String,
        model_version: 0x1::string::String,
        decision: 0x1::string::String,
        confidence_score: u64,
        fairness_score: u64,
        timestamp: u64,
    }

    public entry fun create_decision_attestation(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == true, 1);
        assert!(arg6 >= 9000, 2);
        let v0 = DecisionAttestation{
            id                     : 0x2::object::new(arg9),
            borrower_id            : 0x1::string::utf8(arg0),
            model_version          : 0x1::string::utf8(arg1),
            decision               : 0x1::string::utf8(arg2),
            confidence_score       : arg3,
            approved_loan_amount   : arg4,
            approved_interest_rate : arg5,
            fairness_score         : arg6,
            fairness_check_passed  : arg7,
            features_hash          : arg8,
            timestamp              : 0x2::tx_context::epoch_timestamp_ms(arg9),
            decision_maker         : 0x2::tx_context::sender(arg9),
        };
        let v1 = DecisionAttested{
            decision_id      : 0x2::object::uid_to_address(&v0.id),
            borrower_id      : 0x1::string::utf8(arg0),
            model_version    : 0x1::string::utf8(arg1),
            decision         : 0x1::string::utf8(arg2),
            confidence_score : arg3,
            fairness_score   : arg6,
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg9),
        };
        0x2::event::emit<DecisionAttested>(v1);
        0x2::transfer::public_share_object<DecisionAttestation>(v0);
    }

    public fun fairness_check_passed(arg0: &DecisionAttestation) : bool {
        arg0.fairness_check_passed
    }

    public fun get_approved_amount(arg0: &DecisionAttestation) : u64 {
        arg0.approved_loan_amount
    }

    public fun get_approved_rate(arg0: &DecisionAttestation) : u64 {
        arg0.approved_interest_rate
    }

    public fun get_borrower_id(arg0: &DecisionAttestation) : 0x1::string::String {
        arg0.borrower_id
    }

    public fun get_confidence_score(arg0: &DecisionAttestation) : u64 {
        arg0.confidence_score
    }

    public fun get_decision(arg0: &DecisionAttestation) : 0x1::string::String {
        arg0.decision
    }

    public fun get_fairness_score(arg0: &DecisionAttestation) : u64 {
        arg0.fairness_score
    }

    public fun get_features_hash(arg0: &DecisionAttestation) : vector<u8> {
        arg0.features_hash
    }

    public fun get_model_version(arg0: &DecisionAttestation) : 0x1::string::String {
        arg0.model_version
    }

    public fun get_timestamp(arg0: &DecisionAttestation) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

