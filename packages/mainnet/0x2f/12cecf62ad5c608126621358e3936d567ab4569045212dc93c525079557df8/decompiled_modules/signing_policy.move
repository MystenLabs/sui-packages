module 0x2f12cecf62ad5c608126621358e3936d567ab4569045212dc93c525079557df8::signing_policy {
    struct SigningRequest {
        chain_id: vector<u8>,
        intent_hash: vector<u8>,
        created_at: u64,
        signer_id: 0x2::object::ID,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct SigningPolicy has key {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
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

    struct RuleKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (SigningPolicy, SigningPolicyCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = SigningPolicyCreated{id: v1};
        0x2::event::emit<SigningPolicyCreated>(v2);
        let v3 = SigningPolicy{
            id    : v0,
            rules : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v4 = SigningPolicyCap{
            id        : 0x2::object::new(arg0),
            policy_id : v1,
        };
        (v3, v4)
    }

    public fun add_receipt<T0: drop>(arg0: T0, arg1: &mut SigningRequest) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.receipts, 0x1::type_name::get<T0>());
    }

    public fun add_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap, arg3: T1) {
        assert!(0x2::object::id<SigningPolicy>(arg1) == arg2.policy_id, 4);
        assert!(!has_rule<T0>(arg1), 3);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RuleKey<T0>, T1>(&mut arg1.id, v0, arg3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.rules, 0x1::type_name::get<T0>());
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
        let v6 = 0x1::vector::length<0x1::type_name::TypeName>(&v5);
        assert!(v6 == 0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.rules), 0);
        while (v6 > 0) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5);
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v7), 1);
            v6 = v6 - 1;
        };
        (v0, v1, v2, v3)
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
            id    : v2,
            rules : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::object::delete(v0);
        let v4 = SigningPolicyDestroyed{id: v1};
        0x2::event::emit<SigningPolicyDestroyed>(v4);
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

    public fun get_rule<T0: drop, T1: drop + store>(arg0: T0, arg1: &SigningPolicy) : &T1 {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<RuleKey<T0>, T1>(&arg1.id, v0)
    }

    public fun get_rule_mut<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut SigningPolicy, arg2: &SigningPolicyCap) : &mut T1 {
        assert!(0x2::object::id<SigningPolicy>(arg1) == arg2.policy_id, 4);
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RuleKey<T0>, T1>(&mut arg1.id, v0)
    }

    public fun has_rule<T0: drop>(arg0: &SigningPolicy) : bool {
        let v0 = RuleKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<RuleKey<T0>>(&arg0.id, v0)
    }

    public fun intent_hash(arg0: &SigningRequest) : vector<u8> {
        arg0.intent_hash
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

    public fun policy_id(arg0: &SigningPolicy) : 0x2::object::ID {
        0x2::object::id<SigningPolicy>(arg0)
    }

    public(friend) fun policy_uid_mut(arg0: &mut SigningPolicy) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun remove_rule<T0: drop, T1: drop + store>(arg0: &mut SigningPolicy, arg1: &SigningPolicyCap, arg2: T0) : T1 {
        assert!(0x2::object::id<SigningPolicy>(arg0) == arg1.policy_id, 4);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
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
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.receipts) == 0x2::vec_set::size<0x1::type_name::TypeName>(&arg1.rules), 0);
    }

    // decompiled from Move bytecode v6
}

