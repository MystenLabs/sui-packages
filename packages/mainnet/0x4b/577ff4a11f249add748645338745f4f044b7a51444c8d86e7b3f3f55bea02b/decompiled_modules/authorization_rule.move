module 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::authorization_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        whitelist: 0x2::vec_set::VecSet<address>,
        version: u64,
    }

    public fun add(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: vector<address>) {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = Rule{dummy_field: false};
        let v3 = Config{
            whitelist : v0,
            version   : 1,
        };
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_main_rule<Rule, Config>(v2, arg0, arg1, v3);
    }

    public fun add_to_whitelist(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert_version(v1);
        0x2::vec_set::insert<address>(&mut v1.whitelist, arg2);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun is_whitelisted(arg0: &Config, arg1: address) : bool {
        assert_version(arg0);
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun migrate(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun prove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningRequest, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert_version(v1);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&v1.whitelist, &v2), 0);
        let v3 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v3, arg0);
    }

    public fun remove_from_whitelist(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert_version(v1);
        0x2::vec_set::remove<address>(&mut v1.whitelist, &arg2);
    }

    public fun whitelist_size(arg0: &Config) : u64 {
        assert_version(arg0);
        0x2::vec_set::length<address>(&arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

