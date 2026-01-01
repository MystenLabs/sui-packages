module 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::two_fa_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        factors: vector<address>,
    }

    struct IntentApprovalKey has copy, drop, store {
        intent_hash: vector<u8>,
    }

    struct FactorProof has copy, drop, store {
        factor: address,
    }

    public fun add(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicyCap, arg2: vector<address>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{factors: arg2};
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun add_factor_proof(arg0: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningRequest, arg1: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v1.factors)) {
            if (*0x1::vector::borrow<address>(&v1.factors, v4) == v2) {
                v3 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v3, 1);
        let v5 = IntentApprovalKey{intent_hash: arg2};
        let v6 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::policy_uid_mut(arg1);
        if (!0x2::dynamic_field::exists_<IntentApprovalKey>(v6, v5)) {
            0x2::dynamic_field::add<IntentApprovalKey, 0x2::vec_set::VecSet<address>>(v6, v5, 0x2::vec_set::empty<address>());
        };
        0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<IntentApprovalKey, 0x2::vec_set::VecSet<address>>(v6, v5), v2);
    }

    public fun factors(arg0: &Config) : &vector<address> {
        &arg0.factors
    }

    public fun prove(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningRequest, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = IntentApprovalKey{intent_hash: 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::intent_hash(arg0)};
        let v3 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::uid(arg1);
        assert!(0x2::dynamic_field::exists_<IntentApprovalKey>(v3, v2), 0);
        let v4 = 0x2::dynamic_field::borrow<IntentApprovalKey, 0x2::vec_set::VecSet<address>>(v3, v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&v1.factors)) {
            let v6 = *0x1::vector::borrow<address>(&v1.factors, v5);
            assert!(0x2::vec_set::contains<address>(v4, &v6), 0);
            v5 = v5 + 1;
        };
        let v7 = Rule{dummy_field: false};
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_receipt<Rule>(v7, arg0);
    }

    // decompiled from Move bytecode v6
}

