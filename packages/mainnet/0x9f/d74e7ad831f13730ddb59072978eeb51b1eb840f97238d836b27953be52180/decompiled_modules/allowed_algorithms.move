module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::allowed_algorithms {
    struct AllowedAlgorithms has drop {
        dummy_field: bool,
    }

    struct AllowedPair has copy, drop, store {
        signature_algorithm: u32,
        hash_scheme: u32,
    }

    struct AllowedAlgorithmsConfig has drop, store {
        pairs: vector<AllowedPair>,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<AllowedPair>) {
        let v0 = AllowedAlgorithms{dummy_field: false};
        let v1 = AllowedAlgorithmsConfig{pairs: arg2};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0, arg1, v0, v1);
    }

    public fun add_pair(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: AllowedPair) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = AllowedAlgorithms{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0, v0);
        if (!contains_pair(&v1.pairs, &arg2)) {
            0x1::vector::push_back<AllowedPair>(&mut v1.pairs, arg2);
        };
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &AllowedAlgorithmsConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0)
    }

    fun contains_pair(arg0: &vector<AllowedPair>, arg1: &AllowedPair) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<AllowedPair>(arg0)) {
            let v2 = 0x1::vector::borrow<AllowedPair>(arg0, v0);
            if (v2.signature_algorithm == arg1.signature_algorithm && v2.hash_scheme == arg1.hash_scheme) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public fun enforce(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<AllowedAlgorithms> {
        let v0 = AllowedPair{
            signature_algorithm : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::signature_algorithm(arg1),
            hash_scheme         : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::hash_scheme(arg1),
        };
        assert!(contains_pair(&0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0).pairs, &v0), 0);
        let v1 = AllowedAlgorithms{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<AllowedAlgorithms>(v1, arg1)
    }

    public fun new_pair(arg0: u32, arg1: u32) : AllowedPair {
        AllowedPair{
            signature_algorithm : arg0,
            hash_scheme         : arg1,
        }
    }

    public fun pair_hash_scheme(arg0: &AllowedPair) : u32 {
        arg0.hash_scheme
    }

    public fun pair_signature_algorithm(arg0: &AllowedPair) : u32 {
        arg0.signature_algorithm
    }

    public fun pairs(arg0: &AllowedAlgorithmsConfig) : &vector<AllowedPair> {
        &arg0.pairs
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0, arg1);
    }

    public fun remove_pair(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: AllowedPair) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = AllowedAlgorithms{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0, v0);
        let v2 = &v1.pairs;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<AllowedPair>(v2)) {
            let v5 = 0x1::vector::borrow<AllowedPair>(v2, v3);
            if (v5.signature_algorithm == arg2.signature_algorithm && v5.hash_scheme == arg2.hash_scheme) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 13 */
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::vector::swap_remove<AllowedPair>(&mut v1.pairs, 0x1::option::destroy_some<u64>(v4));
                };
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 13 */
    }

    public fun set_pairs(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<AllowedPair>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = AllowedAlgorithms{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<AllowedAlgorithms, AllowedAlgorithmsConfig>(arg0, v0).pairs = arg2;
    }

    // decompiled from Move bytecode v6
}

