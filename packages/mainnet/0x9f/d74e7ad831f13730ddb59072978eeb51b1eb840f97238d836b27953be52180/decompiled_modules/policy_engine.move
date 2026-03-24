module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine {
    struct PolicyEngineCreatedEvent has copy, drop {
        engine_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct PolicyAccessGrantedEvent has copy, drop {
        engine_id: 0x2::object::ID,
        access_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct DkgCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ImportedKeyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolicyEngine has key {
        id: 0x2::object::UID,
        rules: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rule_configs: 0x2::bag::Bag,
        admin_cap_id: 0x2::object::ID,
        paused: bool,
    }

    struct PolicyAdminCap has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
    }

    struct PolicyAccessCap has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
    }

    struct ApprovalRequest {
        engine_id: 0x2::object::ID,
        signature_algorithm: u32,
        hash_scheme: u32,
        message: vector<u8>,
        receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct PolicyReceipt<phantom T0: drop> has drop {
        engine_id: 0x2::object::ID,
    }

    public fun access_cap_engine_id(arg0: &PolicyAccessCap) : 0x2::object::ID {
        arg0.engine_id
    }

    public fun add_receipt<T0: drop>(arg0: &mut ApprovalRequest, arg1: PolicyReceipt<T0>) {
        assert!(arg1.engine_id == arg0.engine_id, 5);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.receipts, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_rule<T0: drop, T1: store>(arg0: &mut PolicyEngine, arg1: &PolicyAdminCap, arg2: T0, arg3: T1) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rules, v0);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg0.rule_configs, v0, arg3);
    }

    public fun admin_cap_engine_id(arg0: &PolicyAdminCap) : 0x2::object::ID {
        arg0.engine_id
    }

    fun assert_admin(arg0: &PolicyEngine, arg1: &PolicyAdminCap) {
        assert!(0x2::object::id<PolicyAdminCap>(arg1) == arg0.admin_cap_id, 2);
    }

    fun assert_receipts_complete(arg0: &0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(arg0) == 0x2::vec_set::length<0x1::type_name::TypeName>(arg1), 4);
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1)), 4);
            v1 = v1 + 1;
        };
    }

    public fun cancel(arg0: ApprovalRequest) {
        let ApprovalRequest {
            engine_id           : _,
            signature_algorithm : _,
            hash_scheme         : _,
            message             : _,
            receipts            : _,
        } = arg0;
    }

    public fun confirm_dkg(arg0: &PolicyEngine, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: ApprovalRequest) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::MessageApproval {
        let ApprovalRequest {
            engine_id           : v0,
            signature_algorithm : v1,
            hash_scheme         : v2,
            message             : v3,
            receipts            : v4,
        } = arg2;
        let v5 = v4;
        assert!(v0 == 0x2::object::id<PolicyEngine>(arg0), 3);
        assert!(!arg0.paused, 1);
        assert_receipts_complete(&arg0.rules, &v5);
        let v6 = DkgCapKey{dummy_field: false};
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, 0x2::dynamic_object_field::borrow<DkgCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.id, v6), v1, v2, v3)
    }

    public fun confirm_imported_key(arg0: &PolicyEngine, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: ApprovalRequest) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyMessageApproval {
        let ApprovalRequest {
            engine_id           : v0,
            signature_algorithm : v1,
            hash_scheme         : v2,
            message             : v3,
            receipts            : v4,
        } = arg2;
        let v5 = v4;
        assert!(v0 == 0x2::object::id<PolicyEngine>(arg0), 3);
        assert!(!arg0.paused, 1);
        assert_receipts_complete(&arg0.rules, &v5);
        let v6 = ImportedKeyCapKey{dummy_field: false};
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_imported_key_message(arg1, 0x2::dynamic_object_field::borrow<ImportedKeyCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&arg0.id, v6), v1, v2, v3)
    }

    fun create_engine_internal(arg0: &mut 0x2::tx_context::TxContext) : (PolicyEngine, PolicyAdminCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = PolicyEngine{
            id           : 0x2::object::new(arg0),
            rules        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rule_configs : 0x2::bag::new(arg0),
            admin_cap_id : v1,
            paused       : false,
        };
        let v3 = 0x2::object::id<PolicyEngine>(&v2);
        let v4 = PolicyAdminCap{
            id        : v0,
            engine_id : v3,
        };
        let v5 = PolicyEngineCreatedEvent{
            engine_id    : v3,
            admin_cap_id : v1,
        };
        0x2::event::emit<PolicyEngineCreatedEvent>(v5);
        (v2, v4)
    }

    public fun create_request(arg0: &PolicyEngine, arg1: &PolicyAccessCap, arg2: u32, arg3: u32, arg4: vector<u8>) : ApprovalRequest {
        assert!(!arg0.paused, 1);
        assert!(arg1.engine_id == 0x2::object::id<PolicyEngine>(arg0), 0);
        ApprovalRequest{
            engine_id           : 0x2::object::id<PolicyEngine>(arg0),
            signature_algorithm : arg2,
            hash_scheme         : arg3,
            message             : arg4,
            receipts            : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun create_with_dkg_cap(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg1: &mut 0x2::tx_context::TxContext) : PolicyAdminCap {
        let (v0, v1) = create_engine_internal(arg1);
        let v2 = v0;
        let v3 = DkgCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DkgCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut v2.id, v3, arg0);
        0x2::transfer::share_object<PolicyEngine>(v2);
        v1
    }

    public fun create_with_imported_key_cap(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap, arg1: &mut 0x2::tx_context::TxContext) : PolicyAdminCap {
        let (v0, v1) = create_engine_internal(arg1);
        let v2 = v0;
        let v3 = ImportedKeyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<ImportedKeyCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut v2.id, v3, arg0);
        0x2::transfer::share_object<PolicyEngine>(v2);
        v1
    }

    public fun destroy_and_reclaim_dkg_cap(arg0: PolicyEngine, arg1: PolicyAdminCap) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap {
        assert_admin(&arg0, &arg1);
        let v0 = DkgCapKey{dummy_field: false};
        destroy_engine(arg0, arg1);
        0x2::dynamic_object_field::remove<DkgCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.id, v0)
    }

    public fun destroy_and_reclaim_imported_key_cap(arg0: PolicyEngine, arg1: PolicyAdminCap) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap {
        assert_admin(&arg0, &arg1);
        let v0 = ImportedKeyCapKey{dummy_field: false};
        destroy_engine(arg0, arg1);
        0x2::dynamic_object_field::remove<ImportedKeyCapKey, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::ImportedKeyDWalletCap>(&mut arg0.id, v0)
    }

    fun destroy_engine(arg0: PolicyEngine, arg1: PolicyAdminCap) {
        let PolicyEngine {
            id           : v0,
            rules        : _,
            rule_configs : v2,
            admin_cap_id : _,
            paused       : _,
        } = arg0;
        0x2::bag::destroy_empty(v2);
        0x2::object::delete(v0);
        let PolicyAdminCap {
            id        : v5,
            engine_id : _,
        } = arg1;
        0x2::object::delete(v5);
    }

    public fun engine_id(arg0: &ApprovalRequest) : 0x2::object::ID {
        arg0.engine_id
    }

    public fun grant_access(arg0: &PolicyEngine, arg1: &PolicyAdminCap, arg2: &mut 0x2::tx_context::TxContext) : PolicyAccessCap {
        assert_admin(arg0, arg1);
        let v0 = PolicyAccessCap{
            id        : 0x2::object::new(arg2),
            engine_id : 0x2::object::id<PolicyEngine>(arg0),
        };
        let v1 = PolicyAccessGrantedEvent{
            engine_id     : 0x2::object::id<PolicyEngine>(arg0),
            access_cap_id : 0x2::object::id<PolicyAccessCap>(&v0),
            recipient     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PolicyAccessGrantedEvent>(v1);
        v0
    }

    public fun has_rule<T0: drop>(arg0: &PolicyEngine) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rules, &v0)
    }

    public fun hash_scheme(arg0: &ApprovalRequest) : u32 {
        arg0.hash_scheme
    }

    public fun is_paused(arg0: &PolicyEngine) : bool {
        arg0.paused
    }

    public fun message(arg0: &ApprovalRequest) : &vector<u8> {
        &arg0.message
    }

    public fun new_receipt<T0: drop>(arg0: T0, arg1: &ApprovalRequest) : PolicyReceipt<T0> {
        PolicyReceipt<T0>{engine_id: arg1.engine_id}
    }

    public fun pause(arg0: &mut PolicyEngine, arg1: &PolicyAdminCap) {
        assert_admin(arg0, arg1);
        arg0.paused = true;
    }

    public fun remove_rule<T0: drop, T1: store>(arg0: &mut PolicyEngine, arg1: &PolicyAdminCap) : T1 {
        assert_admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.rules, &v0);
        0x2::bag::remove<0x1::type_name::TypeName, T1>(&mut arg0.rule_configs, v0)
    }

    public fun revoke_access(arg0: PolicyAccessCap) {
        let PolicyAccessCap {
            id        : v0,
            engine_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun rule_config<T0: drop, T1: store>(arg0: &PolicyEngine) : &T1 {
        0x2::bag::borrow<0x1::type_name::TypeName, T1>(&arg0.rule_configs, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun rule_config_mut<T0: drop, T1: store>(arg0: &mut PolicyEngine, arg1: T0) : &mut T1 {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, T1>(&mut arg0.rule_configs, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun rules_count(arg0: &PolicyEngine) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.rules)
    }

    public fun signature_algorithm(arg0: &ApprovalRequest) : u32 {
        arg0.signature_algorithm
    }

    public fun unpause(arg0: &mut PolicyEngine, arg1: &PolicyAdminCap) {
        assert_admin(arg0, arg1);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

