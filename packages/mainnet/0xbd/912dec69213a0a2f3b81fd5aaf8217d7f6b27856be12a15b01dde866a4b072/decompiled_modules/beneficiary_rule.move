module 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::beneficiary_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        beneficiary: address,
        inactivity_secs: u64,
    }

    public fun add(arg0: &mut 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningPolicy, arg1: &0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningPolicyCap, arg2: address, arg3: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            beneficiary     : arg2,
            inactivity_secs : arg3,
        };
        0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun beneficiary(arg0: &Config) : address {
        arg0.beneficiary
    }

    public fun inactivity_secs(arg0: &Config) : u64 {
        arg0.inactivity_secs
    }

    public fun prove(arg0: &mut 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningRequest, arg1: &0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningPolicy, arg2: &0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert!(0x2::tx_context::sender(arg3) == v1.beneficiary, 1);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::umi_signer::last_owner_activity_ts(arg2) + v1.inactivity_secs * 1000, 0);
        let v2 = Rule{dummy_field: false};
        0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    public fun remove(arg0: &mut 0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningPolicy, arg1: &0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x33637d82120d5b05652f550d5bb3a88162065411f151ed1d043706b1b63bbf8a::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

