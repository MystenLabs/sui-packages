module 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        permanent: bool,
        version: u64,
    }

    public fun add(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: bool) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            permanent : arg2,
            version   : 1,
        };
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 5);
    }

    public fun execute_remove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: &0x2::tx_context::TxContext) : Config {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg0);
        assert_version(v1);
        assert!(!v1.permanent, 1);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::execute_remove_rule<Rule, Config>(arg0, arg1, v2, arg2)
    }

    public fun is_permanent(arg0: &Config) : bool {
        assert_version(arg0);
        arg0.permanent
    }

    public fun migrate(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun propose_remove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg0);
        assert_version(v1);
        assert!(!v1.permanent, 1);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::propose_remove_rule<Rule>(arg0, arg1, v2, arg2);
    }

    public fun prove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningRequest, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg2: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg1));
        assert!(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::signer_id(arg0) == 0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner>(arg2), 2);
        assert!(0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy>(arg1) == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::policy_id(arg2), 3);
        assert!(arg3 == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::chain_id(arg0), 4);
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::new_chain_id(arg3);
        assert!(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::has_wallet(arg2, v1) && 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::is_locked(arg2, v1), 0);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    public fun remove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg0);
        assert_version(v1);
        assert!(!v1.permanent, 1);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v2)
    }

    // decompiled from Move bytecode v6
}

