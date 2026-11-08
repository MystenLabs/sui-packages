module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pdp {
    struct Verdict has copy, drop {
        allow: bool,
        reason: 0x1::option::Option<0x1::string::String>,
        cited: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>,
        verified: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>,
        value: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>,
        reserves: bool,
        budget_before: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>,
    }

    struct Replacement has copy, drop {
        headroom: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        commitment: 0x1::option::Option<address>,
    }

    struct ChainAttempts has copy, drop {
        ancestor_spent: bool,
        place_taken: bool,
    }

    public fun cited(arg0: &Verdict) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef> {
        &arg0.cited
    }

    public fun authorized_holds(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::authorized_holds(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg0));
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>(v0)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>(v0))
    }

    public fun value(arg0: &Verdict) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money> {
        &arg0.value
    }

    public fun allow(arg0: &Verdict) : bool {
        arg0.allow
    }

    public fun budget_before(arg0: &Verdict) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money> {
        &arg0.budget_before
    }

    public fun chain_attempts(arg0: bool, arg1: bool) : ChainAttempts {
        ChainAttempts{
            ancestor_spent : arg0,
            place_taken    : arg1,
        }
    }

    fun class_of_code(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
        if (v0 == &v1) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::rests_on(arg1)
        } else {
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::id();
            if (v0 == &v3) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase::rests_on(arg1)
            } else {
                let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::id();
                if (v0 == &v4) {
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold::rests_on(arg1)
                } else {
                    let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::id();
                    if (v0 == &v5) {
                        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid::rests_on(arg1)
                    } else {
                        let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id();
                        if (v0 == &v6) {
                            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::rests_on(arg1)
                        } else {
                            0x1::option::none<vector<u8>>()
                        }
                    }
                }
            }
        }
    }

    public fun customer_facts(arg0: &Verdict) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_customer(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified, v0)))) {
                return 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>()
    }

    public fun denied(arg0: vector<u8>) : Verdict {
        deny(arg0, 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>())
    }

    fun deny(arg0: vector<u8>, arg1: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>) : Verdict {
        Verdict{
            allow         : false,
            reason        : 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0)),
            cited         : arg1,
            verified      : 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(),
            value         : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
            reserves      : false,
            budget_before : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
        }
    }

    public fun framework(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::OpeningView, arg3: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::GrantRecord, arg4: &0x1::option::Option<0x1::string::String>, arg5: &0x1::option::Option<address>, arg6: &0x1::option::Option<Replacement>, arg7: &ChainAttempts) : Verdict {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg0);
        let v2 = now(arg0);
        let (v3, v4) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::gate(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1), &v2, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::resolver_key(v1));
        let v5 = v4;
        let v6 = v3;
        if (0x1::option::is_some<0x1::string::String>(&v5)) {
            return deny(0x1::string::into_bytes(0x1::option::destroy_some<0x1::string::String>(v5)), 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>())
        };
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::state(v1) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::running() || 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::state(v1) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::open() && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(v0) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::host(v1) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::members_admitted(v1);
        if (!v7) {
            return deny(b"room_state", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::hex_of(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_holder(arg3));
        if (&v8 != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(v0)) {
            return deny(b"holder", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        if (0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::replaces(v0))) {
            let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg1));
            let v10 = 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::agreement(&v9)) && 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::agreement(&v9)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0);
            let v11 = 0x1::option::is_some<Replacement>(arg6) && 0x1::option::is_some<address>(&0x1::option::borrow<Replacement>(arg6).commitment);
            let v12 = 0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v9)) && 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v9)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0);
            let v13 = if (0x1::option::is_none<Replacement>(arg6)) {
                true
            } else if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_acceptance(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0))) {
                true
            } else if (v10) {
                true
            } else if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::is_effect_free(&v9, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0))) {
                true
            } else {
                v11 && !v12
            };
            if (v13) {
                return deny(b"replaced", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
        };
        if (!0x1::vector::contains<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_allowed_kinds(arg3), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0))) {
            return deny(b"kind", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v14 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg1));
        if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v14)) && 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v14)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::phase(v1) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::reveal(&v14)) {
                return deny(b"phase", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            let v15 = opening_commitment(arg0);
            let v16 = if (0x1::option::is_some<Replacement>(arg6)) {
                if (0x1::option::is_some<address>(&0x1::option::borrow<Replacement>(arg6).commitment)) {
                    if (0x1::option::is_some<address>(&v15)) {
                        *0x1::option::borrow<address>(&v15) == *0x1::option::borrow<address>(&0x1::option::borrow<Replacement>(arg6).commitment)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (!v16) {
                return deny(b"commitment", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
        } else {
            let v17 = if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::commit(&v14))) {
                if (0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::commit(&v14)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0)) {
                    0x1::option::is_none<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::commitment(v0))
                } else {
                    false
                }
            } else {
                false
            };
            if (v17) {
                return deny(b"commitment", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
        };
        if (0x1::option::is_some<0x1::string::String>(arg4) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg1) != 0x1::option::borrow<0x1::string::String>(arg4)) {
            return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v18 = if (0x1::option::is_some<address>(arg5)) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::hex_of(*0x1::option::borrow<address>(arg5))
        } else {
            *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(v0)
        };
        let v19 = v18;
        let v20 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::is_sell(arg1)) {
            if (&v19 == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::host(v1)) {
                !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::host_floor_fits(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg3))
            } else {
                false
            }
        } else {
            false
        };
        if (v20) {
            return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v21 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(arg1)) {
            if (&v19 != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::host(v1)) {
                !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::member_quota_fits(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_attempt_quota(arg3))
            } else {
                false
            }
        } else {
            false
        };
        if (v21) {
            return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v22 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(arg1)) {
            let v23 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::request();
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0) == &v23) {
                !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::request_fits(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::charter(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_charter(arg3), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::chain(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms_object(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0))
            } else {
                false
            }
        } else {
            false
        };
        if (v22) {
            return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v24 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg1));
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::is_effect_free(&v24, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0))) {
            let v25 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg3));
            let v26 = if (0x1::option::is_none<u64>(&v2)) {
                true
            } else if (0x1::option::is_none<u64>(&v25)) {
                true
            } else {
                *0x1::option::borrow<u64>(&v2) > 0x1::option::destroy_some<u64>(v25)
            };
            if (v26) {
                return deny(b"deadline", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(arg1) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::leaves(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0))) {
                return Verdict{
                    allow         : true,
                    reason        : 0x1::option::none<0x1::string::String>(),
                    cited         : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)),
                    verified      : v6,
                    value         : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
                    reserves      : false,
                    budget_before : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
                }
            };
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempts_used(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0)) >= 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempt_quota(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0)) || arg7.ancestor_spent) {
                return deny(b"attempt_quota", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            let v27 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::is_waitlist(arg1)) {
                if (&v19 != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::host(v1)) {
                    !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::place_open(arg7.place_taken)
                } else {
                    false
                }
            } else {
                false
            };
            if (v27) {
                return deny(b"attempt_quota", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            return Verdict{
                allow         : true,
                reason        : 0x1::option::none<0x1::string::String>(),
                cited         : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)),
                verified      : v6,
                value         : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
                reserves      : false,
                budget_before : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
            }
        };
        let v28 = if (&v19 == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::host(v1)) {
            0
        } else {
            1
        };
        let v29 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_role_direction(arg1, v28);
        if (v29 != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::no_direction()) {
            let v30 = if (0x1::option::is_some<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg3))) {
                1
            } else {
                0
            };
            if (v30 != v29) {
                return deny(b"direction", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
        };
        let v31 = 0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::opening_proposal_schema(arg2));
        let v32 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case::proposal_schema();
        let v33 = if (v31 == &v32) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case::terms_fit(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms_object(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0))
        } else {
            let v34 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool::proposal_schema();
            if (v31 == &v34) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool::terms_fit(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms_object(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0))
            } else {
                let v35 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::proposal_schema();
                v31 == &v35 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case::terms_fit(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms_object(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0))
            }
        };
        if (!v33) {
            return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v36 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_role_effectors(arg1, v28);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_carries(arg3, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::counterparty(v0)) || !0x1::vector::is_empty<0x1::string::String>(&v36) && !0x1::vector::contains<0x1::string::String>(&v36, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0))) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_names_connector(arg3, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::counterparty(v0))) {
                return deny(b"effector", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            return deny(b"counterparty", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v37 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_deadline(arg3));
        let v38 = if (0x1::option::is_none<u64>(&v2)) {
            true
        } else if (0x1::option::is_none<u64>(&v37)) {
            true
        } else {
            *0x1::option::borrow<u64>(&v2) > 0x1::option::destroy_some<u64>(v37)
        };
        if (v38) {
            return deny(b"deadline", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        if ((0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v0)) || 0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_agreement(v1))) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::agreement(v0) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_agreement(v1)) {
            return deny(b"agreement", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v39 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::value(v0));
        let v40 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_available(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0)));
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v39) || 0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v40)) {
            return deny(b"value", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v41 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v39);
        let v42 = if (0x1::option::is_some<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg3))) {
            let v43 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::id();
            let v44 = if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0)) == &v43) {
                let v45 = order_facts_in(&v6);
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund::base(&v45)
            } else {
                let v46 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::id();
                if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::effector(v0)) == &v46) {
                    let v47 = inventory_facts_in(&v6);
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::base(&v47)
                } else {
                    0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
                }
            };
            let v48 = v44;
            if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v48)) {
                let v49 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v48);
                let v50 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::scale_bps_up(&v49, *0x1::option::borrow<u64>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_floor_bps(arg3)));
                let v51 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v41, &v50);
                if (0x1::option::is_none<u8>(&v51)) {
                    return deny(b"currency", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
                };
                if (0x1::option::destroy_some<u8>(v51) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::less()) {
                    return deny(b"value_floor", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
                };
            };
            false
        } else {
            let v52 = if (0x1::option::is_some<Replacement>(arg6)) {
                0x1::option::borrow<Replacement>(arg6).headroom
            } else {
                0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v40)
            };
            let v53 = v52;
            let v54 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v41, &v53);
            if (0x1::option::is_none<u8>(&v54)) {
                return deny(b"currency", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            if (0x1::option::destroy_some<u8>(v54) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
                return deny(b"value_cap", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            true
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempts_used(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0)) >= 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget_attempt_quota(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::budget(arg0)) || arg7.ancestor_spent) {
            return deny(b"attempt_quota", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
        };
        let v55 = if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::is_sell(arg1)) {
            if (0x1::option::is_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v14))) {
                0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::opening(&v14)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0)
            } else {
                false
            }
        } else {
            false
        };
        if (v55) {
            let v56 = inventory_facts_in(&v6);
            let v57 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award::base(&v56);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v57)) {
                return deny(b"NO_FACTS", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            let v58 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::reserve(arg1, 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v57));
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v58)) {
                return deny(b"schema", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            let v59 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v41, 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v58));
            if (0x1::option::is_none<u8>(&v59)) {
                return deny(b"currency", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
            if (0x1::option::destroy_some<u8>(v59) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::less()) {
                return deny(b"reserve", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)))
            };
        };
        let v60 = if (0x1::option::is_some<Replacement>(arg6)) {
            0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(0x1::option::borrow<Replacement>(arg6).headroom)
        } else {
            0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        Verdict{
            allow         : true,
            reason        : 0x1::option::none<0x1::string::String>(),
            cited         : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::cited(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::kind(v0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::facts(arg0), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_snapshots(v1)),
            verified      : v6,
            value         : 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v41),
            reserves      : v42,
            budget_before : v60,
        }
    }

    public fun inventory_facts(arg0: &Verdict) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        inventory_facts_in(&arg0.verified)
    }

    fun inventory_facts_in(arg0: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_inventory(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0, v0)))) {
                return 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>()
    }

    fun json_string(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = b"\"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 == 34) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 34);
            } else if (v3 == 92) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 92);
            } else if (v3 == 8) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 98);
            } else if (v3 == 12) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 102);
            } else if (v3 == 10) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 110);
            } else if (v3 == 13) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 114);
            } else if (v3 == 9) {
                0x1::vector::push_back<u8>(&mut v1, 92);
                0x1::vector::push_back<u8>(&mut v1, 116);
            } else if (v3 < 32) {
                0x1::vector::append<u8>(&mut v1, b"\\u00");
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 / 16) as u64)));
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 % 16) as u64)));
            } else {
                0x1::vector::push_back<u8>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::push_back<u8>(&mut v1, 34);
        v1
    }

    fun keyed(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &vector<u8>) : bool {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_fact_classes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0)) {
            if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0, v1))) == arg1 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_readers(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0, v1)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::readers_keyed()) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun now(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) : 0x1::option::Option<u64> {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::clock(arg0))
    }

    fun opening_commitment(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) : 0x1::option::Option<address> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::proposal(arg0);
        if (0x1::option::is_none<vector<u8>>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::salt(v0)) || !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms_object(v0)) {
            return 0x1::option::none<address>()
        };
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::try_hex(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::author(v0));
        if (0x1::option::is_none<vector<u8>>(&v1)) {
            return 0x1::option::none<address>()
        };
        let v2 = 0x1::option::destroy_some<vector<u8>>(v1);
        if (0x1::vector::length<u8>(&v2) != 32) {
            return 0x1::option::none<address>()
        };
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_id(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg0)));
        0x1::vector::append<u8>(&mut v3, v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<vector<u8>>(0x1::option::borrow<vector<u8>>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::salt(v0))));
        let v4 = terms_text(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::terms(v0));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::option::some<address>(0x2::address::from_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::signing_digest(b"bid_commitment/v1", &v3)))
    }

    public fun order_facts(arg0: &Verdict) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        order_facts_in(&arg0.verified)
    }

    fun order_facts_in(arg0: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_case_order(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0, v0)))) {
                return 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(arg0, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>()
    }

    public fun placement(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg2: bool, arg3: &0x1::option::Option<0x1::string::String>, arg4: &0x1::option::Option<0x1::string::String>) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates::declaration(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg0));
        let (v1, v2) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::allowed(&v0, arg1);
        let v3 = v1;
        if (arg2) {
            return (v3, v2)
        };
        let v4 = 0x1::string::utf8(b"room");
        let v5 = receipt_visibility(arg3, arg4);
        let v6 = b"holder";
        if (0x1::string::as_bytes(&v5) == &v6) {
            return (v5, v5)
        };
        let v7 = if (0x1::option::is_some<0x1::string::String>(arg3)) {
            *0x1::option::borrow<0x1::string::String>(arg3)
        } else {
            0x1::string::utf8(b"")
        };
        let v8 = v7;
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::verifies(&v0, &v8)) {
            return (v4, v4)
        };
        let v9 = if (rests_on_keyed(arg0, arg1, &v8, arg4)) {
            0x1::string::utf8(b"party_and_host")
        } else {
            v4
        };
        let v10 = if (v9 != v4) {
            v9
        } else {
            let v11 = b"party_and_host";
            if (0x1::string::as_bytes(&v3) == &v11) {
                v3
            } else {
                v4
            }
        };
        (v10, v9)
    }

    public fun quantity(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::DecideInput) : u64 {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool::template();
        if (0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_template(arg0)) == &v0) {
            let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::committed_count(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::room_state(arg1));
            if (v2 > 0) {
                v2
            } else {
                1
            }
        } else {
            1
        }
    }

    public fun quote_facts(arg0: &Verdict) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_pool_quote(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified, v0)))) {
                return 0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified, v0)))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>()
    }

    public fun reason(arg0: &Verdict) : &0x1::option::Option<0x1::string::String> {
        &arg0.reason
    }

    public fun receipt_visibility(arg0: &0x1::option::Option<0x1::string::String>, arg1: &0x1::option::Option<0x1::string::String>) : 0x1::string::String {
        let v0 = if (0x1::option::is_some<0x1::string::String>(arg1)) {
            let v1 = b"framework";
            if (0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(arg1)) == &v1) {
                0x1::option::is_some<0x1::string::String>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v2 = 0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(arg0));
            let v3 = b"value_floor";
            let v4 = if (v2 == &v3) {
                true
            } else {
                let v5 = b"value_cap";
                if (v2 == &v5) {
                    true
                } else {
                    let v6 = b"attempt_quota";
                    if (v2 == &v6) {
                        true
                    } else {
                        let v7 = b"deadline";
                        v2 == &v7
                    }
                }
            };
            if (v4) {
                return 0x1::string::utf8(b"holder")
            };
        };
        0x1::string::utf8(b"room")
    }

    public fun refused(arg0: 0x1::string::String, arg1: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::FactSnapshotRef>) : Verdict {
        Verdict{
            allow         : false,
            reason        : 0x1::option::some<0x1::string::String>(arg0),
            cited         : arg1,
            verified      : 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(),
            value         : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
            reserves      : false,
            budget_before : 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(),
        }
    }

    public fun replacement(arg0: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg1: 0x1::option::Option<address>) : Replacement {
        Replacement{
            headroom   : arg0,
            commitment : arg1,
        }
    }

    public fun reserves(arg0: &Verdict) : bool {
        arg0.reserves
    }

    fun rests_on_keyed(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg2: &0x1::string::String, arg3: &0x1::option::Option<0x1::string::String>) : bool {
        if (0x1::option::is_none<0x1::string::String>(arg3)) {
            return false
        };
        let v0 = 0x1::option::borrow<0x1::string::String>(arg3);
        let v1 = b"framework";
        if (0x1::string::as_bytes(v0) == &v1) {
            let v2 = 0x1::string::as_bytes(arg2);
            let v3 = b"NO_FACTS";
            let v4 = if (v2 != &v3) {
                let v5 = b"STALE_FACTS";
                if (v2 != &v5) {
                    let v6 = b"BAD_FACTS";
                    v2 != &v6
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                return false
            };
            let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::required_for(arg0, arg1);
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v7)) {
                if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_readers(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v7, v8)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::readers_keyed()) {
                    return true
                };
                v8 = v8 + 1;
            };
            return false
        };
        let v9 = class_of_code(v0, arg2);
        0x1::option::is_some<vector<u8>>(&v9) && keyed(arg0, 0x1::option::borrow<vector<u8>>(&v9))
    }

    fun terms_text(arg0: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>) : 0x1::string::String {
        let v0 = b"{";
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(arg0)) {
            if (v1 > 0) {
                0x1::vector::push_back<u8>(&mut v0, 44);
            };
            0x1::vector::append<u8>(&mut v0, json_string(0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::term_key(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(arg0, v1)))));
            0x1::vector::push_back<u8>(&mut v0, 58);
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::term_is_string(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(arg0, v1))) {
                0x1::vector::append<u8>(&mut v0, json_string(0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::term_text(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(arg0, v1)))));
            } else {
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::term_text(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>(arg0, v1))));
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u8>(&mut v0, 125);
        0x1::string::utf8(v0)
    }

    public fun typed_facts(arg0: &Verdict) : vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts> {
        let v0 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified)) {
            0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(&mut v0, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::typed(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts>(&arg0.verified, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verified(arg0: &Verdict) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts::VerifiedFacts> {
        &arg0.verified
    }

    // decompiled from Move bytecode v7
}

