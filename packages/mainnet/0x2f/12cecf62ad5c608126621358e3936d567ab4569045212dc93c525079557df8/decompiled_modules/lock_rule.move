module 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        permanent: bool,
    }

    public fun add(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicyCap, arg2: bool) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{permanent: arg2};
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun is_permanent(arg0: &Config) : bool {
        arg0.permanent
    }

    public fun prove(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningRequest, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg2: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::UmiSigner, arg3: vector<u8>) {
        let v0 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::new_chain_id(arg3);
        assert!(0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::has_wallet(arg2, v0) && 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::is_locked(arg2, v0), 0);
        let v1 = Rule{dummy_field: false};
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    // decompiled from Move bytecode v6
}

