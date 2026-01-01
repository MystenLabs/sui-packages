module 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::beneficiary_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        beneficiary: address,
        inactivity_secs: u64,
    }

    public fun add(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicyCap, arg2: address, arg3: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            beneficiary     : arg2,
            inactivity_secs : arg3,
        };
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun beneficiary(arg0: &Config) : address {
        arg0.beneficiary
    }

    public fun inactivity_secs(arg0: &Config) : u64 {
        arg0.inactivity_secs
    }

    public fun prove(arg0: &mut 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningRequest, arg1: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::SigningPolicy, arg2: &0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert!(0x2::tx_context::sender(arg3) == v1.beneficiary, 1);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::umi_signer::last_owner_activity_ts(arg2) + v1.inactivity_secs * 1000, 0);
        let v2 = Rule{dummy_field: false};
        0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    // decompiled from Move bytecode v6
}

