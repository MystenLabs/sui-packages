module 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::timelock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        delay_secs: u64,
    }

    public fun add(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{delay_secs: arg2};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun delay_secs(arg0: &Config) : u64 {
        arg0.delay_secs
    }

    public fun prove(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningRequest, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg2: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::last_signing_activity_ts(arg2) + 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule<Rule, Config>(v0, arg1).delay_secs * 1000, 0);
        let v1 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    public fun remove(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

