module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::helm {
    struct AttestedDecision has copy, drop {
        id: address,
        record: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmDecisionRecord,
        assertion: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::WebAuthnAssertion,
    }

    public fun assertion(arg0: &AttestedDecision) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::WebAuthnAssertion {
        &arg0.assertion
    }

    public fun attest(arg0: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::Store, arg1: vector<u8>) : 0x1::option::Option<AttestedDecision> {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store::helm_key(arg0);
        if (0x1::option::is_none<vector<u8>>(v0)) {
            return 0x1::option::none<AttestedDecision>()
        };
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_decision(arg1);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedDecision>(&v1)) {
            return 0x1::option::none<AttestedDecision>()
        };
        let v2 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedDecision>(v1);
        let v3 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_record(&v2);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::WebAuthnAssertion>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_assertion(&v3))) {
            return 0x1::option::none<AttestedDecision>()
        };
        let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_attestation(&v3);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v4)) {
            return 0x1::option::none<AttestedDecision>()
        };
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::verify_ed25519(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v4), 0x1::option::borrow<vector<u8>>(v0), b"helm_attestation/v1", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_attested_bytes(&v2))) {
            return 0x1::option::none<AttestedDecision>()
        };
        let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::proposed_standing(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_proposed(&v3));
        let v6 = if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::StandingRecord>(&v5)) {
            b"standing_grant/v1"
        } else {
            b"helm/v1"
        };
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_challenge(&v3);
        if (0x1::option::is_none<address>(v7) || 0x2::address::to_bytes(*0x1::option::borrow<address>(v7)) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::signing_digest(v6, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_challenge_preimage(&v2))) {
            return 0x1::option::none<AttestedDecision>()
        };
        let v8 = AttestedDecision{
            id        : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_attested_bytes(&v2)),
            record    : v3,
            assertion : *0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::WebAuthnAssertion>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::decision_assertion(&v3)),
        };
        0x1::option::some<AttestedDecision>(v8)
    }

    public fun id(arg0: &AttestedDecision) : address {
        arg0.id
    }

    public fun record(arg0: &AttestedDecision) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmDecisionRecord {
        &arg0.record
    }

    // decompiled from Move bytecode v7
}

