module 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::beneficiary_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        beneficiary: address,
        inactivity_secs: u64,
        version: u64,
    }

    public fun add(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            beneficiary     : arg2,
            inactivity_secs : arg3,
            version         : 1,
        };
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_main_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 2);
    }

    public fun beneficiary(arg0: &Config) : address {
        assert_version(arg0);
        arg0.beneficiary
    }

    public fun inactivity_secs(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.inactivity_secs
    }

    public fun migrate(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun prove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningRequest, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg2: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        assert!(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::signer_id(arg0) == 0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner>(arg2), 3);
        assert!(0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy>(arg1) == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::policy_id(arg2), 4);
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert_version(v1);
        assert!(0x2::tx_context::sender(arg3) == v1.beneficiary, 1);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::last_owner_activity_ts(arg2) + v1.inactivity_secs * 1000, 0);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    public fun remove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

