module 0x1a6309586a92f2df092b85205eb29e720f422d23d0d922b5228d42a0d882b52b::signing_policy {
    struct SigningRequest {
        chain_id: vector<u8>,
        intent_hash: vector<u8>,
        created_at: u64,
        signer_id: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct SigningPolicy has store, key {
        id: 0x2::object::UID,
        main_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        stackable_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rule_change_delay: u64,
        pending_removals: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct SigningPolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct SigningPolicyCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct SigningPolicyDestroyed has copy, drop {
        id: 0x2::object::ID,
    }

    struct RuleRemovalProposed has copy, drop {
        policy_id: 0x2::object::ID,
        rule_type: 0x1::type_name::TypeName,
        unlock_time: u64,
    }

    struct RuleRemovalExecuted has copy, drop {
        policy_id: 0x2::object::ID,
        rule_type: 0x1::type_name::TypeName,
    }

    struct RuleRemovalCancelled has copy, drop {
        policy_id: 0x2::object::ID,
        rule_type: 0x1::type_name::TypeName,
    }

    struct RuleKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (SigningPolicy, SigningPolicyCap) {
        new_with_protection(0, arg0)
    }

    public fun add_main_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap, arg3: T1) {
        assert!(0x2::object::id<SigningPolicy>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0>(arg1), 3);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.main_rules, 0x1::type_name::with_original_ids<T0>());
    }

    public fun add_receipt<T0: drop>(arg0: T0, arg1: &mut SigningRequest) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::with_original_ids<T0>());
    }

    public fun add_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap, arg3: T1) {
        add_main_rule<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun add_stackable_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap, arg3: T1) {
        assert!(0x2::object::id<SigningPolicy>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0>(arg1), 3);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.stackable_rules, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_rule_removal<T0: drop>(arg0: &mut SigningPolicy, arg1: &SigningPolicyCap, arg2: T0) {
        assert!(0x2::object::id<SigningPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0);
            let v1 = RuleRemovalCancelled{
                policy_id : 0x2::object::id<SigningPolicy>(arg0),
                rule_type : v0,
            };
            0x2::event::emit<RuleRemovalCancelled>(v1);
        };
    }

    public fun chain_id(arg0: &SigningRequest) : vector<u8> {
        arg0.chain_id
    }

    public fun confirm_request(arg0: &SigningPolicy, arg1: SigningRequest) : (vector<u8>, vector<u8>, u64, 0x2::object::ID) {
        let SigningRequest {
            chain_id    : v0,
            intent_hash : v1,
            created_at  : v2,
            signer_id   : v3,
            receipts    : v4,
        } = arg1;
        let v5 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v4);
        let v6 = false;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v9 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v8);
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v9)) {
                v6 = true;
            } else {
                assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v9), 1);
                v7 = v7 + 1;
            };
            v8 = v8 + 1;
        };
        if (0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.main_rules) > 0) {
            assert!(v6, 0);
        };
        assert!(v7 == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.stackable_rules), 0);
        (v0, v1, v2, v3)
    }

    public fun copy_receipts(arg0: &SigningRequest, arg1: &mut SigningRequest) {
        let v0 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.receipts);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    public fun created_at(arg0: &SigningRequest) : u64 {
        arg0.created_at
    }

    entry fun default(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<SigningPolicy>(v0);
        0x2::transfer::transfer<SigningPolicyCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun destroy(arg0: SigningPolicy, arg1: SigningPolicyCap) {
        assert!(0x2::object::id<SigningPolicy>(&arg0) == arg1.policy_id, 4);
        let SigningPolicyCap {
            id        : v0,
            policy_id : v1,
        } = arg1;
        let SigningPolicy {
            id                : v2,
            main_rules        : _,
            stackable_rules   : _,
            rule_change_delay : _,
            pending_removals  : v6,
        } = arg0;
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v6);
        0x2::object::delete(v2);
        0x2::object::delete(v0);
        let v7 = SigningPolicyDestroyed{id: v1};
        0x2::event::emit<SigningPolicyDestroyed>(v7);
    }

    public(friend) fun destroy_request(arg0: SigningRequest) : vector<u8> {
        let SigningRequest {
            chain_id    : _,
            intent_hash : v1,
            created_at  : _,
            signer_id   : _,
            receipts    : _,
        } = arg0;
        v1
    }

    public(friend) fun enforce_request(arg0: &SigningPolicy, arg1: &SigningRequest) {
        let v0 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg1.receipts);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v3)) {
                v1 = true;
            } else {
                assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v3), 1);
            };
            v2 = v2 + 1;
        };
        if (0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.main_rules) > 0) {
            assert!(v1, 0);
        };
        let v4 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.stackable_rules);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v4, v5);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.receipts, &v6), 0);
            v5 = v5 + 1;
        };
    }

    public fun execute_remove_rule<T0: drop, T1: drop + store>(arg0: &mut SigningPolicy, arg1: &SigningPolicyCap, arg2: T0, arg3: &0x2::tx_context::TxContext) : T1 {
        assert!(0x2::object::id<SigningPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0), 5);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0), 6);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.main_rules, &v0);
        } else if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.stackable_rules, &v0);
        };
        let v1 = RuleRemovalExecuted{
            policy_id : 0x2::object::id<SigningPolicy>(arg0),
            rule_type : v0,
        };
        0x2::event::emit<RuleRemovalExecuted>(v1);
        let v2 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T0>, T1>(&mut arg0.id, v2)
    }

    public(friend) fun get_receipts(arg0: &SigningRequest) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.receipts)
    }

    public fun get_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &SigningPolicy) : &T1 {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T0>, T1>(&arg1.id, v0)
    }

    public fun get_rule_mut<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap) : &mut T1 {
        assert!(0x2::object::id<SigningPolicy>(arg1) == arg2.policy_id, 4);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RuleKey<T0>, T1>(&mut arg1.id, v0)
    }

    public fun has_pending_removal<T0: drop>(arg0: &SigningPolicy, arg1: T0) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::with_original_ids<T0>())
    }

    public fun has_rule<T0: drop>(arg0: &SigningPolicy) : bool {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<RuleKey<T0>>(&arg0.id, v0)
    }

    public fun intent_hash(arg0: &SigningRequest) : vector<u8> {
        arg0.intent_hash
    }

    public fun is_main_rule<T0: drop>(arg0: &SigningPolicy) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)
    }

    public fun is_stackable_rule<T0: drop>(arg0: &SigningPolicy) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)
    }

    public fun new_request(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : SigningRequest {
        SigningRequest{
            chain_id    : arg0,
            intent_hash : arg1,
            created_at  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            signer_id   : arg2,
            receipts    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun new_with_protection(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (SigningPolicy, SigningPolicyCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = SigningPolicyCreated{id: v1};
        0x2::event::emit<SigningPolicyCreated>(v2);
        let v3 = SigningPolicy{
            id                : v0,
            main_rules        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            stackable_rules   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rule_change_delay : arg0,
            pending_removals  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
        };
        let v4 = SigningPolicyCap{
            id        : 0x2::object::new(arg1),
            policy_id : v1,
        };
        (v3, v4)
    }

    public fun pending_removal_unlock_time<T0: drop>(arg0: &SigningPolicy, arg1: T0) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::with_original_ids<T0>()), 5);
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::with_original_ids<T0>())
    }

    public fun policy_id(arg0: &SigningPolicy) : 0x2::object::ID {
        0x2::object::id<SigningPolicy>(arg0)
    }

    public(friend) fun policy_uid_mut(arg0: &mut SigningPolicy) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun propose_remove_rule<T0: drop>(arg0: &mut SigningPolicy, arg1: &SigningPolicyCap, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<SigningPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3) + arg0.rule_change_delay;
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0, v1);
        let v2 = RuleRemovalProposed{
            policy_id   : 0x2::object::id<SigningPolicy>(arg0),
            rule_type   : v0,
            unlock_time : v1,
        };
        0x2::event::emit<RuleRemovalProposed>(v2);
    }

    public fun protection_delay(arg0: &SigningPolicy) : u64 {
        arg0.rule_change_delay
    }

    public fun remove_rule<T0: drop, T1: drop + store>(arg0: &mut SigningPolicy, arg1: &SigningPolicyCap, arg2: T0) : T1 {
        assert!(0x2::object::id<SigningPolicy>(arg0) == arg1.policy_id, 4);
        assert!(arg0.rule_change_delay == 0, 7);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.main_rules, &v0);
        } else if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.stackable_rules, &v0);
        };
        let v1 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T0>, T1>(&mut arg0.id, v1)
    }

    public fun share(arg0: SigningPolicy) {
        0x2::transfer::share_object<SigningPolicy>(arg0);
    }

    public(friend) fun signer_id(arg0: &SigningRequest) : 0x2::object::ID {
        arg0.signer_id
    }

    public(friend) fun uid(arg0: &SigningPolicy) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun verify_request<T0>(arg0: &SigningRequest, arg1: &SigningPolicy, arg2: &T0, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.receipts);
        let v1 = 0x2::vec_set::length<0x1::type_name::TypeName>(&arg1.main_rules);
        let v2 = 0x2::vec_set::length<0x1::type_name::TypeName>(&arg1.stackable_rules);
        let v3 = if (v1 > 0) {
            1 + v2
        } else {
            v2
        };
        assert!(v0 >= v3, 0);
        assert!(v0 <= v1 + v2, 0);
    }

    // decompiled from Move bytecode v6
}

