module 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::message_validation_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        allowed_intent_hashes: 0x2::vec_set::VecSet<vector<u8>>,
        allowed_message_prefixes: 0x2::vec_set::VecSet<vector<u8>>,
        max_message_length: 0x1::option::Option<u64>,
    }

    public fun add(arg0: &mut 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningPolicy, arg1: &0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningPolicyCap, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: 0x1::option::Option<u64>) {
        let v0 = 0x2::vec_set::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            0x2::vec_set::insert<vector<u8>>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::vec_set::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x2::vec_set::insert<vector<u8>>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg3, v3));
            v3 = v3 + 1;
        };
        let v4 = Rule{dummy_field: false};
        let v5 = Config{
            allowed_intent_hashes    : v0,
            allowed_message_prefixes : v2,
            max_message_length       : arg4,
        };
        0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::add_stackable_rule<Rule, Config>(v4, arg0, arg1, v5);
    }

    public fun get_allowed_intent_hashes(arg0: &Config) : &0x2::vec_set::VecSet<vector<u8>> {
        &arg0.allowed_intent_hashes
    }

    public fun get_allowed_message_prefixes(arg0: &Config) : &0x2::vec_set::VecSet<vector<u8>> {
        &arg0.allowed_message_prefixes
    }

    public fun get_max_message_length(arg0: &Config) : &0x1::option::Option<u64> {
        &arg0.max_message_length
    }

    public fun prove_with_intent_hash(arg0: &mut 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningRequest, arg1: &0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::get_rule<Rule, Config>(v0, arg1);
        let v2 = 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::intent_hash(arg0);
        if (0x2::vec_set::length<vector<u8>>(&v1.allowed_intent_hashes) > 0) {
            assert!(0x2::vec_set::contains<vector<u8>>(&v1.allowed_intent_hashes, &v2), 1);
        };
        let v3 = Rule{dummy_field: false};
        0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::add_receipt<Rule>(v3, arg0);
    }

    public fun prove_with_message(arg0: &mut 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningRequest, arg1: &0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::SigningPolicy, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::get_rule<Rule, Config>(v0, arg1);
        if (0x1::option::is_some<u64>(&v1.max_message_length)) {
            assert!(0x1::vector::length<u8>(&arg3) <= *0x1::option::borrow<u64>(&v1.max_message_length), 0);
        };
        if (0x2::vec_set::length<vector<u8>>(&v1.allowed_message_prefixes) > 0) {
            let v2 = false;
            let v3 = 0x2::vec_set::into_keys<vector<u8>>(v1.allowed_message_prefixes);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&v3)) {
                let v5 = *0x1::vector::borrow<vector<u8>>(&v3, v4);
                if (0x1::vector::length<u8>(&arg3) >= 0x1::vector::length<u8>(&v5)) {
                    let v6 = true;
                    let v7 = 0;
                    while (v7 < 0x1::vector::length<u8>(&v5)) {
                        if (*0x1::vector::borrow<u8>(&arg3, v7) != *0x1::vector::borrow<u8>(&v5, v7)) {
                            v6 = false;
                            break
                        };
                        v7 = v7 + 1;
                    };
                    if (v6) {
                        v2 = true;
                        break
                    };
                };
                v4 = v4 + 1;
            };
            assert!(v2, 0);
        };
        let v8 = Rule{dummy_field: false};
        0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy::add_receipt<Rule>(v8, arg0);
    }

    // decompiled from Move bytecode v6
}

