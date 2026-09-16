module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2 {
    struct PredicateDescriptor has copy, drop, store {
        tag: u8,
    }

    struct NativeAssetBinding has copy, drop, store {
        schema_version: u8,
        kind: u8,
        chain_id: vector<u8>,
        original_id_type: 0x1::option::Option<0x1::type_name::TypeName>,
        native_id: vector<u8>,
    }

    struct Tier1Policy has copy, drop, store {
        schema_version: u64,
        strategy_lead: address,
        predicates: vector<PredicateDescriptor>,
        allowed_asset_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_native_assets: 0x2::vec_set::VecSet<NativeAssetBinding>,
        allowed_opportunity_ids: 0x2::vec_set::VecSet<vector<u8>>,
        allowed_chain_ids: 0x2::vec_set::VecSet<vector<u8>>,
        max_allocation_bps: u64,
    }

    struct GuardrailsV2Builder has store, key {
        id: 0x2::object::UID,
        strategy_lead: address,
        allowed_asset_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allowed_native_assets: 0x2::vec_set::VecSet<NativeAssetBinding>,
        allowed_opportunity_ids: 0x2::vec_set::VecSet<vector<u8>>,
        allowed_chain_ids: 0x2::vec_set::VecSet<vector<u8>>,
        max_allocation_bps: u64,
    }

    struct GuardrailsV2 has store, key {
        id: 0x2::object::UID,
        guardrails_hash: vector<u8>,
        canonical_preimage: vector<u8>,
        policy: Tier1Policy,
    }

    struct GuardrailsV2Created has copy, drop {
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        strategy_lead: address,
        asset_type_count: u64,
        opportunity_count: u64,
        chain_count: u64,
        max_allocation_bps: u64,
    }

    public fun id(arg0: &GuardrailsV2) : 0x2::object::ID {
        0x2::object::id<GuardrailsV2>(arg0)
    }

    public fun add_allowed_asset<T0>(arg0: &mut GuardrailsV2Builder, arg1: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg1);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.allowed_asset_types) < 64, 19);
        assert!(0x2::vec_set::length<NativeAssetBinding>(&arg0.allowed_native_assets) < 64, 19);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 18);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_asset_types, &v0), 10);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_asset_types, v0);
        let v1 = sui_asset_binding<T0>();
        assert!(!0x2::vec_set::contains<NativeAssetBinding>(&arg0.allowed_native_assets, &v1), 10);
        0x2::vec_set::insert<NativeAssetBinding>(&mut arg0.allowed_native_assets, v1);
    }

    public fun add_allowed_chain(arg0: &mut GuardrailsV2Builder, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical::is_canonical_chain_id(&arg1), 9);
        assert!(0x2::vec_set::length<vector<u8>>(&arg0.allowed_chain_ids) < 64, 19);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.allowed_chain_ids, &arg1), 10);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.allowed_chain_ids, arg1);
    }

    public fun add_allowed_evm_asset(arg0: &mut GuardrailsV2Builder, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg3);
        insert_native_binding(arg0, checked_evm_binding(arg1, arg2));
    }

    public fun add_allowed_opportunity(arg0: &mut GuardrailsV2Builder, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg2);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical::is_canonical_opportunity_id(&arg1), 8);
        assert!(0x2::vec_set::length<vector<u8>>(&arg0.allowed_opportunity_ids) < 64, 19);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.allowed_opportunity_ids, &arg1), 10);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.allowed_opportunity_ids, arg1);
    }

    public fun add_allowed_solana_asset(arg0: &mut GuardrailsV2Builder, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg2);
        insert_native_binding(arg0, checked_solana_binding(arg1));
    }

    fun all_zero(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun allocation_allowed<T0>(arg0: &GuardrailsV2, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : bool {
        evaluate<T0>(arg0, &arg1, &arg2, arg3) == 0
    }

    public fun assert_allocation_allowed<T0>(arg0: &GuardrailsV2, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = evaluate<T0>(arg0, &arg1, &arg2, arg3);
        assert!(v0 == 0, v0);
    }

    fun assert_complete_builder(arg0: &GuardrailsV2Builder) {
        assert!(!0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.allowed_asset_types), 4);
        assert!(!0x2::vec_set::is_empty<vector<u8>>(&arg0.allowed_opportunity_ids), 5);
        assert!(!0x2::vec_set::is_empty<vector<u8>>(&arg0.allowed_chain_ids), 6);
        assert!(arg0.max_allocation_bps >= 1 && arg0.max_allocation_bps <= 10000, 7);
    }

    fun assert_lead(arg0: &GuardrailsV2Builder, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.strategy_lead == 0x2::tx_context::sender(arg1), 3);
    }

    public(friend) fun assert_native_allocation_allowed(arg0: &GuardrailsV2, arg1: &NativeAssetBinding, arg2: vector<u8>, arg3: u64) {
        assert_native_asset_and_chain_allowed(arg0, arg1);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.policy.allowed_opportunity_ids, &arg2), 15);
        assert!(arg3 > 0 && arg3 <= arg0.policy.max_allocation_bps, 17);
    }

    public(friend) fun assert_native_asset_and_chain_allowed(arg0: &GuardrailsV2, arg1: &NativeAssetBinding) {
        assert!(verify_hash(arg0), 1);
        validate_predicate_shape(&arg0.policy.predicates);
        assert_native_asset_binding(arg1);
        assert!(0x2::vec_set::contains<NativeAssetBinding>(&arg0.policy.allowed_native_assets, arg1), 14);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.policy.allowed_chain_ids, &arg1.chain_id), 16);
    }

    public(friend) fun assert_native_asset_binding(arg0: &NativeAssetBinding) {
        assert!(arg0.schema_version == 1, 23);
        if (arg0.kind == 1) {
            assert!(arg0.chain_id == b"sui", 21);
            assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.original_id_type), 21);
            assert!(0x1::vector::is_empty<u8>(&arg0.native_id), 21);
            assert!(!0x1::type_name::is_primitive(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.original_id_type)), 21);
        } else if (arg0.kind == 2) {
            assert!(arg0.chain_id == b"solana", 21);
            assert!(!0x1::option::is_some<0x1::type_name::TypeName>(&arg0.original_id_type), 21);
            assert!(0x1::vector::length<u8>(&arg0.native_id) == 32, 21);
            assert!(!all_zero(&arg0.native_id), 21);
        } else {
            assert!(arg0.kind == 3, 20);
            assert!(arg0.chain_id == b"base" || arg0.chain_id == b"arbitrum", 21);
            assert!(!0x1::option::is_some<0x1::type_name::TypeName>(&arg0.original_id_type), 21);
            assert!(0x1::vector::length<u8>(&arg0.native_id) == 20, 21);
            assert!(!all_zero(&arg0.native_id), 21);
        };
    }

    public fun asset_type_count(arg0: &GuardrailsV2) : u64 {
        0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.policy.allowed_asset_types)
    }

    fun canonical_predicates() : vector<PredicateDescriptor> {
        let v0 = PredicateDescriptor{tag: 1};
        let v1 = PredicateDescriptor{tag: 2};
        let v2 = PredicateDescriptor{tag: 3};
        let v3 = PredicateDescriptor{tag: 4};
        let v4 = 0x1::vector::empty<PredicateDescriptor>();
        let v5 = &mut v4;
        0x1::vector::push_back<PredicateDescriptor>(v5, v0);
        0x1::vector::push_back<PredicateDescriptor>(v5, v1);
        0x1::vector::push_back<PredicateDescriptor>(v5, v2);
        0x1::vector::push_back<PredicateDescriptor>(v5, v3);
        v4
    }

    public fun canonical_preimage(arg0: &GuardrailsV2) : vector<u8> {
        arg0.canonical_preimage
    }

    public fun chain_count(arg0: &GuardrailsV2) : u64 {
        0x2::vec_set::length<vector<u8>>(&arg0.policy.allowed_chain_ids)
    }

    fun checked_evm_binding(arg0: vector<u8>, arg1: vector<u8>) : NativeAssetBinding {
        assert!(arg0 == b"base" || arg0 == b"arbitrum", 21);
        assert!(0x1::vector::length<u8>(&arg1) == 20, 21);
        assert!(!all_zero(&arg1), 21);
        NativeAssetBinding{
            schema_version   : 1,
            kind             : 3,
            chain_id         : arg0,
            original_id_type : 0x1::option::none<0x1::type_name::TypeName>(),
            native_id        : arg1,
        }
    }

    fun checked_solana_binding(arg0: vector<u8>) : NativeAssetBinding {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 21);
        assert!(!all_zero(&arg0), 21);
        NativeAssetBinding{
            schema_version   : 1,
            kind             : 2,
            chain_id         : b"solana",
            original_id_type : 0x1::option::none<0x1::type_name::TypeName>(),
            native_id        : arg0,
        }
    }

    fun evaluate<T0>(arg0: &GuardrailsV2, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : u64 {
        validate_predicate_shape(&arg0.policy.predicates);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = &arg0.policy.predicates;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PredicateDescriptor>(v1)) {
            let v3 = 0x1::vector::borrow<PredicateDescriptor>(v1, v2).tag;
            if (v3 == 1) {
                if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.policy.allowed_asset_types, &v0)) {
                    return 14
                };
            } else if (v3 == 2) {
                if (!0x2::vec_set::contains<vector<u8>>(&arg0.policy.allowed_opportunity_ids, arg1)) {
                    return 15
                };
            } else if (v3 == 3) {
                if (!0x2::vec_set::contains<vector<u8>>(&arg0.policy.allowed_chain_ids, arg2)) {
                    return 16
                };
            } else if (v3 == 4) {
                if (arg3 == 0 || arg3 > arg0.policy.max_allocation_bps) {
                    return 17
                };
            } else {
                return 12
            };
            v2 = v2 + 1;
        };
        0
    }

    fun finalize(arg0: GuardrailsV2Builder, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : GuardrailsV2 {
        assert_lead(&arg0, arg2);
        assert_complete_builder(&arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        let v0 = policy_from_builder(&arg0);
        validate_predicate_shape(&v0.predicates);
        let v1 = 0x1::bcs::to_bytes<Tier1Policy>(&v0);
        assert!(0x1::hash::sha2_256(v1) == arg1, 1);
        let GuardrailsV2Builder {
            id                      : v2,
            strategy_lead           : _,
            allowed_asset_types     : _,
            allowed_native_assets   : _,
            allowed_opportunity_ids : _,
            allowed_chain_ids       : _,
            max_allocation_bps      : _,
        } = arg0;
        0x2::object::delete(v2);
        GuardrailsV2{
            id                 : 0x2::object::new(arg2),
            guardrails_hash    : arg1,
            canonical_preimage : v1,
            policy             : v0,
        }
    }

    public fun finalize_and_freeze(arg0: GuardrailsV2Builder, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = finalize(arg0, arg1, arg2);
        let v1 = 0x2::object::id<GuardrailsV2>(&v0);
        let v2 = GuardrailsV2Created{
            guardrails_id      : v1,
            guardrails_hash    : v0.guardrails_hash,
            strategy_lead      : v0.policy.strategy_lead,
            asset_type_count   : 0x2::vec_set::length<0x1::type_name::TypeName>(&v0.policy.allowed_asset_types),
            opportunity_count  : 0x2::vec_set::length<vector<u8>>(&v0.policy.allowed_opportunity_ids),
            chain_count        : 0x2::vec_set::length<vector<u8>>(&v0.policy.allowed_chain_ids),
            max_allocation_bps : v0.policy.max_allocation_bps,
        };
        0x2::event::emit<GuardrailsV2Created>(v2);
        0x2::transfer::freeze_object<GuardrailsV2>(v0);
        v1
    }

    public fun guardrails_hash(arg0: &GuardrailsV2) : vector<u8> {
        arg0.guardrails_hash
    }

    fun insert_native_binding(arg0: &mut GuardrailsV2Builder, arg1: NativeAssetBinding) {
        assert_native_asset_binding(&arg1);
        assert!(0x2::vec_set::length<NativeAssetBinding>(&arg0.allowed_native_assets) < 64, 19);
        assert!(!0x2::vec_set::contains<NativeAssetBinding>(&arg0.allowed_native_assets, &arg1), 10);
        0x2::vec_set::insert<NativeAssetBinding>(&mut arg0.allowed_native_assets, arg1);
    }

    public fun matches_hash(arg0: &GuardrailsV2, arg1: vector<u8>) : bool {
        arg1 == arg0.guardrails_hash
    }

    public fun max_allocation_bps(arg0: &GuardrailsV2) : u64 {
        arg0.policy.max_allocation_bps
    }

    public(friend) fun native_asset_binding_from_policy(arg0: &GuardrailsV2, arg1: vector<u8>, arg2: vector<u8>) : NativeAssetBinding {
        assert!(verify_hash(arg0), 1);
        let v0 = 0x2::vec_set::keys<NativeAssetBinding>(&arg0.policy.allowed_native_assets);
        let v1 = 0;
        while (v1 < 0x1::vector::length<NativeAssetBinding>(v0)) {
            let v2 = 0x1::vector::borrow<NativeAssetBinding>(v0, v1);
            assert_native_asset_binding(v2);
            if (v2.chain_id == arg1 && v2.native_id == arg2) {
                assert!(v2.kind != 1, 22);
                return *v2
            };
            v1 = v1 + 1;
        };
        abort 22
    }

    public(friend) fun native_asset_canonical_v1_bytes(arg0: &NativeAssetBinding) : vector<u8> {
        assert_native_asset_binding(arg0);
        0x1::bcs::to_bytes<NativeAssetBinding>(arg0)
    }

    public(friend) fun native_asset_chain_id(arg0: &NativeAssetBinding) : vector<u8> {
        assert_native_asset_binding(arg0);
        arg0.chain_id
    }

    public fun new_builder(arg0: &mut 0x2::tx_context::TxContext) : GuardrailsV2Builder {
        GuardrailsV2Builder{
            id                      : 0x2::object::new(arg0),
            strategy_lead           : 0x2::tx_context::sender(arg0),
            allowed_asset_types     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allowed_native_assets   : 0x2::vec_set::empty<NativeAssetBinding>(),
            allowed_opportunity_ids : 0x2::vec_set::empty<vector<u8>>(),
            allowed_chain_ids       : 0x2::vec_set::empty<vector<u8>>(),
            max_allocation_bps      : 0,
        }
    }

    public fun opportunity_count(arg0: &GuardrailsV2) : u64 {
        0x2::vec_set::length<vector<u8>>(&arg0.policy.allowed_opportunity_ids)
    }

    fun policy_from_builder(arg0: &GuardrailsV2Builder) : Tier1Policy {
        Tier1Policy{
            schema_version          : 2,
            strategy_lead           : arg0.strategy_lead,
            predicates              : canonical_predicates(),
            allowed_asset_types     : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical::sorted_asset_types(&arg0.allowed_asset_types),
            allowed_native_assets   : sorted_native_bindings(&arg0.allowed_native_assets),
            allowed_opportunity_ids : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical::sorted_byte_values(&arg0.allowed_opportunity_ids),
            allowed_chain_ids       : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2_canonical::sorted_byte_values(&arg0.allowed_chain_ids),
            max_allocation_bps      : arg0.max_allocation_bps,
        }
    }

    public fun preview_hash(arg0: &GuardrailsV2Builder) : vector<u8> {
        0x1::hash::sha2_256(preview_preimage(arg0))
    }

    public fun preview_preimage(arg0: &GuardrailsV2Builder) : vector<u8> {
        let v0 = policy_from_builder(arg0);
        0x1::bcs::to_bytes<Tier1Policy>(&v0)
    }

    public(friend) fun same_native_asset_binding(arg0: &NativeAssetBinding, arg1: &NativeAssetBinding) : bool {
        assert_native_asset_binding(arg0);
        assert_native_asset_binding(arg1);
        if (arg0.schema_version == arg1.schema_version) {
            if (arg0.kind == arg1.kind) {
                if (arg0.chain_id == arg1.chain_id) {
                    if (arg0.original_id_type == arg1.original_id_type) {
                        arg0.native_id == arg1.native_id
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun schema_version(arg0: &GuardrailsV2) : u64 {
        arg0.policy.schema_version
    }

    public fun set_max_allocation_bps(arg0: &mut GuardrailsV2Builder, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_lead(arg0, arg2);
        assert!(arg0.max_allocation_bps == 0, 11);
        assert!(arg1 >= 1 && arg1 <= 10000, 7);
        arg0.max_allocation_bps = arg1;
    }

    fun sorted_native_bindings(arg0: &0x2::vec_set::VecSet<NativeAssetBinding>) : 0x2::vec_set::VecSet<NativeAssetBinding> {
        let v0 = 0x2::vec_set::into_keys<NativeAssetBinding>(*arg0);
        let v1 = 0x1::vector::length<NativeAssetBinding>(&v0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v2 + 1;
            while (v3 < v1) {
                let _ = 0x1::bcs::to_bytes<NativeAssetBinding>(0x1::vector::borrow<NativeAssetBinding>(&v0, v3));
                let _ = 0x1::bcs::to_bytes<NativeAssetBinding>(0x1::vector::borrow<NativeAssetBinding>(&v0, v2));
                v3 = v3 + 1;
            };
            if (v2 != v2) {
                0x1::vector::swap<NativeAssetBinding>(&mut v0, v2, v2);
            };
            v2 = v2 + 1;
        };
        0x2::vec_set::from_keys<NativeAssetBinding>(v0)
    }

    public fun strategy_lead(arg0: &GuardrailsV2) : address {
        arg0.policy.strategy_lead
    }

    public(friend) fun sui_asset_binding<T0>() : NativeAssetBinding {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 18);
        NativeAssetBinding{
            schema_version   : 1,
            kind             : 1,
            chain_id         : b"sui",
            original_id_type : 0x1::option::some<0x1::type_name::TypeName>(v0),
            native_id        : b"",
        }
    }

    fun validate_predicate_shape(arg0: &vector<PredicateDescriptor>) {
        assert!(0x1::vector::length<PredicateDescriptor>(arg0) == 4, 13);
        let v0 = false;
        let v1 = false;
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<PredicateDescriptor>(arg0)) {
            let v5 = 0x1::vector::borrow<PredicateDescriptor>(arg0, v4).tag;
            if (v5 == 1) {
                assert!(!v0, 11);
                v0 = true;
            } else if (v5 == 2) {
                assert!(!v1, 11);
                v1 = true;
            } else if (v5 == 3) {
                assert!(!v2, 11);
                v2 = true;
            } else {
                assert!(v5 == 4, 12);
                assert!(!v3, 11);
                v3 = true;
            };
            v4 = v4 + 1;
        };
        let v6 = if (v0) {
            if (v1) {
                if (v2) {
                    v3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13);
    }

    public fun verify_hash(arg0: &GuardrailsV2) : bool {
        let v0 = 0x1::bcs::to_bytes<Tier1Policy>(&arg0.policy);
        v0 == arg0.canonical_preimage && 0x1::hash::sha2_256(v0) == arg0.guardrails_hash
    }

    // decompiled from Move bytecode v7
}

