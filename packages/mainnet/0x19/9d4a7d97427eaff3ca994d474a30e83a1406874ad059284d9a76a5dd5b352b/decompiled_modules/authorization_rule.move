module 0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::authorization_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    public fun add(arg0: &mut 0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::SigningPolicy, arg1: &0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::SigningPolicyCap, arg2: vector<address>) {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = Rule{dummy_field: false};
        let v3 = Config{whitelist: v0};
        0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::add_rule<Rule, Config>(v2, arg0, arg1, v3);
    }

    public fun is_whitelisted(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun prove(arg0: &mut 0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::SigningRequest, arg1: &0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::SigningPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::get_rule<Rule, Config>(v0, arg1).whitelist, &v1), 0);
        let v2 = Rule{dummy_field: false};
        0x199d4a7d97427eaff3ca994d474a30e83a1406874ad059284d9a76a5dd5b352b::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    public fun whitelist_size(arg0: &Config) : u64 {
        0x2::vec_set::size<address>(&arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

