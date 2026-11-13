module 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::cosign_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        sponsors: 0x2::vec_set::VecSet<address>,
        version: u64,
    }

    public fun remove(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    public fun add(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap, arg2: vector<address>) {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::vec_set::length<address>(&v0) > 0, 2);
        let v2 = Rule{dummy_field: false};
        let v3 = Config{
            sponsors : v0,
            version  : 1,
        };
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::add_stackable_rule<Rule, Config>(v2, arg0, arg1, v3);
    }

    public fun add_sponsor(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert_version(v1);
        0x2::vec_set::insert<address>(&mut v1.sponsors, arg2);
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 3);
    }

    public fun is_sponsor(arg0: &Config, arg1: address) : bool {
        assert_version(arg0);
        0x2::vec_set::contains<address>(&arg0.sponsors, &arg1)
    }

    public fun migrate(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun prove(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningRequest, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg2: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy>(arg1) == 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::policy_id(arg2), 1);
        assert!(0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::signer_id(arg0) == 0x2::object::id<0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::agent_signer::AgentSigner>(arg2), 1);
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert_version(v1);
        let v2 = 0x2::tx_context::sponsor(arg3);
        assert!(0x1::option::is_some<address>(&v2) && 0x2::vec_set::contains<address>(&v1.sponsors, 0x1::option::borrow<address>(&v2)), 0);
        assert!(*0x1::option::borrow<address>(&v2) != 0x2::tx_context::sender(arg3), 0);
        let v3 = Rule{dummy_field: false};
        0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::add_receipt<Rule>(v3, arg1, arg0);
    }

    public fun remove_sponsor(arg0: &mut 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicy, arg1: &0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1110b5829a55bc12d301685d5011f0feedf32ef4532882140db08b82bd1cb93c::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert_version(v1);
        0x2::vec_set::remove<address>(&mut v1.sponsors, &arg2);
        assert!(0x2::vec_set::length<address>(&v1.sponsors) > 0, 2);
    }

    // decompiled from Move bytecode v7
}

