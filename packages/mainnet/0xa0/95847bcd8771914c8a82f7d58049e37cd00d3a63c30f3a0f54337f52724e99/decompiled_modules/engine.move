module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::engine {
    struct PayerTerms has copy, drop {
        hash: address,
        bytes: vector<u8>,
    }

    struct Decided has copy, drop {
        verdict: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Verdict,
        terms_hash: 0x1::option::Option<address>,
        refused_by: 0x1::option::Option<0x1::string::String>,
    }

    fun parse_terms(arg0: vector<u8>) : vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes> {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            return 0x1::vector::empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>()
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(arg0);
        let v1 = 0x1::vector::empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>();
        let v2 = 0;
        while (v2 < 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::uleb(&mut v0) && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::failed(&v0)) {
            0x1::vector::push_back<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(&mut v1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::bytes(&mut v0)));
            v2 = v2 + 1;
        };
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0), 8);
        v1
    }

    fun chain_attempts(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::ChainAttempts {
        let v0 = false;
        let v1 = 1;
        while (v1 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1)) {
            if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::attempts_used(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, v1)) >= 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::attempt_quota(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, v1))) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::chain_attempts(v0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::holds_place(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::holder(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1) - 1))))
    }

    public fun admit_grant(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_grant_or_abort(arg1);
        let v1 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parsed_grant_record(&v0);
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v1)), 8);
        let v2 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v1));
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v2), 6);
        let v3 = 0x1::option::none<0x1::string::String>();
        check_grant_schema(&v1);
        check_effectors_once(&v1);
        check_floor_effectors(&v1);
        let v4 = parse_terms(arg2);
        check_terms_beside(&v1, &v4);
        if (arg3 == 0) {
            let v5 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::attest(arg0, arg4);
            assert!(0x1::option::is_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(&v5), 5);
            let v6 = 0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(v5);
            let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_mint(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v6)));
            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord>(&v7), 5);
            let v8 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord>(v7);
            let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::minted_grant(&v8, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v6), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::assertion(&v6));
            assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_bytes(&v9) == arg1, 5);
        } else if (arg3 == 1) {
            assert!(0x1::option::is_none<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1)), 5);
            verify_grant_signature(&v0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(&v1));
        } else if (arg3 == 2 && !0x1::vector::is_empty<u8>(&arg4)) {
            let v10 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::attest(arg0, arg4);
            assert!(0x1::option::is_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(&v10), 5);
            let v11 = 0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(v10);
            let v12 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_standing(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v11)));
            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::StandingRecord>(&v12), 5);
            let v13 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::StandingRecord>(v12);
            let v14 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_grant_of(&v13, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v11), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::assertion(&v11));
            let v15 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_id(&v14));
            assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1)) && *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1)) == v15, 5);
            assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_minted_by(&v1)) && *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_minted_by(&v1)) == 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v11), 5);
            assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::is_retired_unseen(arg0, v15), 5);
            verify_grant_signature(&v0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(&v1));
            check_standing_narrowing(&v1, &v14);
            v3 = 0x1::option::some<0x1::string::String>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_template_class(&v14));
        } else {
            assert!(arg3 == 2, 8);
            abort 5
        };
        let v16 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1);
        if (0x1::option::is_none<address>(&v16)) {
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::note_root(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(&v1)) || arg3 != 1, 5);
        };
        finish_admission(arg0, v1, v2, v16, v3, v4, arg5);
    }

    public fun admit_sub_grant(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_grant_or_abort(arg2);
        let v1 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parsed_grant_record(&v0);
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v1)), 8);
        let v2 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v1));
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v2), 6);
        check_grant_schema(&v1);
        check_effectors_once(&v1);
        check_floor_effectors(&v1);
        let v3 = parse_terms(arg3);
        check_terms_beside(&v1, &v3);
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1)), 5);
        let v4 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_narrows(&v1));
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v4), 5);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(arg1) == v4 && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::grant_object(arg0, v4) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1), 8);
        verify_grant_signature(&v0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg1)));
        check_narrowing(&v1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg1));
        check_terms_narrowing(&v1, &v3, arg1);
        finish_admission(arg0, v1, v2, 0x1::option::some<address>(v4), 0x1::option::none<0x1::string::String>(), v3, arg4);
    }

    public fun attestation_helm() : u8 {
        0
    }

    public fun attestation_holder() : u8 {
        1
    }

    public fun attestation_narrowing() : u8 {
        2
    }

    fun attested_or_abort(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>) : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::attest(arg0, arg1);
        assert!(0x1::option::is_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(&v0), 5);
        0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::AttestedDecision>(v0)
    }

    fun available_along(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::available(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, 0));
        let v1 = 1;
        while (v1 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0)) {
            let v2 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::available(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, v1));
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v0, &v2);
            if (0x1::option::is_some<u8>(&v3) && 0x1::option::destroy_some<u8>(v3) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun before_decision(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : address {
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(arg4)), 8);
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_gas_budget(arg3) > 0, 8);
        let v0 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(arg4));
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg2);
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::nonce_consumed(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v1)) && !chain_consumed(arg5, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v1)), 1);
        check_chain(arg0, arg5, v0);
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_bytes(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg5, 0))) == *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::grant(arg2), 7);
        let v2 = view_of(arg5);
        check_view(&v2, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg2));
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::required_for(arg3, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v1));
        if (!0x1::vector::is_empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v3)) {
            let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::try_hex(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::resolver_key(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg2)));
            assert!(0x1::option::is_some<vector<u8>>(&v4) && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_resolver_key(arg0, 0x1::option::borrow<vector<u8>>(&v4)), 7);
        };
        check_clock(arg2, arg1);
        v0
    }

    fun before_of(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Verdict) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::budget_before(arg1);
        if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0))
        } else {
            *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_available(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0))
        }
    }

    fun by_framework(arg0: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Verdict) : Decided {
        Decided{
            verdict    : arg0,
            terms_hash : 0x1::option::none<address>(),
            refused_by : 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"framework")),
        }
    }

    fun chain_consumed(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0)) {
            if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::consumed_hidden(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, v0), arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun check_chain(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg2: address) {
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, arg2), 3);
        assert!(!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1) && 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1) <= 8, 8);
        let v0 = 0;
        loop {
            let v1 = 0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, v0);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(v1) == arg2, 8);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::grant_object(arg0, arg2) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(v1), 8);
            let v2 = *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::parent(v1);
            let v3 = if (0x1::option::is_none<address>(&v2)) {
                0x1::option::none<address>()
            } else {
                let v4 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::resolve(arg0, 0x1::option::destroy_some<address>(v2));
                if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v4)) {
                    0x1::option::some<address>(v4)
                } else {
                    0x1::option::none<address>()
                }
            };
            let v5 = v3;
            v0 = v0 + 1;
            if (0x1::option::is_none<address>(&v5)) {
                assert!(v0 == 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1), 8);
                return
            };
            if (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1)) {
                arg2 = 0x1::option::destroy_some<address>(v5);
            } else {
                break
            };
        };
        abort 8
    }

    fun check_clock(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg1: &0x2::clock::Clock) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::now(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            assert!(0x1::option::destroy_some<u64>(v0) / 1000000 == 0x2::clock::timestamp_ms(arg1), 9);
        };
    }

    fun check_effectors_once(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0)) {
            let v2 = v1 + 1;
            while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0)) {
                assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0, v1)) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0, v2)), 10);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun check_floor_effectors(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        if (0x1::option::is_none<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg0))) {
            return
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0)) {
            let v2 = 0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0, v1)));
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
            let v4 = if (v2 == &v3) {
                true
            } else {
                let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id();
                v2 == &v5
            };
            assert!(v4, 8);
            v1 = v1 + 1;
        };
    }

    fun check_floor_narrowing(arg0: &0x1::option::Option<u64>, arg1: &0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg1)) {
            assert!(0x1::option::is_some<u64>(arg0), 5);
            assert!(*0x1::option::borrow<u64>(arg0) >= *0x1::option::borrow<u64>(arg1), 5);
        } else {
            assert!(0x1::option::is_none<u64>(arg0), 5);
        };
    }

    fun check_grant_schema(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(arg0)), 8);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_signature(arg0)), 8);
        assert!(0x1::vector::is_empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::DependencyClause>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_requires(arg0)), 8);
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_allowed_kinds(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v0)) {
            assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::kind_grantable(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v0, v1)), 8);
            v1 = v1 + 1;
        };
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(arg0));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v2), 8);
        if (0x1::option::is_some<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg0))) {
            let v3 = *0x1::option::borrow<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg0));
            assert!(v3 >= 1 && v3 <= 10000, 8);
        };
    }

    fun check_narrowing(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_room_id(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_room_id(arg1), 5);
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(arg1));
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(arg0));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1) && 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0), 8);
        let v2 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        let v3 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v2, &v3);
        assert!(0x1::option::is_some<u8>(&v4) && 0x1::option::destroy_some<u8>(v4) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater(), 5);
        check_floor_narrowing(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg1));
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_attempt_quota(arg0) <= 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_attempt_quota(arg1), 5);
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg1));
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg0));
        let v7 = if (0x1::option::is_some<u64>(&v6)) {
            if (0x1::option::is_some<u64>(&v5)) {
                0x1::option::destroy_some<u64>(v6) <= 0x1::option::destroy_some<u64>(v5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 5);
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v8)) {
            let v10 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v8, v9);
            assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_carries(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v10), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_connector(v10)), 5);
            v9 = v9 + 1;
        };
        let v11 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_allowed_kinds(arg0);
        let v12 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_allowed_kinds(arg1);
        v9 = 0;
        while (v9 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v11)) {
            assert!(0x1::vector::contains<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v12, 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(v11, v9)), 5);
            v9 = v9 + 1;
        };
    }

    fun check_reservation(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation) {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1));
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_reservation(arg0, v0), 2);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::reservation_object(arg0, v0) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(arg1), 8);
    }

    fun check_standing_narrowing(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::StandingRecord) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_value_cap(arg1));
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(arg0));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1) && 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0), 8);
        let v2 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        let v3 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v2, &v3);
        assert!(0x1::option::is_some<u8>(&v4) && 0x1::option::destroy_some<u8>(v4) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater(), 5);
        check_floor_narrowing(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_floor_bps(arg1));
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_effectors(arg1);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v6)) {
            assert!(0x1::vector::contains<0x1::string::String>(v5, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v6, v7))), 5);
            v7 = v7 + 1;
        };
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_attempt_quota(arg0) <= 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_attempt_quota_per_room(arg1), 5);
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::standing_expiry(arg1));
        let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg0));
        let v10 = if (0x1::option::is_some<u64>(&v9)) {
            if (0x1::option::is_some<u64>(&v8)) {
                0x1::option::destroy_some<u64>(v9) <= 0x1::option::destroy_some<u64>(v8)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 5);
    }

    fun check_terms_beside(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg1: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0)) {
            let v2 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0, v1);
            if (0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v2))) {
                let v3 = terms_of(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2));
                assert!(0x1::option::is_some<vector<u8>>(&v3), 5);
                assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(0x1::option::borrow<vector<u8>>(&v3)) == *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v2)), 5);
            };
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(arg1)) {
            let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_terms_hash(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_effector(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(arg1, v1)));
            assert!(0x1::option::is_some<address>(&v4), 8);
            v1 = v1 + 1;
        };
    }

    fun check_terms_narrowing(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg1: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>, arg2: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0)) {
            let v2 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v0, v1);
            if (0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v2))) {
                let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_terms_hash(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg2), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2));
                assert!(0x1::option::is_some<address>(&v3), 5);
                if (0x1::option::destroy_some<address>(v3) != *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v2))) {
                    let v4 = terms_of(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2));
                    let v5 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_for(arg2, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2));
                    assert!(0x1::option::is_some<vector<u8>>(&v4) && 0x1::option::is_some<vector<u8>>(&v5), 5);
                    let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
                    if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2)) == &v6) {
                        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::parse_terms(0x1::option::destroy_some<vector<u8>>(v5));
                        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::parse_terms(0x1::option::destroy_some<vector<u8>>(v4));
                        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(&v8) && 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(&v7), 5);
                        let v9 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(v8);
                        let v10 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(v7);
                        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::narrows(&v9, &v10), 5);
                    } else {
                        let v11 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::id();
                        if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2)) == &v11) {
                            let v12 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::parse_terms(0x1::option::destroy_some<vector<u8>>(v5));
                            let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::parse_terms(0x1::option::destroy_some<vector<u8>>(v4));
                            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(&v13) && 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(&v12), 5);
                            let v14 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(v13);
                            let v15 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(v12);
                            assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::narrows(&v14, &v15), 5);
                        } else {
                            let v16 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::id();
                            assert!(0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v2)) == &v16, 5);
                            let v17 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::parse_terms(0x1::option::destroy_some<vector<u8>>(v5));
                            let v18 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::parse_terms(0x1::option::destroy_some<vector<u8>>(v4));
                            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(&v18) && 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(&v17), 5);
                            let v19 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(v18);
                            let v20 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(v17);
                            assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::narrows(&v19, &v20), 5);
                        };
                    };
                };
            };
            v1 = v1 + 1;
        };
    }

    fun check_view(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::BudgetView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BudgetArg) {
        let v0 = if (same_amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_value_cap(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_value_cap(arg1))) {
            if (same_amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_reserved(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_reserved(arg1))) {
                if (same_amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_spent(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_spent(arg1))) {
                    if (same_amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_available(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_available(arg1))) {
                        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_attempts_used(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempts_used(arg1)) {
                            if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_attempt_quota(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempt_quota(arg1)) {
                                0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_attempts_remaining(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempts_remaining(arg1)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
    }

    public fun close_stuck(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg2: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: u8, arg4: address, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        check_reservation(arg0, arg1);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_stuck(arg1), 4);
        let v0 = if (arg3 == 0) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::finalized()
        } else if (arg3 == 1) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::released()
        } else {
            assert!(arg3 == 2, 4);
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::refunded()
        };
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::close(arg1, v0, arg4);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1), 8);
        let v2 = &mut arg2;
        let v3 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        settle_chain(arg0, v2, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), &v3, arg3 != 1);
        give_back(arg2, arg6);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_closed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), v0, arg4);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::give(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::create(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun current_envelope(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: address) : address {
        let v0 = 0;
        let v1 = arg1;
        while (v0 < 8) {
            let v2 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::resolve(arg0, v1);
            if (v2 == arg1) {
                break
            };
            v1 = v2;
            v0 = v0 + 1;
        };
        v1
    }

    public fun decide_acceptance(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_acceptance(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0))), 8);
        let v1 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg4));
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_reservation(arg0, v1) && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::reservation_object(arg0, v1) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(arg4), 8);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::proposal(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg4)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal_hash(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 8);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::holder(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg4)) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 8);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(arg4), 4);
        let v2 = &mut arg3;
        let v3 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        if (decide_in(arg0, arg1, &v0, v2, &v3, arg5) && 0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)))) {
            let v4 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)));
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::bind_agreement(arg4, v4);
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::set_agreement(arg0, v4);
        };
        give_back(arg3, arg5);
    }

    public fun decide_agreement(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_input(arg2);
        let (v1, _, _) = parse_records(&v0);
        let v4 = v1;
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(&v4));
        assert!(!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_acceptance(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0))), 8);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::agreement(&v5)) && 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::agreement(&v5)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 8);
        assert!(0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0))), 8);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::binds(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0));
        assert!(!0x1::vector::is_empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v6) && 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v6) == 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&arg4), 8);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&arg4)) {
            let v8 = 0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&arg4, v7);
            let v9 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(v8));
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_reservation(arg0, v9) && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::reservation_object(arg0, v9) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(v8), 8);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::proposal(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(v8)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::bind_proposal(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v6, v7)), 8);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::holder(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(v8)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::bind_holder(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v6, v7)), 8);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::holder(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(v8)) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 8);
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(v8), 4);
            v7 = v7 + 1;
        };
        let v10 = &mut arg3;
        let v11 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        if (decide_in(arg0, arg1, &v0, v10, &v11, arg5)) {
            let v12 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)));
            let v13 = 0;
            while (v13 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&arg4)) {
                0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::bind_agreement(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&mut arg4, v13), v12);
                v13 = v13 + 1;
            };
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::set_agreement(arg0, v12);
        };
        while (!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&arg4)) {
            0x2::transfer::public_transfer<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(0x1::vector::pop_back<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&mut arg4), 0x2::tx_context::sender(arg5));
        };
        0x1::vector::destroy_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(arg4);
        give_back(arg3, arg5);
    }

    public fun decide_and_reserve(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        let v1 = &mut arg3;
        let v2 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        decide_in(arg0, arg1, &v0, v1, &v2, arg4);
        give_back(arg3, arg4);
    }

    fun decide_award_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>> {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let (v7, v8) = evaluate_award(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>(&v9)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>(v9);
            return 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>()
        };
        0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::with_record<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>(v9), record_of(arg2, &v5, &v3, v6, v11, arg4), before_of(arg2, &v10.verdict), v12))
    }

    fun decide_bid_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>> {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let (v7, v8) = evaluate_bid(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>(&v9)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>(v9);
            return 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>()
        };
        0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::with_record<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>(v9), record_of(arg2, &v5, &v3, v6, v11, arg4), before_of(arg2, &v10.verdict), v12))
    }

    fun decide_effect_free_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : bool {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let v7 = framework_verdict(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v7);
        let v9 = if (v8) {
            Decided{verdict: v7, terms_hash: 0x1::option::none<address>(), refused_by: 0x1::option::none<0x1::string::String>()}
        } else {
            by_framework(v7)
        };
        let v10 = v9;
        let (_, _) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        let v13 = if (v8) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(&v5)) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::leaves(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg2)))
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::free_place(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::holder(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3, 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3) - 1)));
            return v8
        };
        if (v8) {
            let v14 = 0;
            while (v14 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3)) {
                0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::consume_attempt(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3, v14));
                v14 = v14 + 1;
            };
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(&v5)) {
                0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::take_place(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::holder(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3, 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg3) - 1)));
            };
        };
        v8
    }

    public fun decide_hold(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>> {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        let v1 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        decide_hold_in(arg0, arg1, &v0, arg3, &v1)
    }

    fun decide_hold_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>> {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let (v7, v8) = evaluate_hold(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>(&v9)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>(v9);
            return 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>()
        };
        0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::with_record<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>(v9), record_of(arg2, &v5, &v3, v6, v11, arg4), before_of(arg2, &v10.verdict), v12))
    }

    fun decide_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>, arg5: &mut 0x2::tx_context::TxContext) : bool {
        let (v0, _, _) = parse_records(arg2);
        let v3 = v0;
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(&v3));
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::is_effect_free(&v4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg2)))) {
            return decide_effect_free_in(arg0, arg1, arg2, arg3, arg4)
        };
        let v5 = 0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg2)));
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
        if (v5 == &v6) {
            let v8 = decide_refund_in(arg0, arg1, arg2, arg3, arg4);
            use_approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(arg0, v8, arg3, arg5)
        } else {
            let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::id();
            if (v5 == &v9) {
                let v10 = decide_purchase_in(arg0, arg1, arg2, arg3, arg4);
                use_approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(arg0, v10, arg3, arg5)
            } else {
                let v11 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::id();
                if (v5 == &v11) {
                    let v12 = decide_hold_in(arg0, arg1, arg2, arg3, arg4);
                    use_approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(arg0, v12, arg3, arg5)
                } else {
                    let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::id();
                    if (v5 == &v13) {
                        let v14 = decide_bid_in(arg0, arg1, arg2, arg3, arg4);
                        use_approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(arg0, v14, arg3, arg5)
                    } else {
                        let v15 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id();
                        if (v5 == &v15) {
                            let v16 = decide_award_in(arg0, arg1, arg2, arg3, arg4);
                            use_approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(arg0, v16, arg3, arg5)
                        } else {
                            decide_unknown_in(arg0, arg1, arg2, arg3, arg4);
                            false
                        }
                    }
                }
            }
        }
    }

    public fun decide_purchase(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>> {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        let v1 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        decide_purchase_in(arg0, arg1, &v0, arg3, &v1)
    }

    fun decide_purchase_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>> {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let (v7, v8) = evaluate_purchase(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>(&v9)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>(v9);
            return 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>()
        };
        0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::with_record<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>(v9), record_of(arg2, &v5, &v3, v6, v11, arg4), before_of(arg2, &v10.verdict), v12))
    }

    public fun decide_refund(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>> {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        let v1 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        decide_refund_in(arg0, arg1, &v0, arg3, &v1)
    }

    fun decide_refund_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>> {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let (v7, v8) = evaluate_refund(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v9 = v8;
        let v10 = v7;
        let (v11, v12) = emit_receipt(arg0, arg2, &v5, v6, &v10, arg3);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>(&v9)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>(v9);
            return 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>()
        };
        0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::with_record<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>(v9), record_of(arg2, &v5, &v3, v6, v11, arg4), before_of(arg2, &v10.verdict), v12))
    }

    public fun decide_replacing(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = parse_input(arg2);
        no_binds(&v0);
        let (v1, v2) = replacement_of(arg0, &v0, &arg3, arg4);
        let v3 = v2;
        let v4 = &mut arg3;
        let v5 = 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>(v1);
        if (decide_in(arg0, arg1, &v0, v4, &v5, arg5)) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::close(arg4, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::released(), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)));
            let v6 = &mut arg3;
            settle_chain(arg0, v6, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg4)), &v3, false);
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_closed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg4)), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::released(), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)));
        };
        give_back(arg3, arg5);
    }

    fun decide_unknown_in(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg3: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) {
        let (v0, v1, v2) = parse_records(arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = before_decision(arg0, arg1, arg2, &v5, &v3, arg3);
        let v7 = framework_verdict(arg0, arg2, &v5, &v4, &v3, v6, arg3, arg4);
        let v8 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v7)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v7))
        } else {
            v7
        };
        let v9 = by_framework(v8);
        let (_, _) = emit_receipt(arg0, arg2, &v5, v6, &v9, arg3);
    }

    fun discard<T0>(arg0: 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>) {
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(&arg0)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(arg0);
        } else {
            let (_, _, _, _, _) = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::unpack<T0>(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(arg0));
        };
    }

    fun emit_receipt(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: address, arg4: &Decided, arg5: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : (u64, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v1 = &arg4.verdict;
        let v2 = before_of(arg1, v1);
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::next_seq(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1));
        let v4 = if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(v1) || !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reserves(v1)) {
            v2
        } else {
            let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v2);
            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v5), 8);
            let v6 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v5);
            let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&v6, 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(v1)));
            assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v7), 8);
            let v8 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v7);
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(&v8)
        };
        let (_, v10) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::placement(arg2, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(v1), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(v1), &arg4.refused_by);
        let v11 = v10;
        let v12 = b"room";
        if (0x1::string::as_bytes(&v11) != &v12) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::consume_hidden(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg5, 0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v0), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::new(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal_hash(v0), arg3, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(v1), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(v1), v2, v4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_version(arg2), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(v1), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0), arg4.terms_hash, arg4.refused_by, v11, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v0), v3)));
        } else {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::consume_nonce(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v0));
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::record_receipt(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v0), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::new(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal_hash(v0), arg3, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(v1), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(v1), v2, v4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_version(arg2), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(v1), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0), arg4.terms_hash, arg4.refused_by, v11, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::nonce(v0), v3)));
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::set_charter(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::charter(arg1)));
        };
        (v3, v4)
    }

    fun evaluate_award(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (Decided, 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>) {
        let v0 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v0)) {
            return (by_framework(v0), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>())
        };
        let v1 = 0x1::string::utf8(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id());
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) != &v1) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>())
        };
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::binds(v2);
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v3)) {
            0x1::vector::push_back<address>(&mut v4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::bind_proposal(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(v3, v5)));
            v5 = v5 + 1;
        };
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::value(v2);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::inventory_facts(&v0);
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::inputs_of(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::award_inputs(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1)));
        let (v9, v10) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::check(&v4, v6, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::units(arg2), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_id(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1)), &v7, &v8, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v2));
        let v11 = v10;
        if (0x1::option::is_some<0x1::string::String>(&v11)) {
            0x1::option::destroy_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(v9);
            let v12 = Decided{
                verdict    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::option::destroy_some<0x1::string::String>(v11), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0)),
                terms_hash : 0x1::option::none<address>(),
                refused_by : 0x1::option::some<0x1::string::String>(v1),
            };
            return (v12, 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>())
        };
        let v13 = Decided{
            verdict    : v0,
            terms_hash : 0x1::option::none<address>(),
            refused_by : 0x1::option::none<0x1::string::String>(),
        };
        (v13, 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::issue<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(v9), arg5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v2), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v2))))
    }

    fun evaluate_bid(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (Decided, 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>) {
        let v0 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v0)) {
            return (by_framework(v0), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>())
        };
        let v1 = 0x1::string::utf8(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::id());
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) != &v1) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>())
        };
        let v2 = payer_terms(arg0, &v1, arg6);
        if (0x1::option::is_none<PayerTerms>(&v2)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>())
        };
        let v3 = 0x1::option::destroy_some<PayerTerms>(v2);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::parse_terms(v3.bytes);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Terms>(&v4)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>())
        };
        let v5 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Terms>(v4);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg2));
        let v8 = 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::commit(&v7)) && 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::commit(&v7)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v6);
        let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::customer_facts(&v0);
        let (v10, v11) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::check(&v5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::escrow(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1)), v8, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::cap_per_edition(arg2), &v9);
        let v12 = v11;
        if (0x1::option::is_some<0x1::string::String>(&v12)) {
            0x1::option::destroy_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(v10);
            let v13 = Decided{
                verdict    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::option::destroy_some<0x1::string::String>(v12), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0)),
                terms_hash : 0x1::option::some<address>(v3.hash),
                refused_by : 0x1::option::some<0x1::string::String>(v1),
            };
            return (v13, 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>())
        };
        let v14 = Decided{
            verdict    : v0,
            terms_hash : 0x1::option::some<address>(v3.hash),
            refused_by : 0x1::option::none<0x1::string::String>(),
        };
        (v14, 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::issue<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(v10), arg5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v6), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v6))))
    }

    fun evaluate_hold(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (Decided, 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>) {
        let v0 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v0)) {
            return (by_framework(v0), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>())
        };
        let v1 = 0x1::string::utf8(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::id());
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) != &v1) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>())
        };
        let v2 = payer_terms(arg0, &v1, arg6);
        if (0x1::option::is_none<PayerTerms>(&v2)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>())
        };
        let v3 = 0x1::option::destroy_some<PayerTerms>(v2);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::parse_terms(v3.bytes);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(&v4)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>())
        };
        let v5 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Terms>(v4);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::request(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::counterparty(v6), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v6), b"order"), *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::escrow(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1)));
        let (v8, v9) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::check(&v5, &v7);
        let v10 = v9;
        if (0x1::option::is_some<0x1::string::String>(&v10)) {
            0x1::option::destroy_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(v8);
            let v11 = Decided{
                verdict    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::option::destroy_some<0x1::string::String>(v10), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0)),
                terms_hash : 0x1::option::some<address>(v3.hash),
                refused_by : 0x1::option::some<0x1::string::String>(v1),
            };
            return (v11, 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>())
        };
        let v12 = Decided{
            verdict    : v0,
            terms_hash : 0x1::option::some<address>(v3.hash),
            refused_by : 0x1::option::none<0x1::string::String>(),
        };
        (v12, 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::issue<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(v8), arg5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v6), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v6))))
    }

    fun evaluate_purchase(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (Decided, 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>) {
        let v0 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v0)) {
            return (by_framework(v0), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>())
        };
        let v1 = 0x1::string::utf8(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::id());
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) != &v1) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>())
        };
        let v2 = payer_terms(arg0, &v1, arg6);
        if (0x1::option::is_none<PayerTerms>(&v2)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>())
        };
        let v3 = 0x1::option::destroy_some<PayerTerms>(v2);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::parse_terms(v3.bytes);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(&v4)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>())
        };
        let v5 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Terms>(v4);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::request(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::counterparty(v6), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v6), b"order"), *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::quantity(arg2, arg1));
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::authorized_holds(arg1);
        let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::quote_facts(&v0);
        let v10 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::now(arg1);
        let (v11, v12) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::check(&v5, &v7, &v9, &v10, &v8);
        let v13 = v12;
        if (0x1::option::is_some<0x1::string::String>(&v13)) {
            0x1::option::destroy_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(v11);
            let v14 = Decided{
                verdict    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::option::destroy_some<0x1::string::String>(v13), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0)),
                terms_hash : 0x1::option::some<address>(v3.hash),
                refused_by : 0x1::option::some<0x1::string::String>(v1),
            };
            return (v14, 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>())
        };
        let v15 = Decided{
            verdict    : v0,
            terms_hash : 0x1::option::some<address>(v3.hash),
            refused_by : 0x1::option::none<0x1::string::String>(),
        };
        (v15, 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::issue<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(v11), arg5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v6), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v6))))
    }

    fun evaluate_refund(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (Decided, 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>) {
        let v0 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v0)) {
            return (by_framework(v0), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>())
        };
        let v1 = 0x1::string::utf8(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id());
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) != &v1) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"effector"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>())
        };
        let v2 = payer_terms(arg0, &v1, arg6);
        if (0x1::option::is_none<PayerTerms>(&v2)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>())
        };
        let v3 = 0x1::option::destroy_some<PayerTerms>(v2);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::parse_terms(v3.bytes);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(&v4)) {
            return (by_framework(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::string::utf8(b"terms"), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0))), 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>())
        };
        let v5 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Terms>(v4);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::request(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::opening_order(arg3), *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::currency(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::value(v6)));
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::order_facts(&v0);
        let (v9, v10) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::check(&v5, &v7, &v8);
        let v11 = v10;
        if (0x1::option::is_some<0x1::string::String>(&v11)) {
            0x1::option::destroy_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(v9);
            let v12 = Decided{
                verdict    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::refused(0x1::option::destroy_some<0x1::string::String>(v11), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::cited(&v0)),
                terms_hash : 0x1::option::some<address>(v3.hash),
                refused_by : 0x1::option::some<0x1::string::String>(v1),
            };
            return (v12, 0x1::option::none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>())
        };
        let v13 = Decided{
            verdict    : v0,
            terms_hash : 0x1::option::some<address>(v3.hash),
            refused_by : 0x1::option::none<0x1::string::String>(),
        };
        (v13, 0x1::option::some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::issue<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(v9), arg5, *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::value(&v0)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v6), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v6))))
    }

    public fun explain(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x2::tx_context::TxContext) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = parse_input(arg2);
        let (v1, v2, v3) = parse_records(&v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        check_clock(&v0, arg1);
        let v7 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v4));
        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v7)) {
            check_chain(arg0, &arg3, v7);
        };
        let v8 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        let (v9, v10) = explained(arg0, &v0, &v6, &v5, &v4, v7, &arg3, &v8);
        give_back(arg3, arg4);
        (v9, v10)
    }

    public fun explain_replacing(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg5: &0x2::tx_context::TxContext) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = parse_input(arg2);
        let (v1, v2, v3) = parse_records(&v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        check_clock(&v0, arg1);
        let (v7, _) = replacement_of(arg0, &v0, &arg3, arg4);
        let v9 = 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>(v7);
        let (v10, v11) = explained(arg0, &v0, &v6, &v5, &v4, *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v4)), &arg3, &v9);
        give_back(arg3, arg5);
        (v10, v11)
    }

    fun explained(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg2));
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::is_effect_free(&v0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)))) {
            let v1 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v1)) {
                return (0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>())
            };
            return (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v1), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"framework")))
        };
        let v2 = 0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)));
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
        if (v2 == &v3) {
            let (v6, v7) = evaluate_refund(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            let v8 = v6;
            discard<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::Refund>(v7);
            (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v8.verdict), v8.refused_by)
        } else {
            let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::id();
            if (v2 == &v9) {
                let (v10, v11) = evaluate_purchase(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                let v12 = v10;
                discard<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::Purchase>(v11);
                (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v12.verdict), v12.refused_by)
            } else {
                let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::id();
                if (v2 == &v13) {
                    let (v14, v15) = evaluate_hold(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                    let v16 = v14;
                    discard<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::Hold>(v15);
                    (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v16.verdict), v16.refused_by)
                } else {
                    let v17 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::id();
                    if (v2 == &v17) {
                        let (v18, v19) = evaluate_bid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                        let v20 = v18;
                        discard<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::Bid>(v19);
                        (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v20.verdict), v20.refused_by)
                    } else {
                        let v21 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id();
                        if (v2 == &v21) {
                            let (v22, v23) = evaluate_award(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                            let v24 = v22;
                            discard<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::Award>(v23);
                            (*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v24.verdict), v24.refused_by)
                        } else {
                            let v25 = framework_verdict(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
                            let v26 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::allow(&v25)) {
                                0x1::option::some<0x1::string::String>(0x1::string::utf8(b"effector"))
                            } else {
                                *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::reason(&v25)
                            };
                            (v26, 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"framework")))
                        }
                    }
                }
            }
        }
    }

    public fun finalize(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg2: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: u8, arg4: address, arg5: &0x2::tx_context::TxContext) {
        check_reservation(arg0, arg1);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(arg1), 4);
        assert!(arg3 == 0 || arg3 == 1, 4);
        let v0 = if (arg3 == 0) {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::finalized()
        } else {
            0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::released()
        };
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::close(arg1, v0, arg4);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1), 8);
        let v2 = &mut arg2;
        let v3 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1);
        settle_chain(arg0, v2, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), &v3, arg3 == 0);
        give_back(arg2, arg5);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_closed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), v0, arg4);
    }

    public fun finalize_for(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg2: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: u8, arg4: address, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        check_reservation(arg0, arg1);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(arg1), 4);
        assert!(arg3 == 0, 4);
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::amount(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0), 8);
        let v1 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0);
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse_parts(&arg5, &arg6);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v2), 8);
        let v3 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v2);
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v3, &v1);
        assert!(0x1::option::is_some<u8>(&v4) && 0x1::option::destroy_some<u8>(v4) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater(), 8);
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&v1);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v3, &v5);
        assert!(0x1::option::is_some<u8>(&v6) && 0x1::option::destroy_some<u8>(v6) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::equal(), 8);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::close(arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::finalized(), arg4);
        let v7 = &mut arg2;
        settle_chain_for(arg0, v7, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), &v1, &v3);
        give_back(arg2, arg7);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_closed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::finalized(), arg4);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_settled_for(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::format(&v3));
    }

    fun finish_admission(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg2: address, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<0x1::string::String>, arg5: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(&arg1));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v0), 8);
        let v1 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::take_retired_unseen(arg0, arg2);
        let v2 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::new(arg1, arg2, 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v0), arg3, v1, arg4, arg5, arg6);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_grant(arg0, &v2);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_admitted(arg2, arg3, v1);
        0x2::transfer::public_transfer<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(v2, 0x2::tx_context::sender(arg6));
    }

    fun framework_verdict(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg5: address, arg6: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg7: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Verdict {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, arg5) && !0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg6);
        if (v0 && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retired(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg6, 0))) {
            return 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::denied(b"retired")
        };
        let v1 = if (v0) {
            *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::standing_class(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg6, 0))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = v1;
        let v3 = if (v0) {
            0x1::option::some<address>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::holder(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg6, 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg6) - 1)))
        } else {
            0x1::option::none<address>()
        };
        let v4 = v3;
        let v5 = if (v0) {
            chain_attempts(arg0, arg6)
        } else {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::chain_attempts(false, false)
        };
        let v6 = v5;
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::framework(arg1, arg2, arg3, arg4, &v2, &v4, arg7, &v6)
    }

    public fun give_back(arg0: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg1: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&arg0)) {
            0x2::transfer::public_transfer<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(0x1::vector::pop_back<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&mut arg0), 0x2::tx_context::sender(arg1));
        };
        0x1::vector::destroy_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0);
    }

    fun headroom_along(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        let v0 = room_after_release(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, 0), arg1);
        let v1 = 1;
        while (v1 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0)) {
            let v2 = room_after_release(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, v1), arg1);
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v0, &v2);
            if (0x1::option::is_some<u8>(&v3) && 0x1::option::destroy_some<u8>(v3) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun mark_stuck(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation) {
        check_reservation(arg0, arg1);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(arg1), 4);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::mark_stuck(arg1);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_stuck(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg1)));
    }

    fun names_envelope_or_ancestor(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg1: address, arg2: address) : bool {
        if (arg1 == arg2) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0)) {
            let v1 = *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::parent(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, v0));
            if (0x1::option::is_some<address>(&v1) && 0x1::option::destroy_some<address>(v1) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun no_binds(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) {
        assert!(0x1::vector::is_empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::BindArg>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::binds(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg0))), 8);
    }

    public fun observe<T0>(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>, arg2: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: &mut 0x2::tx_context::TxContext) {
        open_reservation<T0>(arg0, arg1, arg2, arg3);
    }

    fun open_reservation<T0>(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>, arg2: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _, v4) = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::unpack<T0>(arg1);
        let v5 = v4;
        let v6 = v1;
        assert!(0x1::option::is_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Attached>(&v5), 8);
        let (v7, v8, v9) = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::split(0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Attached>(v5));
        let v10 = v7;
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(&v10) == v2 && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(&v10) == v0, 8);
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_reservation(arg0, v2), 4);
        check_chain(arg0, arg2, v0);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2)) {
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::reserve(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2, v11), &v6), 8);
            v11 = v11 + 1;
        };
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::note_budget(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2, 0), v2, v8, v9);
        let v12 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::open(v10, arg3);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_reservation(arg0, v2, 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(&v12));
        0x2::transfer::public_transfer<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation>(v12, 0x2::tx_context::sender(arg3));
    }

    public fun outcome_refunded() : u8 {
        2
    }

    public fun outcome_released() : u8 {
        1
    }

    public fun outcome_settled() : u8 {
        0
    }

    fun parse_grant_or_abort(arg0: vector<u8>) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_grant(arg0);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant>(&v0), 8);
        0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant>(v0)
    }

    fun parse_input(arg0: vector<u8>) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::parse(arg0);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput>(&v0), 8);
        0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput>(v0)
    }

    fun parse_records(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) : (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_charter(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::charter(arg0));
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_opening(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening(arg0));
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_grant(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::grant(arg0));
        let v3 = if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView>(&v0)) {
            if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView>(&v1)) {
                0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant>(&v2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 8);
        let v4 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView>(v1);
        let v5 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView>(v0);
        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(&v5));
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::opening_has_reservation(&v4) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening_hold(&v6), 11);
        let v7 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant>(v2);
        (v5, v4, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parsed_grant_record(&v7))
    }

    fun payer_terms(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x1::string::String, arg2: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : 0x1::option::Option<PayerTerms> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2)) {
            let v1 = payer_terms_of(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2, v0), arg1);
            if (0x1::option::is_some<PayerTerms>(&v1)) {
                return v1
            };
            v0 = v0 + 1;
        };
        let v2 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::payer_for(arg0, arg1);
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Payer>(&v2)) {
            return 0x1::option::none<PayerTerms>()
        };
        let v3 = 0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Payer>(v2);
        let v4 = PayerTerms{
            hash  : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::payer_terms_hash(&v3),
            bytes : *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::payer_terms(&v3),
        };
        0x1::option::some<PayerTerms>(v4)
    }

    fun payer_terms_of(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant, arg1: &0x1::string::String) : 0x1::option::Option<PayerTerms> {
        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retired(arg0)) {
            return 0x1::option::none<PayerTerms>()
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_terms_hash(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg0), arg1);
        if (0x1::option::is_none<address>(&v0)) {
            return 0x1::option::none<PayerTerms>()
        };
        let v1 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_for(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v1)) {
            return 0x1::option::none<PayerTerms>()
        };
        let v2 = PayerTerms{
            hash  : 0x1::option::destroy_some<address>(v0),
            bytes : 0x1::option::destroy_some<vector<u8>>(v1),
        };
        0x1::option::some<PayerTerms>(v2)
    }

    public fun place(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0x2::tx_context::TxContext) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>, 0x1::string::String, 0x1::string::String) {
        let v0 = parse_input(arg2);
        let (v1, v2, v3) = parse_records(&v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        check_clock(&v0, arg1);
        let v7 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v4));
        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v7)) {
            check_chain(arg0, &arg3, v7);
        };
        let v8 = 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>();
        let (v9, v10) = explained(arg0, &v0, &v6, &v5, &v4, v7, &arg3, &v8);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::placement(&v6, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 0x1::option::is_none<0x1::string::String>(&v12), &v12, &v11);
        give_back(arg3, arg4);
        (v12, v11, v13, v14)
    }

    public fun place_replacing(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg4: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation, arg5: &0x2::tx_context::TxContext) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>, 0x1::string::String, 0x1::string::String) {
        let v0 = parse_input(arg2);
        let (v1, v2, v3) = parse_records(&v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        check_clock(&v0, arg1);
        let (v7, _) = replacement_of(arg0, &v0, &arg3, arg4);
        let v9 = 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>(v7);
        let (v10, v11) = explained(arg0, &v0, &v6, &v5, &v4, *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v4)), &arg3, &v9);
        let v12 = v11;
        let v13 = v10;
        let (v14, v15) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::placement(&v6, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(&v0)), 0x1::option::is_none<0x1::string::String>(&v13), &v13, &v12);
        give_back(arg3, arg5);
        (v13, v12, v14, v15)
    }

    fun record_of(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg3: address, arg4: u64, arg5: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>) : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::ReservationRecord {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg0);
        let v1 = if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement>(arg5)) {
            *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::replaces(v0)
        } else {
            0x1::option::none<address>()
        };
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::new_record(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effect(v0), arg3, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(v0), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::counterparty(v0), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::value(v0), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0), arg4, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal_hash(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_version(arg1), 0x1::option::some<0x1::string::String>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg2)), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v0), v1, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::commitment(v0))
    }

    public fun register_helm_key(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 8);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::set_helm_key(arg0, arg1);
    }

    public fun register_resolver_key(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 8);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_resolver_key(arg0, arg1);
    }

    fun replacement_of(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg2: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::Reservation) : (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::Replacement, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) {
        let (_, _, v2) = parse_records(arg1);
        let v3 = v2;
        let v4 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v3));
        let v5 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::record(arg3);
        let v6 = 0x1::option::some<address>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effect(v5));
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::replaces(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)) == &v6, 8);
        check_reservation(arg0, arg3);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::is_reserved(arg3), 4);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::resolve(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::envelope_id(v5)) == v4, 8);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::effector(v5) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg1)), 8);
        assert!(0x1::option::is_none<address>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::agreement(v5)), 8);
        check_chain(arg0, arg2, v4);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::amount(v5));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v7), 8);
        let v8 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v7);
        (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp::replacement(headroom_along(arg2, &v8), *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::reservation::commitment(v5)), v8)
    }

    public fun require_admitted(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: address) {
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, arg1), 3);
    }

    public fun require_reservation(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: address) {
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_reservation(arg0, arg1), 2);
    }

    public fun reserve<T0>(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>, arg2: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: &mut 0x2::tx_context::TxContext) {
        open_reservation<T0>(arg0, arg1, arg2, arg3);
    }

    public fun revoke(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = attested_or_abort(arg0, arg2);
        let v1 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_kind(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0));
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_retirement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0)));
        assert!(0x1::option::is_some<address>(&v2), 5);
        assert!(!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&arg1), 3);
        let v3 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&arg1, 0));
        check_chain(arg0, &arg1, v3);
        assert!(names_envelope_or_ancestor(&arg1, 0x1::option::destroy_some<address>(v2), v3), 5);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retire(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&mut arg1, 0));
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::retire_payer(arg0, v3);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_revocation(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::new(v3, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v0), v1, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_at(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0))));
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_revoked(v3, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v0), v1, true);
        give_back(arg1, arg3);
    }

    public fun revoke_unseen(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: address, arg2: vector<u8>) {
        let v0 = attested_or_abort(arg0, arg2);
        let v1 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_kind(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0));
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_retirement(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0)));
        assert!(0x1::option::is_some<address>(&v2), 5);
        assert!(0x1::option::destroy_some<address>(v2) == arg1, 5);
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, arg1), 8);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_retired_unseen(arg0, arg1);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_revocation(arg0, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::new(arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v0), v1, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_at(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0))));
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_revoked(arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v0), v1, false);
    }

    fun room_after_release(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::available(arg0);
        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retired(arg0) || 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::is_floor(arg0)) {
            return v0
        };
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::add(&v0, arg1);
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1), 8);
        0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v1)
    }

    fun same_amount(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount) : bool {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::value(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::value(arg1) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::currency(arg0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::currency(arg1)
    }

    fun settle_chain(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg2: address, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg4: bool) {
        check_chain(arg0, arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::resolve(arg0, arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1)) {
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::settle(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, v0), arg3, arg4), 8);
            v0 = v0 + 1;
        };
    }

    fun settle_chain_for(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg2: address, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg4: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money) {
        check_chain(arg0, arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::resolve(arg0, arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1)) {
            assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::settle_for(0x1::vector::borrow_mut<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1, v0), arg3, arg4), 8);
            v0 = v0 + 1;
        };
    }

    fun terms_of(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>, arg1: &0x1::string::String) : 0x1::option::Option<vector<u8>> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(arg0)) {
            if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_effector(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(arg0, v0)) == arg1) {
                return 0x1::option::some<vector<u8>>(*0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_value(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(arg0, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<vector<u8>>()
    }

    public fun unwrap<T0>(arg0: 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>) : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0> {
        assert!(0x1::option::is_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(&arg0), 8);
        0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(arg0)
    }

    public fun use_approval<T0>(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: 0x1::option::Option<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>, arg2: &mut vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        if (0x1::option::is_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(&arg1)) {
            0x1::option::destroy_none<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(arg1);
            return false
        };
        let v0 = 0x1::option::destroy_some<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::Approval<T0>>(arg1);
        assert!(!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2) && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2, 0)) == 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::approval::grant<T0>(&v0), 8);
        if (0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::is_floor(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg2, 0))) {
            observe<T0>(arg0, v0, arg2, arg3);
        } else {
            reserve<T0>(arg0, v0, arg2, arg3);
        };
        true
    }

    fun verify_grant_signature(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedGrant, arg1: address) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_signature(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parsed_grant_record(arg0));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v0), 5);
        let v1 = 0x2::address::to_bytes(arg1);
        assert!(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::verify_ed25519(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v0), &v1, b"grant/v1", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parsed_grant_signed_bytes(arg0)), 5);
    }

    public fun view(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>, arg2: &0x2::tx_context::TxContext) : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::BudgetView {
        assert!(!0x1::vector::is_empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&arg1), 3);
        check_chain(arg0, &arg1, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(&arg1, 0)));
        give_back(arg1, arg2);
        view_of(&arg1)
    }

    fun view_of(arg0: &vector<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>) : 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::BudgetView {
        let v0 = available_along(arg0);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::view_with(0x1::vector::borrow<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg0, 0), &v0)
    }

    public fun widen(arg0: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: &mut 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = attested_or_abort(arg0, arg2);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_widen(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0)));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Widening>(&v1), 5);
        let v2 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Widening>(v1);
        let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::widening_envelope_id(&v2);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v3), 3);
        assert!(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(arg1) == v3 && 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::grant_object(arg0, v3) == 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1), 8);
        let v4 = *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg1);
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::widened_grant(&v4, &v2, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::id(&v0), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::assertion(&v0));
        let v6 = *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_envelope_id(&v5));
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, v6), 6);
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_value_cap(&v5));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v7), 8);
        let v8 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::new(v5, v6, 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v7), 0x1::option::none<address>(), false, *0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::standing_class(arg1), 0x1::vector::empty<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::TermsBytes>(), arg3);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::carry(&mut v8, arg1);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retire(arg1);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::retire_payer(arg0, v3);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::add_grant(arg0, &v8);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::succeed(arg0, v3, v6);
        0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::emit_widened(v3, v6, v5);
        0x2::transfer::public_transfer<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(v8, 0x2::tx_context::sender(arg3));
    }

    public fun widen_unadmitted(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>) {
        let v0 = attested_or_abort(arg0, arg1);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_widen(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm::record(&v0)));
        assert!(0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Widening>(&v1), 5);
        let v2 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Widening>(v1);
        assert!(!0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::has_grant(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::widening_envelope_id(&v2)), 8);
        abort 3
    }

    // decompiled from Move bytecode v7
}

