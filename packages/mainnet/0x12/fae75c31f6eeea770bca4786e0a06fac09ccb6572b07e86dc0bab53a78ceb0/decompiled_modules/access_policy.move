module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::access_policy {
    struct AccessRequest {
        vault_id: 0x2::object::ID,
        access_type: u8,
        memory_type: u8,
        memory_key: vector<u8>,
        created_at: u64,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct AccessPolicy has store, key {
        id: 0x2::object::UID,
        main_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        stackable_rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rule_change_delay: u64,
        pending_removals: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        requires_encryption: bool,
    }

    struct AccessPolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct RuleKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct AccessPolicyCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct AccessPolicyDestroyed has copy, drop {
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

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (AccessPolicy, AccessPolicyCap) {
        new_with_protection(0, arg0)
    }

    public fun access_type(arg0: &AccessRequest) : u8 {
        arg0.access_type
    }

    public fun add_main_rule<T0: drop, T1: store>(arg0: T0, arg1: &mut AccessPolicy, arg2: &AccessPolicyCap, arg3: T1) {
        assert!(0x2::object::id<AccessPolicy>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0>(arg1), 3);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.main_rules, 0x1::type_name::get_with_original_ids<T0>());
    }

    public fun add_receipt<T0: drop>(arg0: T0, arg1: &mut AccessRequest) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::get_with_original_ids<T0>());
    }

    public fun add_stackable_rule<T0: drop, T1: store>(arg0: T0, arg1: &mut AccessPolicy, arg2: &AccessPolicyCap, arg3: T1) {
        assert!(0x2::object::id<AccessPolicy>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0>(arg1), 3);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.stackable_rules, 0x1::type_name::get_with_original_ids<T0>());
    }

    public fun cancel_rule_removal<T0: drop>(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: T0) {
        assert!(0x2::object::id<AccessPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0);
            let v1 = RuleRemovalCancelled{
                policy_id : 0x2::object::id<AccessPolicy>(arg0),
                rule_type : v0,
            };
            0x2::event::emit<RuleRemovalCancelled>(v1);
        };
    }

    public fun confirm_request(arg0: &AccessPolicy, arg1: AccessRequest) : (0x2::object::ID, u8, u8, vector<u8>, u64) {
        let AccessRequest {
            vault_id    : v0,
            access_type : v1,
            memory_type : v2,
            memory_key  : v3,
            created_at  : v4,
            receipts    : v5,
        } = arg1;
        let v6 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v5);
        let v7 = false;
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v10 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v9);
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v10)) {
                v7 = true;
            } else {
                assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v10), 1);
                v8 = v8 + 1;
            };
            v9 = v9 + 1;
        };
        if (0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.main_rules) > 0) {
            assert!(v7, 0);
        };
        assert!(v8 == 0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.stackable_rules), 0);
        (v0, v1, v2, v3, v4)
    }

    public fun created_at(arg0: &AccessRequest) : u64 {
        arg0.created_at
    }

    entry fun default(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<AccessPolicy>(v0);
        0x2::transfer::transfer<AccessPolicyCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun destroy(arg0: AccessPolicy, arg1: AccessPolicyCap) {
        assert!(0x2::object::id<AccessPolicy>(&arg0) == arg1.policy_id, 4);
        let AccessPolicyCap {
            id        : v0,
            policy_id : v1,
        } = arg1;
        let AccessPolicy {
            id                  : v2,
            main_rules          : _,
            stackable_rules     : _,
            rule_change_delay   : _,
            pending_removals    : v6,
            requires_encryption : _,
        } = arg0;
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v6);
        0x2::object::delete(v2);
        0x2::object::delete(v0);
        let v8 = AccessPolicyDestroyed{id: v1};
        0x2::event::emit<AccessPolicyDestroyed>(v8);
    }

    public(friend) fun destroy_request(arg0: AccessRequest) : (0x2::object::ID, u8, u8, vector<u8>) {
        let AccessRequest {
            vault_id    : v0,
            access_type : v1,
            memory_type : v2,
            memory_key  : v3,
            created_at  : _,
            receipts    : _,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public(friend) fun enforce_request(arg0: &AccessPolicy, arg1: &AccessRequest) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.receipts);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v2);
            if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, v3)) {
                v1 = true;
            } else {
                assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, v3), 1);
            };
            v2 = v2 + 1;
        };
        if (0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.main_rules) > 0) {
            assert!(v1, 0);
        };
        let v4 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.stackable_rules);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.receipts, 0x1::vector::borrow<0x1::type_name::TypeName>(v4, v5)), 0);
            v5 = v5 + 1;
        };
    }

    public fun execute_remove_rule<T0: drop, T1: store>(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: T0, arg3: &0x2::tx_context::TxContext) : T1 {
        assert!(0x2::object::id<AccessPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0), 5);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0), 6);
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.main_rules, &v0);
        } else if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.stackable_rules, &v0);
        };
        let v1 = RuleRemovalExecuted{
            policy_id : 0x2::object::id<AccessPolicy>(arg0),
            rule_type : v0,
        };
        0x2::event::emit<RuleRemovalExecuted>(v1);
        let v2 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T0>, T1>(&mut arg0.id, v2)
    }

    public(friend) fun get_receipts(arg0: &AccessRequest) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.receipts)
    }

    public fun get_rule<T0: drop, T1: store>(arg0: T0, arg1: &AccessPolicy) : &T1 {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T0>, T1>(&arg1.id, v0)
    }

    public fun get_rule_mut<T0: drop, T1: store>(arg0: T0, arg1: &mut AccessPolicy, arg2: &AccessPolicyCap) : &mut T1 {
        assert!(0x2::object::id<AccessPolicy>(arg1) == arg2.policy_id, 4);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RuleKey<T0>, T1>(&mut arg1.id, v0)
    }

    public fun has_pending_removal<T0: drop>(arg0: &AccessPolicy, arg1: T0) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::get_with_original_ids<T0>())
    }

    public fun has_rule<T0: drop>(arg0: &AccessPolicy) : bool {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<RuleKey<T0>>(&arg0.id, v0)
    }

    public fun is_main_rule<T0: drop>(arg0: &AccessPolicy) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)
    }

    public fun is_stackable_rule<T0: drop>(arg0: &AccessPolicy) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)
    }

    public fun memory_key(arg0: &AccessRequest) : vector<u8> {
        arg0.memory_key
    }

    public fun memory_type(arg0: &AccessRequest) : u8 {
        arg0.memory_type
    }

    public fun new_request(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : AccessRequest {
        AccessRequest{
            vault_id    : arg0,
            access_type : arg1,
            memory_type : arg2,
            memory_key  : arg3,
            created_at  : 0x2::tx_context::epoch_timestamp_ms(arg4),
            receipts    : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun new_with_protection(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (AccessPolicy, AccessPolicyCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AccessPolicyCreated{id: v1};
        0x2::event::emit<AccessPolicyCreated>(v2);
        let v3 = AccessPolicy{
            id                  : v0,
            main_rules          : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            stackable_rules     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rule_change_delay   : arg0,
            pending_removals    : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            requires_encryption : false,
        };
        let v4 = AccessPolicyCap{
            id        : 0x2::object::new(arg1),
            policy_id : v1,
        };
        (v3, v4)
    }

    public fun pending_removal_unlock_time<T0: drop>(arg0: &AccessPolicy, arg1: T0) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::get_with_original_ids<T0>()), 5);
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.pending_removals, 0x1::type_name::get_with_original_ids<T0>())
    }

    public fun policy_id(arg0: &AccessPolicy) : 0x2::object::ID {
        0x2::object::id<AccessPolicy>(arg0)
    }

    public(friend) fun policy_uid_mut(arg0: &mut AccessPolicy) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun propose_remove_rule<T0: drop>(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AccessPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3) + arg0.rule_change_delay;
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.pending_removals, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.pending_removals, v0, v1);
        let v2 = RuleRemovalProposed{
            policy_id   : 0x2::object::id<AccessPolicy>(arg0),
            rule_type   : v0,
            unlock_time : v1,
        };
        0x2::event::emit<RuleRemovalProposed>(v2);
    }

    public fun protection_delay(arg0: &AccessPolicy) : u64 {
        arg0.rule_change_delay
    }

    public fun remove_rule<T0: drop, T1: store>(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: T0) : T1 {
        assert!(0x2::object::id<AccessPolicy>(arg0) == arg1.policy_id, 4);
        assert!(arg0.rule_change_delay == 0, 7);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.main_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.main_rules, &v0);
        } else if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.stackable_rules, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.stackable_rules, &v0);
        };
        let v1 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<RuleKey<T0>, T1>(&mut arg0.id, v1)
    }

    public fun requires_encryption(arg0: &AccessPolicy) : bool {
        arg0.requires_encryption
    }

    public fun set_requires_encryption(arg0: &mut AccessPolicy, arg1: &AccessPolicyCap, arg2: bool) {
        assert!(0x2::object::id<AccessPolicy>(arg0) == arg1.policy_id, 4);
        arg0.requires_encryption = arg2;
    }

    public fun share(arg0: AccessPolicy) {
        0x2::transfer::share_object<AccessPolicy>(arg0);
    }

    public(friend) fun uid(arg0: &AccessPolicy) : &0x2::object::UID {
        &arg0.id
    }

    public fun vault_id(arg0: &AccessRequest) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

